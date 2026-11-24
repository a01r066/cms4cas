import 'package:casino_engine/casino_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../../../../core/util/ids.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/credit_application.dart';
import '../../domain/entities/credit_enums.dart';
import '../../domain/entities/credit_line.dart';
import '../../domain/entities/marker.dart';
import '../../domain/repositories/credit_repository.dart';
import 'credit_providers.dart';
import 'credit_state.dart';

/// Credit applications (Fig 6.4, Table 6.2) and markers. Client-side checks give
/// immediate feedback; the privileged actions re-check everything server-side.
class CreditNotifier extends StateNotifier<CreditState> {
  CreditNotifier(this._repo, this._user) : super(const CreditState());

  final CreditRepository _repo;
  final AppUser? Function() _user;

  ResultFuture<CreditApplication> createApplication({
    required String playerId,
    required LineType lineType,
    required double amount,
    String disposition = kDefaultDisposition,
  }) {
    final user = _user();
    if (user == null) return _fail('Sign in first.', 'unauthenticated');
    if (amount <= 0) return _fail('Enter the amount requested.', 'invalid-argument');
    return _run(() => _repo.createApplication(CreditApplication(
          id: newId(),
          playerId: playerId,
          createdBy: user.name,
          lineType: lineType,
          amount: amount,
          status: CreditStatus.draft,
          createdAt: DateTime.now(),
          disposition: disposition,
        )));
  }

  /// Walks Fig 6.4 with [answers] and stores the outcome. Returns the assessment.
  ResultFuture<CreditAssessment> runAssessment(CreditApplication app, Map<String, bool> answers) async {
    if (app.status != CreditStatus.draft) return _fail('Only draft applications can be reassessed.', 'failed-precondition');
    final r = CreditAuthorizationFlow.evaluate(app.checkAnswers(answers));
    final saved = await _run(() => _repo.saveAssessment(app.copyWith(answers: answers, outcome: r.outcome, referrals: r.referrals)));
    return saved.map((_) => r);
  }

  ResultVoid submitForSignatures(CreditApplication app) {
    if (app.outcome == null || !app.outcome!.allowsApproval) {
      return _fail('Run the assessment first; "${app.outcome?.label ?? 'not assessed'}" cannot go forward.', 'failed-precondition');
    }
    return _run(() => _repo.submitForSignatures(app.id));
  }

  ResultVoid sign(CreditApplication app) => _run(() => _repo.sign(app.id));

  ResultVoid approve(CreditApplication app) {
    if (!app.canApprove) {
      return _fail(
          app.signatureCheck.satisfied ? 'A Credit Manager signature is required for a referred application.' : 'Still needed: ${app.signatureCheck.missing}',
          'failed-precondition');
    }
    return _run(() => _repo.approve(app.id));
  }

  ResultVoid decline(CreditApplication app, String reason) {
    if (reason.trim().isEmpty) return _fail('Give a reason for declining.', 'invalid-argument');
    return _run(() => _repo.decline(app.id, reason.trim()));
  }

  ResultFuture<String> issueMarker({
    required String playerId,
    required String number,
    required String table,
    required double amount,
    required CreditLine line,
  }) {
    if (amount <= 0) return _fail('Enter an amount.', 'invalid-argument');
    if (amount > line.available + 0.001) return _fail('Exceeds available credit.', 'failed-precondition');
    return _run(() => _repo.issueMarker(playerId: playerId, number: number.trim(), table: table.trim(), amount: amount));
  }

  ResultVoid recordPayment(Marker m, double amount, String method) {
    if (amount <= 0 || amount > m.balance + 0.001) return _fail('Enter an amount between \$0 and the balance.', 'invalid-argument');
    return _run(() => _repo.recordPayment(m.id, amount, method));
  }

  ResultVoid signWriteOff(Marker m, String reason) => _run(() => _repo.signWriteOff(m.id, reason.trim()));

  /// Needs two of President/GM, VP Finance, Credit Manager, Director of Cage (p.105).
  ResultVoid writeOff(Marker m, String reason) {
    if (reason.trim().isEmpty) return _fail('Give a reason for the write-off.', 'invalid-argument');
    if (!Credit.writeOffApproved(m.writeOffSignatures.map((s) => s.role).toList())) {
      return _fail('Two authorized signatures are required before writing off.', 'failed-precondition');
    }
    return _run(() => _repo.writeOff(m.id, reason.trim()));
  }

  ResultVoid saveCollectionNote(Marker m, String note) => _run(() => _repo.saveCollectionNote(m.id, note.trim()));

  ResultFuture<T> _fail<T>(String msg, String code) => Future.value(Left(Failure(msg, code: code)));

  ResultFuture<T> _run<T>(ResultFuture<T> Function() f) async {
    state = state.copyWith(saving: true, failure: null);
    final r = await f();
    if (mounted) state = r.fold((f) => state.copyWith(saving: false, failure: f), (_) => state.copyWith(saving: false));
    return r;
  }
}

final creditNotifierProvider = StateNotifierProvider<CreditNotifier, CreditState>(
  (ref) => CreditNotifier(ref.watch(creditRepositoryProvider), () => ref.read(currentUserValueProvider)),
);
