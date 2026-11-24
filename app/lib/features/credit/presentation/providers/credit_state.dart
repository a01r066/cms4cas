import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failure.dart';

part 'credit_state.freezed.dart';

@freezed
abstract class CreditState with _$CreditState {
  const factory CreditState({
    @Default(false) bool saving,
    Failure? failure,
  }) = _CreditState;
}
