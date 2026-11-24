import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';

@freezed
abstract class Player with _$Player {
  const Player._();

  const factory Player({
    required String id,
    required String name,
    @Default('') String playerNo,
    @Default('') String idDocument,
    @Default('') String address,
    @Default('') String notes,
    required String createdBy,
    required DateTime createdAt,
  }) = _Player;

  /// ID and address on file let currency reports be completed without interrupting play (Ch5 p.72).
  bool get hasIdOnFile => idDocument.trim().isNotEmpty && address.trim().isNotEmpty;
}
