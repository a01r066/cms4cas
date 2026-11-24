import 'dart:math' as math;

import 'package:casino_engine/casino_engine.dart';

import '../../../core/typedefs/typedefs.dart';
import '../../auth/data/models/access_request_model.dart';
import '../../auth/data/models/app_user_model.dart';
import '../../auth/domain/entities/access_request.dart';
import '../../auth/domain/entities/app_role.dart';
import '../../auth/domain/entities/app_user.dart';
import '../../compliance/data/models/compliance_models.dart';
import '../../compliance/domain/entities/compliance_entities.dart';
import '../../credit/data/models/credit_models.dart';
import '../../credit/domain/entities/credit_application.dart';
import '../../credit/domain/entities/credit_enums.dart';
import '../../credit/domain/entities/marker.dart';
import '../../credit/domain/entities/signature.dart';
import '../../players/data/models/player_model.dart';
import '../../players/data/models/rating_record_model.dart';
import '../../players/domain/entities/player.dart';
import '../../players/domain/entities/rating_record.dart';
import '../../settings/domain/entities/app_settings.dart';
import '../../tables/data/models/table_models.dart';
import '../../tables/domain/entities/hit_record.dart';
import '../../tables/domain/entities/table_def.dart';
import '../../tables/domain/entities/table_shift.dart';

/// Realistic test data for every feature, built through the app's own entities
/// and models (so it always matches the schema) and the casino_engine formulas
/// (so theo, win/hold, Table 6.2 signatures and CTR aggregates are consistent).
///
/// Every id starts with [prefix], so demo data can be removed without touching
/// real records. Dates are relative to [now]; the same [seed] gives the same data.
///
/// Pure Dart (no Flutter): also used by tool/export_demo_data.dart for the
/// Firebase seeding script.
class DemoData {
  DemoData._(this.now, this.settings, int seed) : _rnd = math.Random(seed);

  static const prefix = 'demo-';

  /// Collections written, in a safe order.
  static const collections = [
    'users', 'players', 'ratings', 'tables', 'table_shifts', 'hits', 'credit_applications', 'markers',
    'cash_transactions', 'ctr_reports', 'barred_patrons', 'sar_cases', 'access_requests',
  ];

  /// {collection: {id: json}}.
  static Map<String, Map<String, Json>> build({DateTime? now, AppSettings settings = const AppSettings(), int seed = 20261124}) =>
      DemoData._(now ?? DateTime.now(), settings, seed)._build();

  final DateTime now;
  final AppSettings settings;
  final math.Random _rnd;
  final _out = <String, Map<String, Json>>{for (final c in collections) c: {}};

  void _put(String collection, String id, Json json) => _out[collection]![id] = {...json, 'id': id};

  DateTime _daysAgo(num days, {int hour = 20, int minute = 0}) {
    final d = DateTime(now.year, now.month, now.day, hour, minute).subtract(Duration(minutes: (days * 24 * 60).round()));
    return d.isAfter(now) ? now.subtract(const Duration(minutes: 30)) : d;
  }

