import 'package:casino_engine/casino_engine.dart';

import '../../../../core/backend/functions_gateway.dart';
import '../../../../core/util/ids.dart';
import '../../domain/entities/app_role.dart';

/// Local equivalent of the `setUserRole` Cloud Function. Keep in step with index.js:
/// only an admin assigns roles, except the very first user of an empty casino,
/// who may only make themself admin.
Map<String, LocalFunction> authLocalActions() => {'setUserRole': _setUserRole};

Future<Map<String, dynamic>> _setUserRole(LocalCall c) async {
  final name = c.str('name');
  final role = c.str('role');
  if (!AppRole.values.any((r) => r.wire == role)) c.fail('invalid-argument', 'Unknown role.');
  final creditRole = c.data['creditRole'] as String?;
  if (creditRole != null && CreditRole.fromWire(creditRole) == null) c.fail('invalid-argument', 'Unknown credit role.');

  final users = await c.store.list('users');
  if (users.isEmpty) {
    if (role != AppRole.admin.wire) c.fail('failed-precondition', 'The first user must be an administrator.');
  } else {
    if (c.uid == null) c.fail('unauthenticated', 'Sign in first.');
    final caller = await c.store.get('users', c.uid!);
    if (caller == null || caller['role'] != AppRole.admin.wire) {
      c.fail('permission-denied', 'Only an administrator can assign roles.');
    }
  }
  final uid = c.str('uid', required: false).isNotEmpty ? c.str('uid') : newId();
  await c.store.put('users', uid, {
    'id': uid,
    'name': name,
    'role': role,
    'creditRole': creditRole,
    'email': c.data['email'],
  });
  // A registrant who now has a role is no longer waiting.
  if (await c.store.get('access_requests', uid) != null) await c.store.delete('access_requests', uid);
  return {'ok': true, 'uid': uid};
}
