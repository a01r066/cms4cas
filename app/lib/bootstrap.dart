import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/local_backend.dart';
import 'app/session_cleanup.dart';
import 'core/session/before_sign_out_hooks.dart';
import 'firebase_options_dev.dart' as dev_options;
import 'firebase_options_prod.dart' as prod_options;
import 'flavors.dart';
import 'shared/providers/backend_providers.dart';
import 'shared/providers/prefs_provider.dart';

/// Init order: bindings → orientation → Firebase → App Check → prefs →
/// ProviderContainer → Crashlytics handlers → eager providers → runApp.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Pit tablets, cage desktops and phones: every orientation is useful.
  if (!kIsWeb) await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

  if (F.useFirebase) {
    // DEFAULT app with flavor options, so every plugin's `.instance` uses this project.
    await Firebase.initializeApp(options: _flavorOptions());
    await _activateAppCheck();
    // Shared pit/cage devices: never keep patron data on disk.
    FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: false);
  }

  final prefs = await SharedPreferences.getInstance();

  final container = ProviderContainer(overrides: [
    prefsProvider.overrideWithValue(prefs),
    localFunctionHandlersProvider.overrideWithValue(localFunctionHandlers()),
  ]);

  if (F.useFirebase && !kIsWeb) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(F.isProd);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  // Eager providers: must exist before any UI.
  container.read(sessionCleanupProvider);
  if (F.useFirebase) {
    // Queued offline writes need the operator still signed in.
    container.read(beforeSignOutHooksProvider).register(
          'firestore-pending-writes',
          () => FirebaseFirestore.instance.waitForPendingWrites(),
        );
  }

  runApp(UncontrolledProviderScope(container: container, child: const CmsApp()));
}

FirebaseOptions _flavorOptions() => switch (F.appFlavor) {
      Flavor.dev => dev_options.DefaultFirebaseOptions.currentPlatform,
      Flavor.prod => prod_options.DefaultFirebaseOptions.currentPlatform,
    };

Future<void> _activateAppCheck() async {
  if (kIsWeb && F.appCheckWebKey.isEmpty) {
    debugPrint('App Check not activated on web: pass --dart-define=APPCHECK_WEB_KEY=<reCAPTCHA v3 site key>.');
    return;
  }
  // Real attestation (Play Integrity, App Attest/DeviceCheck) only in prod *release* builds:
  // it does not work on simulators/emulators or in debug builds. Everything else uses the
  // debug provider, optionally with a fixed token (--dart-define=APPCHECK_DEBUG_TOKEN=<uuid>)
  // registered once per project in Firebase console → App Check → Apps → Manage debug tokens.
  final attest = F.isProd && kReleaseMode;
  final debugToken = F.appCheckDebugToken.isEmpty ? null : F.appCheckDebugToken;
  await FirebaseAppCheck.instance.activate(
    providerWeb: kIsWeb ? ReCaptchaV3Provider(F.appCheckWebKey) : null,
    providerAndroid: attest ? const AndroidPlayIntegrityProvider() : AndroidDebugProvider(debugToken: debugToken),
    providerApple: attest ? const AppleAppAttestWithDeviceCheckFallbackProvider() : AppleDebugProvider(debugToken: debugToken),
  );
}
