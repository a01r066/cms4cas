import 'dart:math' as math;
import 'book_ref.dart';
import 'stats.dart';

enum PlayerType {
  soft('soft', 'Soft'),
  average('average', 'Average'),
  hard('hard', 'Hard');

  final String wire;
  final String label;
  const PlayerType(this.wire, this.label);
  static PlayerType fromWire(String w) => values.firstWhere((t) => t.wire == w, orElse: () => average);
}

/// Rating parameters per game. Book values are flagged `fromBook`; app defaults are labelled.
class GameRatingParams {
  final String id;
  final String name;
  final double houseAdvantage; // system HA (Ch12)
  final Map<PlayerType, double?> multipliers; // null = type not used for this game
  final Map<int, double> decisionsByPlayers; // # players → decisions per hour
  final double sdPerDollar;
  final String source;
  final bool decisionsFromBook;

  const GameRatingParams({
    required this.id,
    required this.name,
    required this.houseAdvantage,
    required this.multipliers,
    required this.decisionsByPlayers,
    required this.sdPerDollar,
    required this.source,
    this.decisionsFromBook = true,
  });

  double effectiveAdvantage(PlayerType t) => houseAdvantage * (multipliers[t] ?? multipliers[PlayerType.average] ?? 1);

  /// Decisions per hour for an observed head count; linear interpolation between book points.
  double decisionsPerHour(int players) {
    final keys = decisionsByPlayers.keys.toList()..sort();
    if (players <= keys.first) return decisionsByPlayers[keys.first]!;
    if (players >= keys.last) return decisionsByPlayers[keys.last]!;
    for (var i = 0; i < keys.length - 1; i++) {
      final a = keys[i], b = keys[i + 1];
      if (players >= a && players <= b) {
        final fa = decisionsByPlayers[a]!, fb = decisionsByPlayers[b]!;
        return fa + (fb - fa) * (players - a) / (b - a);
      }
    }
    return decisionsByPlayers[keys.last]!;
  }
}

class RatingDefaults {
  static const ref = BookRef(12, '221–231', 'Player rating factors');
  static const refSpeed = BookRef(13, '251', 'Decisions per hour by players at the table (Table 13.1)');

  static const _bj = {1: 209.0, 2: 139.0, 3: 105.0, 4: 84.0, 5: 70.0, 6: 60.0, 7: 52.0};
  static const _dice = {1: 249.0, 3: 216.0, 5: 144.0, 7: 135.0, 9: 123.0, 11: 102.0};
  static const _roulette = {1: 112.0, 2: 76.0, 3: 60.0, 4: 55.0, 5: 48.0, 6: 35.0};

