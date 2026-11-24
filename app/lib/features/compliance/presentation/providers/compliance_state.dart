import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failure.dart';

part 'compliance_state.freezed.dart';

@freezed
abstract class ComplianceState with _$ComplianceState {
  const factory ComplianceState({
    @Default(false) bool saving,
    Failure? failure,
  }) = _ComplianceState;
}
