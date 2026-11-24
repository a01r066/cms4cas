import 'package:cms_kiss/app/app.dart';
import 'package:cms_kiss/core/routing/app_router.dart';
import 'package:cms_kiss/core/routing/route_names.dart';
import 'package:cms_kiss/core/storage/local_record_store.dart';
import 'package:cms_kiss/core/backend/functions_gateway.dart';
import 'package:cms_kiss/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:cms_kiss/features/auth/data/models/access_request_model.dart';
import 'package:cms_kiss/features/auth/domain/entities/app_role.dart';
import 'package:cms_kiss/features/auth/presentation/providers/auth_notifier.dart';
import 'package:cms_kiss/features/auth/presentation/providers/auth_providers.dart';
import 'package:cms_kiss/shared/providers/backend_providers.dart';
import 'package:cms_kiss/shared/providers/prefs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

/// Firebase-shaped auth over the local store: register creates an account,
/// signs it in and files the access request — what FirebaseAuthRemoteDataSource does.
class FakeFirebaseAuth extends LocalAuthRemoteDataSource {
  FakeFirebaseAuth(super.prefs, super.store, super.functions);
  int _n = 0;
  final resets = <String>[];

  @override
  Future<String> register({required String name, required String email, required String password}) async {
    final uid = 'fb-${++_n}';
    await this.store.put('access_requests', uid,
        AccessRequestModel(id: uid, uid: uid, name: name, email: email, requestedAt: DateTime(2026, 11, 24)).toJson());
    await super.signInAs(uid);
    return uid;
  }

  @override
  Future<void> sendPasswordReset(String email) async => resets.add(email);

  @override
  bool get emailVerified => false;
}