  static const games = <GameRatingParams>[
    GameRatingParams(id: 'blackjack', name: 'Blackjack', houseAdvantage: 0.0073,
        multipliers: {PlayerType.soft: 1.0, PlayerType.average: 1.0, PlayerType.hard: 1.0},
        decisionsByPlayers: _bj, sdPerDollar: 1.1225, source: 'Ch12 p.225; Table 13.1; SD p.369'),
    GameRatingParams(id: 'craps', name: 'Craps', houseAdvantage: 0.01,
        multipliers: {PlayerType.soft: 0.63, PlayerType.average: 0.37, PlayerType.hard: 0.178},
        decisionsByPlayers: _dice, sdPerDollar: 1.0, source: 'Ch12 p.227–228 (per throw); Table 13.1; SD app default'),
    GameRatingParams(id: 'roulette', name: 'Roulette (double zero)', houseAdvantage: 0.0526,
        multipliers: {PlayerType.soft: null, PlayerType.average: 1.0, PlayerType.hard: 0.51},
        decisionsByPlayers: _roulette, sdPerDollar: 0.998614, source: 'Ch12 p.228; Table 13.1; SD p.371'),
    GameRatingParams(id: 'baccarat', name: 'Baccarat / Mini baccarat', houseAdvantage: 0.0124,
        multipliers: {PlayerType.soft: 1.29, PlayerType.average: 1.0, PlayerType.hard: 0.85},
        decisionsByPlayers: {1: 60.0}, sdPerDollar: 0.9512,
        source: 'Ch12 p.229; 60 hands/hr as used p.268 & Table 16.2; SD p.366'),
    GameRatingParams(id: 'pai_gow', name: 'Pai gow', houseAdvantage: 0.0204,
        multipliers: {PlayerType.soft: 1.17, PlayerType.average: 1.0, PlayerType.hard: 0.74},
        decisionsByPlayers: {1: 30.0}, sdPerDollar: 1.0, decisionsFromBook: false,
        source: 'Ch12 p.230; hands/hr & SD are app defaults (book gives none)'),
    GameRatingParams(id: 'pai_gow_poker', name: 'Pai gow poker', houseAdvantage: 0.02032,
        multipliers: {PlayerType.soft: 1.4, PlayerType.average: 1.0, PlayerType.hard: 0.55},
        decisionsByPlayers: {1: 30.0}, sdPerDollar: 1.0, decisionsFromBook: false,
        source: 'Ch12 p.230; hands/hr & SD are app defaults (book gives none)'),
    GameRatingParams(id: 'caribbean_stud', name: 'Caribbean stud', houseAdvantage: 0.0547,
        multipliers: {PlayerType.soft: 1.30, PlayerType.average: 1.0, PlayerType.hard: 1.0},
        decisionsByPlayers: {1: 50.0}, sdPerDollar: 1.0, decisionsFromBook: false,
        source: 'Ch12 p.231; hands/hr & SD are app defaults (book gives none)'),
  ];

  static GameRatingParams byId(String id) => games.firstWhere((g) => g.id == id, orElse: () => games.first);
}

class RatingInput {
  final GameRatingParams game;
  final double averageBet; // initial bet only (p.225)
  final double minutes;
  final int players;
  final PlayerType type;
  final double? decisionsOverride;
  const RatingInput({
    required this.game,
    required this.averageBet,
    required this.minutes,
    required this.players,
    required this.type,
    this.decisionsOverride,
  });

  List<String> validate() => [
        if (averageBet <= 0) 'Average bet must be greater than 0',
        if (minutes <= 0) 'Time played must be greater than 0',
        if (minutes > 24 * 60) 'Time played cannot exceed 24 hours in one session',
        if (players < 1 || players > 14) 'Players at table must be between 1 and 14',
        if (game.multipliers[type] == null && type != PlayerType.average)
          '${type.label} player type is not used for ${game.name} (book recommends average or hard only)',
      ];
}

class RatingResult {
  final double decisionsPerHour, effectiveAdvantage, totalWagered, theoreticalWin, sd;
  const RatingResult(this.decisionsPerHour, this.effectiveAdvantage, this.totalWagered, this.theoreticalWin, this.sd);
  ({double low, double high}) range(double sigmas) => (low: theoreticalWin - sigmas * sd, high: theoreticalWin + sigmas * sd);
}

class Rating {
  static const ref = BookRef(12, '221–223', 'Theoretical win = avg bet × hours × decisions/hr × HA');

  static RatingResult rate(RatingInput i) {
    final dph = i.decisionsOverride ?? i.game.decisionsPerHour(i.players);
    final ha = i.game.effectiveAdvantage(i.type);
    final hands = dph * i.minutes / 60;
    final wagered = i.averageBet * hands;
    final theo = wagered * ha;
    final sd = Stats.sessionSd([(bet: i.averageBet, hands: hands.round())], i.game.sdPerDollar);
    return RatingResult(dph, ha, wagered, theo, sd);
  }

  /// Plain book formula (p.221).
  static double theo({required double averageBet, required double hours, required double decisionsPerHour, required double houseAdvantage}) =>
      averageBet * hours * decisionsPerHour * houseAdvantage;

  /// Probability the casino loses money over the play (normal approximation, Ch19).
  static double probabilityCasinoLoses(RatingResult r) =>
      r.sd == 0 ? 0 : Stats.normalCdf((0 - r.theoreticalWin) / r.sd);

  static double sigmaRange(RatingResult r) => math.max(r.sd, 0);
}
