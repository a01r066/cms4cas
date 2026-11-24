import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_role.dart';

part 'app_user.freezed.dart';

/// A casino operator with a CMS role and, optionally, a credit signing role (Table 6.2).
@freezed
abstract class AppUser with _$AppUser {
  const AppUser._();

  const factory AppUser({
    required String id,
    required String name,
    required AppRole role,
    CreditRole? creditRole,
    String? email,
  }) = _AppUser;

  bool can(Perm p) => role.perms.contains(p);
  bool get canSignCredit => creditRole != null && can(Perm.creditApprove);
}
