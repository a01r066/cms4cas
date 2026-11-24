import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/backend/functions_gateway.dart';
import '../../core/storage/firestore_record_store.dart';
import '../../core/storage/local_record_store.dart';
import '../../core/storage/record_store.dart';
import '../../flavors.dart';
import 'firebase_providers.dart';
import 'prefs_provider.dart';

enum Backend { local, firebase }

/// Which backend this build talks to. Tests override it.
final backendProvider = Provider<Backend>((ref) => F.useFirebase ? Backend.firebase : Backend.local);

final casinoIdProvider = Provider<String>((ref) => F.casinoId);

final recordStoreProvider = Provider<RecordStore>((ref) => switch (ref.watch(backendProvider)) {
      Backend.firebase => FirestoreRecordStore(ref.watch(firestoreProvider), ref.watch(casinoIdProvider)),
      Backend.local => LocalRecordStore(ref.watch(prefsProvider)),
    });

/// Local action handlers, composed in app/local_backend.dart (overridden in bootstrap and tests).
final localFunctionHandlersProvider = Provider<Map<String, LocalFunction>>((ref) => const {});

final functionsGatewayProvider = Provider<FunctionsGateway>((ref) => switch (ref.watch(backendProvider)) {
      Backend.firebase => FirebaseFunctionsGateway(ref.watch(functionsProvider), ref.watch(casinoIdProvider)),
      Backend.local => LocalFunctionsGateway(
          store: ref.watch(recordStoreProvider),
          callerUid: () => ref.read(prefsServiceProvider).sessionUserId,
          handlers: ref.watch(localFunctionHandlersProvider),
        ),
    });
