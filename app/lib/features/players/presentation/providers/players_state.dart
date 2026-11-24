import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failure.dart';

part 'players_state.freezed.dart';

@freezed
abstract class PlayersState with _$PlayersState {
  const factory PlayersState({
    @Default(false) bool saving,
    Failure? failure,
  }) = _PlayersState;
}
