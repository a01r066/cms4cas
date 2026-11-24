import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

/// Casino-wide configuration. Defaults are the book's values (Nevada 2003);
/// every figure is editable so another jurisdiction needs no code change.
@freezed
abstract class AppSettings with _$AppSettings {
  const AppSettings._();

  const factory AppSettings({
    @Default('My Casino') String casinoName,
    @Default('Book reference (Nevada, 2003)') String jurisdictionLabel,
    @Default(AmlProfile.bookNevada2003) AmlProfile aml,
    @Default(CompPolicy()) CompPolicy comps,
    /// Flat rate used by the promotion calculators.
    @Default(0.0625) double gamingTaxRate,
    /// ±3 points around base hold (Nevada).
    @Default(0.03) double holdTolerance,
    /// gameId → house advantage override.
    @Default(<String, double>{}) Map<String, double> houseAdvantage,
    /// gameId → player type wire → multiplier override (null = type not offered).
    @Default(<String, Map<String, double?>>{}) Map<String, Map<String, double?>> multipliers,
    /// Documented "hit" threshold for hold adjustment (Ch13 p.249).
    @Default(10000) double ratingHitThreshold,
  }) = _AppSettings;

  GameRatingParams game(String id) {
    final g = RatingDefaults.byId(id);
    final m = multipliers[id];
    return GameRatingParams(
      id: g.id,
      name: g.name,
      houseAdvantage: houseAdvantage[id] ?? g.houseAdvantage,
      multipliers: m == null ? g.multipliers : {for (final t in PlayerType.values) t: m.containsKey(t.wire) ? m[t.wire] : g.multipliers[t]},
      decisionsByPlayers: g.decisionsByPlayers,
      sdPerDollar: g.sdPerDollar,
      source: g.source,
      decisionsFromBook: g.decisionsFromBook,
    );
  }

  List<GameRatingParams> get games => RatingDefaults.games.map((g) => game(g.id)).toList();
}
