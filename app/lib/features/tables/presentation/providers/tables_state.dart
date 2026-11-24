import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failure.dart';

part 'tables_state.freezed.dart';

@freezed
abstract class TablesState with _$TablesState {
  const factory TablesState({
    @Default(false) bool saving,
    Failure? failure,
  }) = _TablesState;
}