  double _normal([double mean = 0, double sd = 1]) {
    final u1 = 1 - _rnd.nextDouble(), u2 = _rnd.nextDouble();
    return mean + sd * math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2);
  }

  double _round(double v, [double to = 25]) => (v / to).round() * to;
  T _pick<T>(List<T> l) => l[_rnd.nextInt(l.length)];
  String _id(String kind, Object n) => '$prefix$kind-$n';

  // ── Users ────────────────────────────────────────────────────────────
  static const users = <(String id, String name, AppRole role, CreditRole? credit, String email)>[
    ('demo-admin', 'Thanh Nguyen', AppRole.admin, CreditRole.president, 'demo.admin@cms4cas.test'),
    ('demo-cm', 'Linh Tran', AppRole.casinoManager, CreditRole.casinoManager, 'demo.cm@cms4cas.test'),
    ('demo-credit', 'Minh Pham', AppRole.creditExecutive, CreditRole.creditManager, 'demo.credit@cms4cas.test'),
    ('demo-vpf', 'Hana Kim', AppRole.creditExecutive, CreditRole.vpFinance, 'demo.vpf@cms4cas.test'),
    ('demo-host', 'Sarah Lee', AppRole.marketing, CreditRole.host, 'demo.host@cms4cas.test'),
    ('demo-pit', 'Duc Hoang', AppRole.pitSupervisor, null, 'demo.pit@cms4cas.test'),
    ('demo-cage', 'Mai Vo', AppRole.cageCashier, CreditRole.cageDirector, 'demo.cage@cms4cas.test'),
    ('demo-compliance', 'An Le', AppRole.complianceOfficer, null, 'demo.compliance@cms4cas.test'),
    ('demo-auditor', 'Quang Do', AppRole.auditor, null, 'demo.auditor@cms4cas.test'),
  ];

  AppUser _user(String id) {
    final u = users.firstWhere((x) => x.$1 == id);
    return AppUser(id: u.$1, name: u.$2, role: u.$3, creditRole: u.$4, email: u.$5);
  }

  Signature _sig(String userId, DateTime at) {
    final u = _user(userId);
    return Signature(userId: u.id, userName: u.name, role: u.creditRole!, at: at);
  }

  // ── Players ──────────────────────────────────────────────────────────
  static const _players = <(String name, double bet, bool idOnFile)>[
    ('Nguyen Van An', 500, true), // credit: permanent $50k
    ('Chen Wei', 2000, true), // premium baccarat, permanent $80k
    ('Tran Thi Bich', 150, true), // temporary line
    ('David Miller', 300, true), // pending application
    ('Le Hoang Nam', 250, true), // referred (4 in 14)
    ('Sato Kenji', 1000, true), // draft application
    ('Pham Quoc Bao', 200, true), // declined
    ('Maria Santos', 100, true),
    ('Vo Minh Tuan', 75, false), // no ID on file yet
    ('Kim Ji-ho', 400, true),
    ('Hoang Thu Ha', 50, false),
    ('James Wong', 750, true),
    ('Do Van Long', 25, true),
    ('Lucy Park', 125, true),
  ];

  String _pid(int i) => _id('player', i + 1);

  Map<String, Map<String, Json>> _build() {
    for (final u in users) {
      _put('users', u.$1, AppUserModel.fromEntity(_user(u.$1)).toJson());
    }
    _seedPlayers();
    _ratings();
    _tables();
    _credit();
    _compliance();
    final req = AccessRequest(uid: _id('req', 1), name: 'Bao Tran', email: 'bao.tran@cms4cas.test', requestedAt: _daysAgo(1, hour: 9));
    _put('access_requests', req.uid, AccessRequestModel.fromEntity(req).toJson());
    return _out;
  }

  void _seedPlayers() {
    for (var i = 0; i < _players.length; i++) {
      final p = _players[i];
      final player = Player(
        id: _pid(i),
        name: p.$1,
        playerNo: 'P-${10001 + i}',
        idDocument: p.$3 ? '${_pick(['Passport', 'National ID', 'Driver licence'])} ${100000000 + _rnd.nextInt(899999999)}' : '',
        address: p.$3 ? '${10 + _rnd.nextInt(180)} ${_pick(['Le Loi', 'Nguyen Hue', 'Tran Hung Dao', 'Hai Ba Trung', 'Pasteur'])} St, Ho Chi Minh City' : '',
        notes: i == 1 ? 'Premium player — baccarat, prefers VIP Salon. Rebate on loss 10% agreed.' : '',
        createdBy: 'Sarah Lee',
        createdAt: _daysAgo(60 + _rnd.nextInt(300), hour: 10),
      );
      _put('players', player.id, PlayerModel.fromEntity(player).toJson());
    }
  }

  // ── Ratings (Ch12) ───────────────────────────────────────────────────
  void _ratings() {
    var n = 0;
    void add(String playerId, String gameId, double bet, double minutes, int players, PlayerType type, DateTime at,
        {double? decisionsOverride, String? actualOverrideNote}) {
      final game = settings.game(gameId);
      final r = Rating.rate(RatingInput(game: game, averageBet: bet, minutes: minutes, players: players, type: type, decisionsOverride: decisionsOverride));
      final actual = _round(_normal(r.theoreticalWin, r.sd));
      final rec = RatingRecord(
        id: _id('rating', ++n),
        playerId: playerId,
        gameId: game.id,
        gameName: game.name,
        table: _tableFor(gameId),
        ratedBy: _pick(['Duc Hoang', 'Linh Tran']),
        averageBet: bet,
        minutes: minutes,
        decisionsPerHour: r.decisionsPerHour,
        effectiveAdvantage: r.effectiveAdvantage,
        theo: r.theoreticalWin,
        actualCasinoWin: actual,
        sd: r.sd,
        players: players,
        type: type,
        at: at,
      );
      _put('ratings', rec.id, RatingRecordModel.fromEntity(rec).toJson());
    }

    // The book's roulette example: $150 × 2.25 h × 60 spins × 5.26% = $1,065.15 (Ch12 p.221).
    add(_pid(0), 'roulette', 150, 135, 3, PlayerType.average, _daysAgo(5, hour: 21), decisionsOverride: 60);

    const favourite = ['baccarat', 'baccarat', 'blackjack', 'roulette', 'blackjack', 'baccarat', 'craps', 'blackjack', 'craps', 'baccarat', 'roulette', 'blackjack', 'craps', 'blackjack'];
    for (var i = 0; i < _players.length; i++) {
      final sessions = 2 + _rnd.nextInt(4);
      for (var s = 0; s < sessions; s++) {
        final game = _rnd.nextDouble() < 0.75 ? favourite[i] : _pick(['blackjack', 'craps', 'roulette', 'baccarat']);
        final bet = _round(math.max(25, _players[i].$2 * (0.6 + _rnd.nextDouble() * 0.8)));
        add(_pid(i), game, bet, (30 + _rnd.nextInt(8) * 30).toDouble(), 1 + _rnd.nextInt(6), _pick(PlayerType.values),
            _daysAgo(_rnd.nextInt(30) + _rnd.nextDouble(), hour: 14 + _rnd.nextInt(9)));
      }
    }
  }

  // ── Tables, shifts, hits (Ch9–10, Ch13) ──────────────────────────────
  static const _tableDefs = <(String code, String gameId, String pit, double min, double max, double baseHold, double avgDrop, MarkerSystem sys)>[
    ('BJ-01', 'blackjack', 'Pit 1', 25, 2500, 0.14, 22000, MarkerSystem.marker),
    ('BJ-02', 'blackjack', 'Pit 1', 25, 2500, 0.14, 24000, MarkerSystem.marker),
    ('BJ-03', 'blackjack', 'Pit 1', 50, 5000, 0.14, 30000, MarkerSystem.marker),
    ('BJ-04', 'blackjack', 'Pit 2', 100, 10000, 0.14, 36000, MarkerSystem.marker), // runs low → investigate
    ('BJ-05', 'blackjack', 'Pit 2', 100, 10000, 0.14, 34000, MarkerSystem.marker),
    ('CR-01', 'craps', 'Pit 2', 25, 5000, 0.15, 30000, MarkerSystem.marker),
    ('CR-02', 'craps', 'Pit 2', 25, 5000, 0.15, 26000, MarkerSystem.marker),
    ('RO-01', 'roulette', 'Pit 1', 10, 1000, 0.20, 14000, MarkerSystem.marker),
    ('BA-01', 'baccarat', 'VIP Salon', 500, 50000, 0.12, 140000, MarkerSystem.marker), // big documented hit
    ('BA-02', 'baccarat', 'VIP Salon', 200, 25000, 0.12, 90000, MarkerSystem.nameCredit),
  ];

  String _tableFor(String gameId) {
    final t = _tableDefs.where((t) => t.$2 == gameId).toList();
    return t.isEmpty ? '' : _pick(t).$1;
  }

  String _tid(String code) => _id('table', code.toLowerCase());

  void _tables() {
    for (final t in _tableDefs) {
      final def = TableDef(id: _tid(t.$1), name: t.$1, gameId: t.$2, pit: t.$3, minBet: t.$4, maxBet: t.$5, baseHold: t.$6, system: t.$8);
      _put('tables', def.id, TableDefModel.fromEntity(def).toJson());
    }
    const shifts = [('Day', 0.8, 10), ('Swing', 1.25, 18), ('Grave', 0.55, 2)];
    var n = 0;
    for (var day = 13; day >= 0; day--) {
      for (final t in _tableDefs) {
        for (final sh in shifts) {
          final gamingDay = _daysAgo(day, hour: 0);
          var drop = _round(t.$7 * sh.$2 * (0.6 + _rnd.nextDouble() * 0.8), 100);
          var hold = t.$6 + _normal(0, t.$2 == 'baccarat' ? 0.09 : 0.05);
          if (t.$1 == 'BJ-04' && day <= 6) hold = 0.06 + _normal(0, 0.03); // persistent shortfall
          var win = _round(drop * hold, 25);
          // BA-01, 4 days ago, Swing: a player won HK$… — documented hit (Ch13 p.249).
          final isHit = t.$1 == 'BA-01' && day == 4 && sh.$1 == 'Swing';
          if (isHit) {
            drop += 150000;
            win -= 120000;
          }
          final markerShare = t.$2 == 'baccarat' ? 0.3 + _rnd.nextDouble() * 0.2 : (_rnd.nextDouble() < 0.15 ? 0.2 : 0.0);
          final markers = _round(drop * markerShare, 1000);
          final redeemed = t.$8 == MarkerSystem.marker && markers > 0 ? _round(markers * _rnd.nextDouble() * 0.3, 1000) : 0.0;
          final currency = drop - markers + redeemed;
          final opener = t.$2 == 'baccarat' ? 400000.0 : 120000.0;
          var fills = win < 0 ? _round(-win + 20000, 1000) : (_rnd.nextDouble() < 0.2 ? 10000.0 : 0.0);
          final credits = win > drop * 0.25 && _rnd.nextDouble() < 0.5 ? 10000.0 : 0.0;
          var closer = opener + fills - credits - drop + win;
          if (closer < 20000) {
            fills += 20000 - closer;
            closer = opener + fills - credits - drop + win;
          }
          final input = TableShiftInput(
            openingInventory: opener,
            fills: fills,
            credits: credits,
            closingInventory: closer,
            currencyInBox: currency,
            markersIssued: markers,
            markersRedeemedInPitCash: redeemed,
            system: t.$8,
          );
          final shift = TableShift(
            id: _id('shift', ++n),
            tableId: _tid(t.$1),
            shift: sh.$1,
            recordedBy: _pick(['Duc Hoang', 'Linh Tran']),
            gamingDay: gamingDay,
            recordedAt: _daysAgo(day, hour: sh.$3, minute: 30),
            input: input,
          );
          _put('table_shifts', shift.id, TableShiftModel.fromEntity(shift).toJson());
          if (isHit) {
            final hit = HitRecord(
              id: _id('hit', 1), tableId: _tid(t.$1), playerLabel: 'Chen Wei', gamingDay: gamingDay, playerDrop: 150000,
              casinoResult: -120000, note: 'Player won 120,000 on a 150,000 buy-in — verified on surveillance', recordedBy: 'Linh Tran');
            _put('hits', hit.id, HitRecordModel.fromEntity(hit).toJson());
          }
        }
      }
    }
    final small = HitRecord(
      id: _id('hit', 2), tableId: _tid('BJ-03'), playerLabel: 'James Wong', gamingDay: _daysAgo(2, hour: 0), playerDrop: 40000,
      casinoResult: 30000, note: 'Player lost 30,000 in one session', recordedBy: 'Duc Hoang');
    _put('hits', small.id, HitRecordModel.fromEntity(small).toJson());
  }

  // ── Credit & markers (Ch6) ───────────────────────────────────────────
  static const _clean = <String, bool>{
    'applicationComplete': true, 'applicationLegible': true, 'idCopied': true, 'gamingReportObtained': true,
    'consumerReportObtained': true, 'consumerReportClear': true, 'bankCheckObtained': true, 'canSignAlone': true,
    'accountOpen6Months': true, 'averageBalanceSupports': true,
  };

  void _credit() {
    var n = 0;
    void app(int player, LineType type, double amount, CreditStatus status, Map<String, bool>? answers,
        List<(String, int)> signers, int createdDaysAgo, {String declineReason = '', String createdBy = 'Sarah Lee'}) {
      final created = _daysAgo(createdDaysAgo, hour: 11);
      var a = CreditApplication(
        id: _id('credit', ++n),
        playerId: _pid(player),
        createdBy: createdBy,
        lineType: type,
        amount: amount,
        status: status,
        createdAt: created,
        signatures: [for (final s in signers) _sig(s.$1, created.add(Duration(hours: s.$2)))],
        declineReason: declineReason,
        decidedAt: status == CreditStatus.approved || status == CreditStatus.declined ? created.add(const Duration(days: 1)) : null,
      );
      if (answers != null) {
        final r = CreditAuthorizationFlow.evaluate(a.checkAnswers(answers));
        a = a.copyWith(answers: answers, outcome: r.outcome, referrals: r.referrals);
      }
      _put('credit_applications', a.id, CreditApplicationModel.fromEntity(a).toJson());
    }

    // Approved — signatures meet Table 6.2.
    app(0, LineType.permanent, 50000, CreditStatus.approved, _clean, [('demo-credit', 2), ('demo-host', 3)], 120);
    app(1, LineType.permanent, 80000, CreditStatus.approved, _clean, [('demo-credit', 2), ('demo-vpf', 4), ('demo-host', 5)], 200);
    app(2, LineType.temporary, 10000, CreditStatus.approved, _clean, [('demo-host', 1)], 130);
    // Awaiting signatures: ready, one signature — still needs Credit Manager or VP Finance.
    app(3, LineType.permanent, 30000, CreditStatus.pendingApproval, _clean, [('demo-host', 1)], 2);
    // Referred: 4 in 14 reported → needs the Credit Manager's signature.
    app(4, LineType.temporary, 8000, CreditStatus.pendingApproval, {..._clean, 'fourIn14': true}, [('demo-host', 1)], 1);
    // Draft, not assessed yet.
    app(5, LineType.permanent, 25000, CreditStatus.draft, null, const [], 0);
    // Declined: unpaid derogatories at Central.
    app(6, LineType.permanent, 20000, CreditStatus.declined, {..._clean, 'hasDerogs': true}, const [], 15,
        declineReason: 'Unpaid derogatory items reported by Central Credit');

    var m = 0;
    void marker(int player, String number, String table, double amount, int issuedDaysAgo,
        {List<(double, String, int)> payments = const [], MarkerStatus status = MarkerStatus.open, String note = '',
        List<String> writeOffSigners = const [], double writeOff = 0, String writeOffReason = ''}) {
      final issued = _daysAgo(issuedDaysAgo, hour: 22);
      final mk = Marker(
        id: _id('marker', ++m),
        playerId: _pid(player),
        number: number,
        table: table,
        issuedBy: 'Duc Hoang',
        amount: amount,
        issuedAt: issued,
        payments: [for (final p in payments) MarkerPayment(amount: p.$1, method: p.$2, recordedBy: 'Mai Vo', at: issued.add(Duration(days: p.$3)))],
        status: status,
        collectionNote: note,
        writeOffSignatures: [for (final s in writeOffSigners) _sig(s, issued.add(const Duration(days: 150)))],
        writeOffAmount: writeOff,
        writeOffReason: writeOffReason,
      );
      _put('markers', mk.id, MarkerModel.fromEntity(mk).toJson());
    }

    marker(0, 'M-10421', 'BJ-05', 20000, 40, payments: [(5000, 'Check', 20)]); // 31–60 days
    marker(0, 'M-10587', 'RO-01', 10000, 3); // current
    marker(1, 'M-10102', 'BA-01', 50000, 75, note: 'Statement sent; player travelling — follow up by phone 1st of month'); // 61–90
    marker(1, 'M-10655', 'BA-01', 25000, 10, payments: [(25000, 'Wire', 6)], status: MarkerStatus.paid);
    marker(1, 'M-09310', 'BA-02', 8000, 200, payments: [(3000, 'Cash', 30)], status: MarkerStatus.settled,
        writeOffSigners: ['demo-credit', 'demo-cage'], writeOff: 5000, writeOffReason: 'Settlement agreed — 37.5% of balance accepted');
    marker(2, 'M-09877', 'BJ-02', 10000, 120, note: 'Returned check; collection agency letter sent',
        writeOffSigners: ['demo-credit']); // 90+, one write-off signature so far
  }

  // ── Currency compliance (Ch5) ────────────────────────────────────────
  void _compliance() {
    final profile = settings.aml;
    final txs = <CashTxRecord>[];
    var n = 0;
    void tx(String patronKey, String label, CashTxType type, double amount, DateTime at, String area, {String? visit}) {
      final r = CashTxRecord(id: _id('cash', ++n), patronKey: patronKey, patronLabel: label, area: area,
          recordedBy: _pick(['Mai Vo', 'Duc Hoang']), type: type, amount: amount, at: at, visitId: visit ?? _id('visit', n));
      txs.add(r);
      _put('cash_transactions', r.id, CashTxModel.fromEntity(r).toJson());
    }

    String name(int i) => _players[i].$1;
    // Today: Chen Wei buys chips twice → 11,500 cash in → reportable, no CTR started yet (Home alert).
    // Both inside the current gaming day, whatever time it is now.
    var dayStart = DateTime(now.year, now.month, now.day, profile.gamingDayStartHour);
    if (dayStart.isAfter(now)) dayStart = dayStart.subtract(const Duration(days: 1));
    final elapsed = now.difference(dayStart);
    tx(_pid(1), name(1), CashTxType.chipPurchase, 6000, dayStart.add(elapsed * 0.3), 'BA-01', visit: _id('visit', 'chen-today'));
    tx(_pid(1), name(1), CashTxType.chipPurchase, 5500, dayStart.add(elapsed * 0.7), 'Main cage', visit: _id('visit', 'chen-today'));
    // 2 days ago: unidentified patron, one continuous visit → 10,700 → CTR draft.
    final v = _id('visit', 'redtie');
    const redTie = 'desc:tall man, red tie, bj-03';
    tx(redTie, 'Tall man, red tie, BJ-03', CashTxType.chipPurchase, 4000, _daysAgo(2, hour: 21), 'BJ-03', visit: v);
    tx(redTie, 'Tall man, red tie, BJ-03', CashTxType.chipPurchase, 3500, _daysAgo(2, hour: 22), 'BJ-03', visit: v);
    tx(redTie, 'Tall man, red tie, BJ-03', CashTxType.losingCashWager, 3200, _daysAgo(2, hour: 23), 'BJ-03', visit: v);
    // 5 days ago: Nguyen Van An redeems 12,000 → CTR filed.
    tx(_pid(0), name(0), CashTxType.chipRedemption, 12000, _daysAgo(5, hour: 23), 'Main cage');
    // Le Hoang Nam: 9,500 and 9,800 on consecutive days, just under the CTR threshold → SAR case.
    tx(_pid(4), name(4), CashTxType.chipPurchase, 9500, _daysAgo(4, hour: 20), 'Main cage');
    tx(_pid(4), name(4), CashTxType.chipPurchase, 9800, _daysAgo(3, hour: 20), 'Main cage');
    // Routine MTL entries ($3,000+).
    for (var i = 0; i < 14; i++) {
      final p = _pick([7, 9, 11, 12, 13, 3]);
      tx(_pid(p), name(p), _pick([CashTxType.chipPurchase, CashTxType.chipRedemption, CashTxType.losingCashWager]),
          _round(3000 + _rnd.nextDouble() * 5000, 100), _daysAgo(1 + _rnd.nextInt(6), hour: 15 + _rnd.nextInt(8)),
          _pick(['Main cage', 'BJ-01', 'CR-01', 'RO-01']));
    }

    // CTRs from the real aggregation of the transactions above.
    final aggs = Aml.aggregate(txs.map((t) => t.tx).toList(), profile).where((a) => a.reportable).toList();
    Aggregate? find(String key) => aggs.where((a) => a.patronKey == key).firstOrNull;
    final fields = Aml.ctrRequiredFields;
    final filed = find(_pid(0));
    if (filed != null) {
      final c = CtrReport(
        id: _id('ctr', 1), patronKey: filed.patronKey, patronLabel: name(0), aggregateLabel: filed.label,
        direction: filed.direction.name, gamingDay: filed.gamingDay, total: filed.total, txIds: filed.txIds,
        fields: {for (final f in fields) f: true}, status: CtrStatus.filed,
        preparedBy: 'Mai Vo', preparedById: 'demo-cage', reviewedBy: 'An Le', reviewedById: 'demo-compliance',
        filedAt: _daysAgo(3, hour: 10));
      _put('ctr_reports', c.id, CtrReportModel.fromEntity(c).toJson());
    }
    final draft = find(redTie);
    if (draft != null) {
      final c = CtrReport(
        id: _id('ctr', 2), patronKey: draft.patronKey, patronLabel: 'Tall man, red tie, BJ-03', aggregateLabel: draft.label,
        direction: draft.direction.name, gamingDay: draft.gamingDay, total: draft.total, txIds: draft.txIds,
        fields: {for (final f in fields.take(3)) f: true});
      _put('ctr_reports', c.id, CtrReportModel.fromEntity(c).toJson());
    }

    // Barred patrons (p.69).
    final barred = [
      BarredPatron(id: _id('barred', 1), description: 'Man, 40s, scar on left hand, grey jacket',
          reason: 'Refused identification for a 12,000 chip redemption', addedBy: 'Mai Vo', since: _daysAgo(20, hour: 1)),
      BarredPatron(id: _id('barred', 2), description: _players[10].$1, playerId: _pid(10),
          reason: 'Identification not provided after reaching the MTL threshold', addedBy: 'An Le', since: _daysAgo(9, hour: 2)),
      BarredPatron(id: _id('barred', 3), description: 'Woman, 30s, red handbag',
          reason: 'Refused ID — provided later, bar lifted', addedBy: 'Mai Vo', since: _daysAgo(45, hour: 3), active: false),
    ];
    for (final b in barred) {
      _put('barred_patrons', b.id, BarredPatronModel.fromEntity(b).toJson());
    }

    // SAR cases: one new, one due within a week (Home alert), one filed.
    final sars = [
      SarCase(id: _id('sar', 1), subject: _players[4].$1, summary: 'Cash purchases of 9,500 and 9,800 on consecutive days, '
          'each just under the CTR threshold — possible structuring.', openedBy: 'An Le', amount: 19300, detectedAt: _daysAgo(3, hour: 9)),
      SarCase(id: _id('sar', 2), subject: 'Tall man, red tie (unidentified)', summary: 'Refused to give name; split buy-ins across tables.',
          openedBy: 'An Le', amount: 10700, detectedAt: _daysAgo(26, hour: 9)),
      SarCase(id: _id('sar', 3), subject: _players[12].$1, summary: 'Minimal play then redemption of chips bought with cash.',
          openedBy: 'An Le', amount: 7400, detectedAt: _daysAgo(40, hour: 9), filedAt: _daysAgo(20, hour: 9)),
    ];
    for (final s in sars) {
      _put('sar_cases', s.id, SarCaseModel.fromEntity(s).toJson());
    }
  }
}
