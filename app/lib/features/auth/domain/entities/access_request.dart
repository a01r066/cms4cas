import 'package:freezed_annotation/freezed_annotation.dart';

part 'access_request.freezed.dart';

/// Someone who registered with email/password and is waiting for an
/// administrator to give them a CMS role. Registering never grants access.
@freezed
abstract class AccessRequest with _$AccessRequest {
  const factory AccessRequest({
    required String uid,
    required String name,
    required String email,
    required DateTime requestedAt,
  }) = _AccessRequest;
}
