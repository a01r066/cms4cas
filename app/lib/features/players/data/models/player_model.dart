import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/player.dart';

part 'player_model.freezed.dart';
part 'player_model.g.dart';

/// casinos/{casinoId}/players/{id}
@freezed
abstract class PlayerModel with _$PlayerModel {
  const PlayerModel._();

  const factory PlayerModel({
    required String id,
    @Default('') String name,
    @Default('') String playerNo,
    @Default('') String idDocument,
    @Default('') String address,
    @Default('') String notes,
    @Default('') String createdBy,
    required DateTime createdAt,
  }) = _PlayerModel;

  factory PlayerModel.fromJson(Map<String, dynamic> json) => _$PlayerModelFromJson(json);

  factory PlayerModel.fromEntity(Player p) => PlayerModel(
        id: p.id,
        name: p.name,
        playerNo: p.playerNo,
        idDocument: p.idDocument,
        address: p.address,
        notes: p.notes,
        createdBy: p.createdBy,
        createdAt: p.createdAt,
      );

  Player toEntity() => Player(
        id: id,
        name: name,
        playerNo: playerNo,
        idDocument: idDocument,
        address: address,
        notes: notes,
        createdBy: createdBy,
        createdAt: createdAt,
      );
}
