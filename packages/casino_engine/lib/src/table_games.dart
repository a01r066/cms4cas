import 'book_ref.dart';

enum MarkerSystem { marker, nameCredit }

/// Inputs for one table shift / gaming day (Ch9 pp.172–176).
class TableShiftInput {
  final double openingInventory;
  final double fills;
  final double credits;
  final double closingInventory;
  final double currencyInBox;
  final double chequesInBox;
  final double markersIssued;
  final double markersRedeemedInPitCash;
  final double markersRedeemedInPitCheques;
  final MarkerSystem system;

  const TableShiftInput({
    required this.openingInventory,
    required this.fills,
    required this.credits,
    required this.closingInventory,
    required this.currencyInBox,
    this.chequesInBox = 0,
    this.markersIssued = 0,
    this.markersRedeemedInPitCash = 0,
    this.markersRedeemedInPitCheques = 0,
    this.system = MarkerSystem.marker,
  });

  double get markersRedeemedInPit =>
      system == MarkerSystem.nameCredit ? 0 : markersRedeemedInPitCash + markersRedeemedInPitCheques;

  List<String> validate() => [
        for (final e in {
          'Opening inventory': openingInventory,
          'Fills': fills,
          'Credits': credits,
          'Closing inventory': closingInventory,
          'Currency in drop box': currencyInBox,
          'Cheques in drop box': chequesInBox,
          'Markers issued': markersIssued,
          'Markers redeemed (cash)': markersRedeemedInPitCash,
          'Markers redeemed (cheques)': markersRedeemedInPitCheques,
        }.entries)
          if (e.value < 0) '${e.key} cannot be negative',
        if (markersRedeemedInPit > markersIssued && system == MarkerSystem.marker)
          'Markers redeemed in the pit exceed markers issued on this table — check the table card',
      ];
}

class TableShiftResult {
  final double drop, chequesMissing, win, hold, statisticalDrop, statisticalHold;
  const TableShiftResult(this.drop, this.chequesMissing, this.win, this.hold, this.statisticalDrop, this.statisticalHold);
}

class TableGames {
  static const refWin = BookRef(9, '172–176', 'Determining win, hold and statistical drop');
  static const refHits = BookRef(13, '249', 'Effect of "hits" on hold');
  static const refObjective = BookRef(13, '246–249', 'Hold objective');
  static const refDeterminants = BookRef(13, '241–250', 'Determinants of hold');

  static TableShiftResult compute(TableShiftInput i) {
    final drop = i.currencyInBox + i.chequesInBox + i.markersIssued - i.markersRedeemedInPit;
    final missing = i.openingInventory + i.fills - i.credits - i.closingInventory;
    final win = drop - missing;
    final markersToCage = i.markersIssued - i.markersRedeemedInPit;
    final statDrop = i.currencyInBox + i.chequesInBox + markersToCage +
        (i.system == MarkerSystem.marker ? i.markersRedeemedInPitCheques : 0);
    return TableShiftResult(drop, missing, win, drop == 0 ? 0 : win / drop, statDrop, statDrop == 0 ? 0 : win / statDrop);
  }

  /// Remove a documented "hit": drop is always removed; the player's result is reversed (p.249).
  /// [casinoResult] is positive when the player lost (casino won).
  static ({double win, double drop}) removeHit({
    required double totalWin,
    required double totalDrop,
    required double playerDrop,
    required double casinoResult,
  }) =>
      (win: totalWin - casinoResult, drop: totalDrop - playerDrop);

  /// Wagers needed (× buy-in) for a hold objective at a house advantage (p.249).
  static double wagerMultipleForHold(double holdObjective, double houseAdvantage) => holdObjective / houseAdvantage;

  /// NV: investigate when statistical hold deviates by more than ±3 points from base (p.204).
  static bool needsInvestigation(double currentHold, double baseHold, {double tolerance = 0.03}) =>
      (currentHold - baseHold).abs() > tolerance;

  /// Checklist of determinants to review before reading anything into a hold change (Ch13 summary p.249–250).
  static const holdDiagnostics = [
    ('Rim sheets / auxiliary table cards in use (100% hold on that play)', 'p.241–242'),
    ('Count timing — graveyard inherits chips bought on swing', 'p.242'),
    ('Foreign chips or special cheques kept in the float instead of dropped', 'p.242–243'),
    ('Match play, nonnegotiable chips or chip warrants redeemed', 'p.243'),
    ('Marker collection policy at the table', 'p.243'),
    ('Table utilization (more players per table → lower hold)', 'p.243–244'),
    ('Cash wagers allowed; cash converted to chips before payoff?', 'p.244'),
    ('Bet-to-buy-in ratio / false drop', 'p.245'),
    ('Shuffle frequency and duration; seating comfort (time played)', 'p.245–246'),
    ('House advantage / rule changes / player skill', 'p.246'),
    ('Large documented hits not removed', 'p.249'),
  ];
}
