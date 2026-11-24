import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/access_request.dart';

part 'access_request_model.freezed.dart';
part 'access_request_model.g.dart';

/// casinos/{casinoId}/access_requests/{uid} — written by the registrant for
/// their own uid only; removed by setUserRole when an admin assigns a role.
@freezed
abstract class AccessRequestModel with _$AccessRequestModel {
  const AccessRequestModel._();

  const factory AccessRequestModel({
    required String id,
    required String uid,
    @Default('') String name,
    @Default('') String email,
    required DateTime requestedAt,
  }) = _AccessRequestModel;

  factory AccessRequestModel.fromJson(Map<String, dynamic> json) => _$AccessRequestModelFromJson(json);

  factory AccessRequestModel.fromEntity(AccessRequest r) =>
      AccessRequestModel(id: r.uid, uid: r.uid, name: r.name, email: r.email, requestedAt: r.requestedAt);

  AccessRequest toEntity() => AccessRequest(uid: uid, name: name, email: email, requestedAt: requestedAt);
}