void main() {
  group('Registration rules', () {
    test('validation', () {
      String? v(String n, String e, String p, String c) =>
          AuthNotifier.validateRegistration(name: n, email: e, password: p, confirmPassword: c);
      expect(v('A', 'a@b.co', 'password1', 'password1'), contains('name'));
      expect(v('Thanh', 'not-an-email', 'password1', 'password1'), contains('email'));
      expect(v('Thanh', 'thanh@cms4cas.store', 'short', 'short'), contains('8 characters'));
      expect(v('Thanh', 'thanh@cms4cas.store', 'password1', 'password2'), contains('do not match'));
      expect(v('Thanh', 'thanh@cms4cas.store', 'password1', 'password1'), isNull);
    });

    test('local backend refuses registration with a clear message', () async {
      final c = await localContainer();
      addTearDown(c.dispose);
      final r = await c.read(authNotifierProvider.notifier).register(
          name: 'Thanh', email: 'thanh@cms4cas.store', password: 'password1', confirmPassword: 'password1');
      expect(r.fold((f) => f.displayMessage, (_) => ''), contains('Firebase backend'));
    });
  });

  group('Approving registrations', () {
    test('admin assigns a role → profile created, request removed; others cannot', () async {
      final c = await localContainer();
      addTearDown(c.dispose);
      keepAlive(c, [accessRequestsProvider]);
      await store(c).put('access_requests', 'fb-9',
          AccessRequestModel(id: 'fb-9', uid: 'fb-9', name: 'New Dealer', email: 'dealer@cms4cas.store', requestedAt: DateTime(2026, 11, 24)).toJson());

      await signInAs(c, 'pit', {'name': 'Pit', 'role': 'pit_supervisor'});
      await settle();
      expect(c.read(accessRequestsProvider).value, isEmpty, reason: 'only admins see requests');

      await signInAs(c, 'admin', {'name': 'Admin', 'role': 'admin'});
      await settle();
      final req = c.read(accessRequestsProvider).value!.single;
      expect(req.email, 'dealer@cms4cas.store');

      final r = await c.read(authNotifierProvider.notifier).approveRequest(req, role: AppRole.pitSupervisor);
      expect(r.isRight(), isTrue, reason: r.fold((f) => f.displayMessage, (_) => ''));
      await settle();
      final profile = await store(c).get('users', 'fb-9');
      expect(profile?['role'], 'pit_supervisor');
      expect(profile?['email'], 'dealer@cms4cas.store');
      expect(await store(c).get('access_requests', 'fb-9'), isNull);
      expect(c.read(accessRequestsProvider).value, isEmpty);
    });

    test('admin can dismiss a request', () async {
      final c = await localContainer();
      addTearDown(c.dispose);
      keepAlive(c, [accessRequestsProvider]);
      await store(c).put('access_requests', 'x', AccessRequestModel(id: 'x', uid: 'x', name: 'Spam', email: 's@x.io', requestedAt: DateTime(2026, 11, 24)).toJson());
      await signInAs(c, 'admin', {'name': 'Admin', 'role': 'admin'});
      await settle();
      await c.read(authNotifierProvider.notifier).dismissRequest(c.read(accessRequestsProvider).value!.single);
      expect(await store(c).list('access_requests'), isEmpty);
    });
  });

  testWidgets('Register → waiting for a role → admin approves → modules open', (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final base = await localOverrides(const {}, Backend.firebase);
    late FakeFirebaseAuth fake;
    final c = ProviderContainer(overrides: [
      ...base,
      // Firebase UI paths, local storage and actions underneath.
      recordStoreProvider.overrideWith((ref) => LocalRecordStore(ref.watch(prefsProvider))),
      functionsGatewayProvider.overrideWith((ref) => LocalFunctionsGateway(
            store: ref.watch(recordStoreProvider),
            callerUid: () => ref.read(prefsServiceProvider).sessionUserId,
            handlers: ref.watch(localFunctionHandlersProvider),
          )),
      authDataSourceProvider.overrideWith((ref) => fake = FakeFirebaseAuth(
            ref.watch(prefsServiceProvider), ref.watch(recordStoreProvider), ref.watch(functionsGatewayProvider))),
    ]);
    addTearDown(c.dispose);
    // An existing administrator, so the newcomer cannot self-promote.
    await c.read(recordStoreProvider).put('users', 'admin', {'id': 'admin', 'name': 'Admin', 'role': 'admin'});

    await tester.pumpWidget(UncontrolledProviderScope(container: c, child: const CmsApp()));
    await tester.pumpAndSettle();
    expect(find.text('Forgot password?'), findsOneWidget);

    // Forgot password uses the typed email.
    await tester.enterText(find.widgetWithText(TextField, 'Email'), 'someone@cms4cas.store');
    await tester.tap(find.text('Forgot password?'));
    await tester.pumpAndSettle();
    expect(fake.resets, ['someone@cms4cas.store']);

    await tester.tap(find.text('Create an account'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextFormField, 'Full name'), 'Nguyen Thanh');
    await tester.enterText(find.widgetWithText(TextFormField, 'Work email'), 'thanh@cms4cas.store');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password1');
    await tester.enterText(find.widgetWithText(TextFormField, 'Confirm password'), 'password2');
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();
    expect(find.text('The passwords do not match'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextFormField, 'Confirm password'), 'password1');
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();
    expect(find.textContaining('waiting for an administrator'), findsOneWidget);
    expect(find.text('Resend verification email'), findsOneWidget);
    expect(await c.read(recordStoreProvider).get('access_requests', 'fb-1'), isNotNull);

    // Self-promotion is refused once the casino has an administrator.
    await tester.tap(find.text('Set up as first administrator'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'Nguyen Thanh');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Only an administrator'), findsOneWidget);
    Navigator.of(tester.element(find.text('Save'))).pop();
    await tester.pumpAndSettle();

    // Admin approves from another device: the waiting screen opens the app by itself.
    await c.read(recordStoreProvider).put('users', 'fb-1', {'id': 'fb-1', 'name': 'Nguyen Thanh', 'role': 'pit_supervisor'});
    await c.read(recordStoreProvider).delete('access_requests', 'fb-1');
    await tester.pumpAndSettle();
    expect(c.read(routerProvider).routeInformationProvider.value.uri.path, Routes.home);
    expect(find.text('Players & ratings'), findsWidgets);
  });
}
