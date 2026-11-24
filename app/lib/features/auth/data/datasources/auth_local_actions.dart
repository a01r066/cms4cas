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
    await c.member(roles: {AppRole.admin.wire});
  }
  final uid = c.str('uid', required: false).isNotEmpty ? c.str('uid') : newId();
  await c.store.put('users', uid, {
    'id': uid,
    'name': name,
    'role': role,
    'creditRole': creditRole,
    'email': c.data['email'],
  });
  return {'ok': true, 'uid': uid};
}
