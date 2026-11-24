import 'package:casino_engine/casino_engine.dart';
import 'package:cms_kiss/features/credit/data/models/credit_models.dart';
import 'package:cms_kiss/features/credit/domain/entities/credit_enums.dart';
import 'package:cms_kiss/features/settings/data/models/settings_model.dart';
import 'package:cms_kiss/features/settings/domain/entities/app_settings.dart';
import 'package:cms_kiss/features/tables/data/models/table_models.dart';
import 'package:cms_kiss/features/tables/domain/entities/table_shift.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Settings: entity → model → JSON → entity keeps overrides', () {
    final s = const AppSettings().copyWith(
      houseAdvantage: {'blackjack': 0.005},
      multipliers: {
        'craps': {'soft': 0.7, 'average': 0.4, 'hard': null},
      },
      aml: const AmlProfile(regime: AggregationRegime.title31, ctrThreshold: 15000),
    );
    final back = SettingsModel.fromJson(SettingsModel.fromEntity(s).toJson()).toEntity();
    expect(back.game('blackjack').houseAdvantage, 0.005);
    expect(back.game('craps').multipliers[PlayerType.soft], 0.7);
    expect(back.aml.regime, AggregationRegime.title31);
    expect(back.aml.ctrThreshold, 15000);
  });

  test('Settings model defaults equal the book profile in the engine', () {
    final m = const SettingsModel().toEntity();
    const book = AmlProfile.bookNevada2003;
    expect(m.aml.ctrThreshold, book.ctrThreshold);
    expect(m.aml.mtlThreshold, book.mtlThreshold);
    expect(m.aml.gamingDayStartHour, book.gamingDayStartHour);
    expect(m.aml.sarFileDays, book.sarFileDays);
    expect(m.comps.pctOfTheo, const CompPolicy().pctOfTheo);
    final empty = SettingsModel.fromJson(const {}).toEntity();
    expect(empty.casinoName, const AppSettings().casinoName, reason: 'missing document → book defaults');
    expect(empty.holdTolerance, const AppSettings().holdTolerance);
  });

  test('Table shift model stores computed drop/win/hold and reads back', () {
    final t = TableShift(
      id: 's', tableId: 't', shift: 'Day', recordedBy: 'x', gamingDay: DateTime(2026), recordedAt: DateTime(2026),
      input: const TableShiftInput(
        openingInventory: 140000, fills: 50000, credits: 10000, closingInventory: 110000, currencyInBox: 60000,
        markersIssued: 100000, markersRedeemedInPitCheques: 70000),
    );
    final j = TableShiftModel.fromEntity(t).toJson();
    expect(j['win'], 20000);
    expect(j['system'], 'marker');
    expect(TableShiftModel.fromJson(j).toEntity().result.drop, 90000);
  });

  test('Credit application reads documents written before the refactor (wire values unchanged)', () {
    final legacy = {
      'id': 'a', 'playerId': 'p', 'createdBy': 'X', 'lineType': 'temporary', 'amount': 12000, 'status': 'pending_approval',
      'answers': {'idCopied': true}, 'outcome': 'referToCreditManager', 'referrals': ['4 in 14'],
      'signatures': [
        {'userId': 'u', 'userName': 'U', 'role': 'credit_manager', 'at': '2026-01-01T00:00:00.000'},
      ],
      'createdAt': '2026-01-01T00:00:00.000',
    };
    final a = CreditApplicationModel.fromJson(legacy).toEntity();
    expect(a.lineType, LineType.temporary);
    expect(a.status, CreditStatus.pendingApproval);
    expect(a.outcome, CreditOutcome.referToCreditManager);
    expect(a.signatures.single.role, CreditRole.creditManager);
    expect(CreditApplicationModel.fromEntity(a).toJson()['lineType'], 'temporary');
  });

  test('Unknown enum values fall back safely', () {
    final m = MarkerModel.fromJson({'id': 'm', 'issuedAt': '2026-01-01T00:00:00.000', 'status': 'something_new'}).toEntity();
    expect(m.status, MarkerStatus.open);
  });
}
