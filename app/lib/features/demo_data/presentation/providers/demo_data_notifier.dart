import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../../../auth/domain/entities/app_role.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/repositories/demo_data_repository.dart';
import 'demo_data_providers.dart';
import 'demo_data_state.dart';

class DemoDataNotifier extends StateNotifier<DemoDataState> {
  DemoDataNotifier(this._repo, this._user, this._available) : super(const DemoDataState());

  final DemoDataRepository _repo;
  final AppUser? Function() _user;
  final bool Function() _available;

  Failure? _guard() {
    if (!_available()) return const Failure('Demo data is loaded with the seeding script on Firebase projects.', code: 'unsupported');
    if (_user()?.can(Perm.manageUsers) != true) return const Failure('Only an administrator can load or remove demo data.', code: 'permission-denied');
    return null;
  }

  ResultFuture<int> load() => _run(_repo.load);

  ResultFuture<int> remove() => _run(() => _repo.remove(keepUserId: _user()?.id));

  ResultFuture<int> _run(ResultFuture<int> Function() op) async {
    final denied = _guard();
    if (denied != null) return Left(denied);
    state = state.copyWith(busy: true, failure: null);
    final r = await op();
    if (mounted) state = r.fold((f) => state.copyWith(busy: false, failure: f), (_) => state.copyWith(busy: false));
    return r;
  }
}

final demoDataNotifierProvider = StateNotifierProvider<DemoDataNotifier, DemoDataState>((ref) => DemoDataNotifier(
      ref.watch(demoDataRepositoryProvider),
      () => ref.read(currentUserValueProvider),
      () => ref.read(demoDataAvailableProvider),
    ));
