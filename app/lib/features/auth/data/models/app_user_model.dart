import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/app_role.dart';
import '../../domain/entities/app_user.dart';

part 'app_user_model.freezed.dart';
part 'app_user_model.g.dart';

/// casinos/{casinoId}/users/{uid} — written only by the setUserRole action.
@freezed
abstract class AppUserModel with _$AppUserModel {
  const AppUserModel._();

  const factory AppUserModel({
    required String id,
    @Default('') String name,
    @Default('auditor') String role,
    String? creditRole,
    String? email,
  }) = _AppUserModel;

  factory AppUserModel.fromJson(Map<String, dynamic> json) => _$AppUserModelFromJson(json);

  factory AppUserModel.fromEntity(AppUser u) =>
      AppUserModel(id: u.id, name: u.name, role: u.role.wire, creditRole: u.creditRole?.wire, email: u.email);

  AppUser toEntity() =>
      AppUser(id: id, name: name, role: AppRole.fromWire(role), creditRole: CreditRole.fromWire(creditRole), email: email);
}
