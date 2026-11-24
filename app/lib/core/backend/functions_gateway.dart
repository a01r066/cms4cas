import 'package:cloud_functions/cloud_functions.dart';

import '../error/exceptions.dart';
import '../storage/record_store.dart';
import '../typedefs/typedefs.dart';

/// Privileged writes — roles, credit decisions, markers, CTR filing — never go
/// straight from the client to the database. They are named actions executed by
/// Cloud Functions (firebase/functions/src/index.js), or, on the local backend,
/// by Dart handlers that apply the same checks.
abstract interface class FunctionsGateway {
  Future<Json> call(String name, Json data);
}

class FirebaseFunctionsGateway implements FunctionsGateway {
  FirebaseFunctionsGateway(this._functions, this._casinoId);

  final FirebaseFunctions _functions;
  final String _casinoId;

  @override
  Future<Json> call(String name, Json data) async {
    final res = await _functions.httpsCallable(name).call<Object?>({...data, 'casinoId': _casinoId});
    final d = res.data;
    return d is Map ? Map<String, dynamic>.from(d) : <String, dynamic>{};
  }
}

/// Context a local handler receives — the equivalent of `request.auth` + Admin SDK.
class LocalCall {
  const LocalCall({required this.uid, required this.store, required this.data});

  final String? uid;
  final RecordStore store;
  final Json data;

  /// Like `HttpsError`: thrown with a message for the user.
  Never fail(String code, String message) => throw ServerException(code, message);

  String str(String key, {bool required = true}) {
    final v = data[key];
    if (v is String && v.trim().isNotEmpty) return v.trim();
    if (required) fail('invalid-argument', 'Missing $key.');
    return '';
  }

  /// The caller's profile in `users`, like reading casinos/{cid}/users/{uid} with the Admin SDK.
  Future<Json> member({Set<String>? roles}) async {
    if (uid == null) fail('unauthenticated', 'Sign in first.');
    final p = await store.get('users', uid!);
    if (p == null) fail('permission-denied', 'Your account has no CMS role.');
    if (roles != null && !roles.contains(p['role'])) fail('permission-denied', 'Your role cannot perform this action.');
    return p;
  }

  double number(String key) {
    final v = data[key];
    if (v is num && v.isFinite) return v.toDouble();
    fail('invalid-argument', 'Missing or invalid $key.');
  }
}

typedef LocalFunction = Future<Json> Function(LocalCall call);

class LocalFunctionsGateway implements FunctionsGateway {
  LocalFunctionsGateway({required this.store, required this.callerUid, required this.handlers});

  final RecordStore store;
  final String? Function() callerUid;
  final Map<String, LocalFunction> handlers;

  @override
  Future<Json> call(String name, Json data) {
    final h = handlers[name];
    if (h == null) throw ServerException('not-found', 'Action "$name" is not available.');
    return h(LocalCall(uid: callerUid(), store: store, data: data));
  }
}
