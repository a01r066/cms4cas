import 'package:casino_engine/casino_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../../../../core/util/ids.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/compliance_entities.dart';
import '../../domain/repositories/compliance_repository.dart';
import 'compliance_providers.dart';
import 'compliance_state.dart';

/// Currency compliance (Ch5): MTL, CTR workflow, barred list, SAR cases.
class ComplianceNotifier extends StateNotifier<ComplianceState> {
  ComplianceNotifier(this._repo, this._user) : super(const ComplianceState());

  final ComplianceRepository _repo;
  final AppUser? Function() _user;

  /// Logs a cash transaction. [playerId] for a known patron, otherwise [description].
  ResultFuture<CashTxRecord> recordCashTx({
    String? playerId,
    String? playerName,
    String description = '',
    required String area,
    required CashTxType type,
    required double amount,
    String? visitId,
  }) {
    final user = _user();
    if (user == null) return _fail('Sign in first.', 'unauthenticated');
    if (amount <= 0) return _fail('Enter an amount.', 'invalid-argument');
    if (playerId == null && description.trim().isEmpty) return _fail('Choose a player or describe the patron.', 'invalid-argument');
    return _run(() => _repo.addCashTx(CashTxRecord(
          id: newId(),
          patronKey: playerId ?? 'desc:${description.trim().toLowerCase()}',
          patronLabel: playerName ?? description.trim(),
          area: area.trim(),
          recordedBy: user.name,
          type: type,
          amount: amount,
          at: DateTime.now(),
          visitId: visitId ?? newId(),
        )));
  }

  ResultFuture<CtrReport> startCtr(Aggregate a, String patronLabel) => _run(() => _repo.createCtr(CtrReport(
        id: newId(),
        patronKey: a.patronKey,
        patronLabel: patronLabel,
        aggregateLabel: a.label,
        direction: a.direction.name,
        gamingDay: a.gamingDay,
        total: a.total,
        txIds: a.txIds,
      )));

  ResultVoid setCtrField(CtrReport r, String field, bool value) {
    if (r.status != CtrStatus.draft) return _fail('Fields are locked once the report is prepared.', 'failed-precondition');
    return _run(() => _repo.setCtrFields(r.id, {...r.fields, field: value}));
  }

  ResultVoid advanceCtr(CtrReport r, CtrStatus to) {
    final user = _user();
    if (to == CtrStatus.reviewed && user?.id == r.preparedById) {
      return _fail('The reviewer must be a different employee from the preparer.', 'failed-precondition');
    }
    if (to == CtrStatus.prepared && !r.complete) return _fail('Complete the required fields first.', 'failed-precondition');
    return _run(() => _repo.advanceCtr(r.id, to));
  }

  ResultFuture<BarredPatron> barPatron({required String description, required String reason, String playerId = ''}) {
    final user = _user();
    if (user == null) return _fail('Sign in first.', 'unauthenticated');
    if (description.trim().isEmpty) return _fail('Describe the patron.', 'invalid-argument');
    return _run(() => _repo.saveBarred(BarredPatron(
          id: newId(),
          description: description.trim(),
          reason: reason.trim(),
          playerId: playerId,
          addedBy: user.name,
          since: DateTime.now(),
        )));
  }

  /// The required information was provided (p.69).
  ResultFuture<BarredPatron> liftBar(BarredPatron b) => _run(() => _repo.saveBarred(b.copyWith(active: false)));

  ResultFuture<SarCase> openSar({required String subject, required String summary, required double amount}) {
    final user = _user();
    if (user == null) return _fail('Sign in first.', 'unauthenticated');
    if (subject.trim().isEmpty) return _fail('Name or describe the subject.', 'invalid-argument');
    return _run(() => _repo.saveSar(SarCase(
          id: newId(),
          subject: subject.trim(),
          summary: summary.trim(),
          openedBy: user.name,
          amount: amount,
          detectedAt: DateTime.now(),
        )));
  }

  ResultFuture<SarCase> extendSar(SarCase s) => _run(() => _repo.saveSar(s.copyWith(extended: true)));

  ResultFuture<SarCase> markSarFiled(SarCase s) => _run(() => _repo.saveSar(s.copyWith(filedAt: DateTime.now())));

  ResultFuture<T> _fail<T>(String msg, String code) => Future.value(Left(Failure(msg, code: code)));

  ResultFuture<T> _run<T>(ResultFuture<T> Function() f) async {
    state = state.copyWith(saving: true, failure: null);
    final r = await f();
    if (mounted) state = r.fold((f) => state.copyWith(saving: false, failure: f), (_) => state.copyWith(saving: false));
    return r;
  }
}

final complianceNotifierProvider = StateNotifierProvider<ComplianceNotifier, ComplianceState>(
  (ref) => ComplianceNotifier(ref.watch(complianceRepositoryProvider), () => ref.read(currentUserValueProvider)),
);
