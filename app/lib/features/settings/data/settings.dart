import 'package:casino_engine/casino_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/data/repository.dart';
import '../../../shared/providers.dart';

/// Casino-wide configuration. Defaults are the book's values (Nevada 2003); everything is editable.
class AppSettings {
  final String casinoName;
  final String jurisdictionLabel;
  final AmlProfile aml;
  final CompPolicy comps;
  final double gamingTaxRate; // flat rate used by promotion calculators
  final double holdTolerance; // ±3 points (NV)
  final Map<String, double> houseAdvantage; // gameId → HA override
  final Map<String, Map<String, double?>> multipliers; // gameId → type → multiplier
  final double ratingHitThreshold; // documented "hit" threshold for hold adjustment

  const AppSettings({
    this.casinoName = 'My Casino',
    this.jurisdictionLabel = 'Book reference (Nevada, 2003)',
    this.aml = AmlProfile.bookNevada2003,
    this.comps = const CompPolicy(),
    this.gamingTaxRate = 0.0625,
    this.holdTolerance = 0.03,
    this.houseAdvantage = const {},
    this.multipliers = const {},
    this.ratingHitThreshold = 10000,
  });

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

  Map<String, dynamic> toJson() => {
        'casinoName': casinoName,
        'jurisdictionLabel': jurisdictionLabel,
        'aml': {
          'regime': aml.regime.wire,
          'ctrThreshold': aml.ctrThreshold,
          'mtlThreshold': aml.mtlThreshold,
          'cashForCashLimit': aml.cashForCashLimit,
          'casinoCheckForCashLimit': aml.casinoCheckForCashLimit,
          'sarThreshold': aml.sarThreshold,
          'sarFileDays': aml.sarFileDays,
          'sarExtensionDays': aml.sarExtensionDays,
          'gamingDayStartHour': aml.gamingDayStartHour,
          'nearThresholdPct': aml.nearThresholdPct,
        },
        'comps': {'pctOfTheo': comps.pctOfTheo, 'quickLossPctOfActual': comps.quickLossPctOfActual, 'quickLossEnabled': comps.quickLossEnabled},
        'gamingTaxRate': gamingTaxRate,
        'holdTolerance': holdTolerance,
        'houseAdvantage': houseAdvantage,
        'multipliers': multipliers,
        'ratingHitThreshold': ratingHitThreshold,
      };

  static double _d(Object? v, double def) => v is num ? v.toDouble() : def;

  factory AppSettings.fromJson(Map<String, dynamic> j) {
    final a = Map<String, dynamic>.from((j['aml'] ?? {}) as Map);
    final c = Map<String, dynamic>.from((j['comps'] ?? {}) as Map);
    const d = AmlProfile.bookNevada2003;
    return AppSettings(
      casinoName: (j['casinoName'] ?? 'My Casino') as String,
      jurisdictionLabel: (j['jurisdictionLabel'] ?? 'Book reference (Nevada, 2003)') as String,
      aml: AmlProfile(
        regime: AggregationRegime.fromWire((a['regime'] ?? 'reg6a') as String),
        ctrThreshold: _d(a['ctrThreshold'], d.ctrThreshold),
        mtlThreshold: _d(a['mtlThreshold'], d.mtlThreshold),
        cashForCashLimit: _d(a['cashForCashLimit'], d.cashForCashLimit),
        casinoCheckForCashLimit: _d(a['casinoCheckForCashLimit'], d.casinoCheckForCashLimit),
        sarThreshold: _d(a['sarThreshold'], d.sarThreshold),
        sarFileDays: (a['sarFileDays'] as num?)?.toInt() ?? d.sarFileDays,
        sarExtensionDays: (a['sarExtensionDays'] as num?)?.toInt() ?? d.sarExtensionDays,
        gamingDayStartHour: (a['gamingDayStartHour'] as num?)?.toInt() ?? d.gamingDayStartHour,
        nearThresholdPct: _d(a['nearThresholdPct'], d.nearThresholdPct),
      ),
      comps: CompPolicy(
        pctOfTheo: _d(c['pctOfTheo'], 0.45),
        quickLossPctOfActual: _d(c['quickLossPctOfActual'], 0.15),
        quickLossEnabled: (c['quickLossEnabled'] ?? true) as bool,
      ),
      gamingTaxRate: _d(j['gamingTaxRate'], 0.0625),
      holdTolerance: _d(j['holdTolerance'], 0.03),
      houseAdvantage: Map<String, dynamic>.from((j['houseAdvantage'] ?? {}) as Map).map((k, v) => MapEntry(k, (v as num).toDouble())),
      multipliers: Map<String, dynamic>.from((j['multipliers'] ?? {}) as Map).map((k, v) => MapEntry(
          k, Map<String, dynamic>.from(v as Map).map((t, x) => MapEntry(t, x == null ? null : (x as num).toDouble())))),
      ratingHitThreshold: _d(j['ratingHitThreshold'], 10000),
    );
  }

  AppSettings copyWith({
    String? casinoName,
    String? jurisdictionLabel,
    AmlProfile? aml,
    CompPolicy? comps,
    double? gamingTaxRate,
    double? holdTolerance,
    Map<String, double>? houseAdvantage,
    Map<String, Map<String, double?>>? multipliers,
    double? ratingHitThreshold,
  }) =>
      AppSettings(
        casinoName: casinoName ?? this.casinoName,
        jurisdictionLabel: jurisdictionLabel ?? this.jurisdictionLabel,
        aml: aml ?? this.aml,
        comps: comps ?? this.comps,
        gamingTaxRate: gamingTaxRate ?? this.gamingTaxRate,
        holdTolerance: holdTolerance ?? this.holdTolerance,
        houseAdvantage: houseAdvantage ?? this.houseAdvantage,
        multipliers: multipliers ?? this.multipliers,
        ratingHitThreshold: ratingHitThreshold ?? this.ratingHitThreshold,
      );
}

final settingsRepoProvider =
    Provider((ref) => Repository<AppSettings>(ref.watch(recordStoreProvider), 'settings', AppSettings.fromJson, (s) => s.toJson()));

final settingsStreamProvider = StreamProvider<AppSettings>((ref) => ref
    .watch(settingsRepoProvider)
    .watch()
    .map((l) => l.isEmpty ? const AppSettings() : l.first));

final settingsProvider = Provider<AppSettings>((ref) => ref.watch(settingsStreamProvider).value ?? const AppSettings());

Future<void> saveSettings(WidgetRef ref, AppSettings s) async {
  final r = await ref.read(settingsRepoProvider).save('main', s);
  r.fold((f) => throw f, (_) {});
}
