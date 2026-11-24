import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failure.dart';

part 'demo_data_state.freezed.dart';

@freezed
abstract class DemoDataState with _$DemoDataState {
  const factory DemoDataState({
    @Default(false) bool busy,
    Failure? failure,
  }) = _DemoDataState;
}
