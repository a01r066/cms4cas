import 'package:casino_engine/casino_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../../../../core/util/ids.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/hit_record.dart';
import '../../domain/entities/table_def.dart';
import '../../domain/entities/table_shift.dart';
import '../../domain/repositories/tables_repository.dart';
import 'tables_providers.dart';
import 'tables_state.dart';

/// Table setup, shift accounting and documented hits (Ch9–10, Ch13).
class TablesNotifier extends StateNotifier<TablesState> {
  TablesNotifier(this._repo, this._user) : super(const TablesState());

  final TablesRepository _repo;
  final AppUser? Function() _user;

  /// [table.id] empty → new table.
  ResultFuture<TableDef> saveTable(TableDef table) =>
      _run(() => _repo.saveTable(table.id.isEmpty ? table.copyWith(id: newId()) : table));

  ResultFuture<TableShift> recordShift({
    required String tableId,
    required String shift,
    required DateTime gamingDay,
    required TableShiftInput input,
  }) {
    final user = _user();
    if (user == null) return _signedOut();
    final errors = input.validate();
    if (errors.isNotEmpty) return Future.value(Left(Failure(errors.join(' '), code: 'invalid-argument')));
    return _run(() => _repo.addShift(TableShift(
          id: newId(),
          tableId: tableId,
          shift: shift,
          recordedBy: user.name,
          gamingDay: DateTime(gamingDay.year, gamingDay.month, gamingDay.day),
          recordedAt: DateTime.now(),
          input: input,
        )));
  }

  /// Only results at or above [threshold] are excluded from hold (Ch13 p.249).
  ResultFuture<HitRecord> recordHit({
    required String tableId,
    required String playerLabel,
    required DateTime gamingDay,
    required double playerDrop,
    required double casinoResult,
    required double threshold,
  }) {
    final user = _user();
    if (user == null) return _signedOut();
    if (casinoResult.abs() < threshold) {
      return Future.value(Left(Failure('Below the hit threshold — not excluded from hold.', code: 'invalid-argument')));
    }
    return _run(() => _repo.addHit(HitRecord(
          id: newId(),
          tableId: tableId,
          playerLabel: playerLabel.trim(),
          gamingDay: gamingDay,
          playerDrop: playerDrop,
          casinoResult: casinoResult,
          recordedBy: user.name,
        )));
  }

  ResultFuture<T> _signedOut<T>() => Future.value(const Left(Failure('Sign in first.', code: 'unauthenticated')));

  ResultFuture<T> _run<T>(ResultFuture<T> Function() f) async {
    state = state.copyWith(saving: true, failure: null);
    final r = await f();
    if (mounted) state = r.fold((f) => state.copyWith(saving: false, failure: f), (_) => state.copyWith(saving: false));
    return r;
  }
}

final tablesNotifierProvider = StateNotifierProvider<TablesNotifier, TablesState>(
  (ref) => TablesNotifier(ref.watch(tablesRepositoryProvider), () => ref.read(currentUserValueProvider)),
);
