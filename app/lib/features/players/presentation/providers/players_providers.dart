import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/backend_providers.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/players_remote_datasource.dart';
import '../../data/repositories/players_repository_impl.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/rating_record.dart';
import '../../domain/repositories/players_repository.dart';

final playersDataSourceProvider = Provider((ref) => PlayersRemoteDataSource(ref.watch(recordStoreProvider)));

final playersRepositoryProvider =
    Provider<PlayersRepository>((ref) => PlayersRepositoryImpl(ref.watch(playersDataSourceProvider)));

final playersProvider = StreamProvider<List<Player>>((ref) {
  if (ref.watch(currentUserValueProvider) == null) return Stream.value(const []);
  return ref.watch(playersRepositoryProvider).watchPlayers();
});

final ratingsProvider = StreamProvider<List<RatingRecord>>((ref) {
  if (ref.watch(currentUserValueProvider) == null) return Stream.value(const []);
  return ref.watch(playersRepositoryProvider).watchRatings();
});

/// Selectors derived from the single players / ratings listeners.
final playerByIdProvider = Provider.family<Player?, String>(
    (ref, id) => (ref.watch(playersProvider).value ?? const <Player>[]).where((p) => p.id == id).firstOrNull);

final playerNameProvider = Provider.family<String, String>((ref, id) => ref.watch(playerByIdProvider(id))?.name ?? 'Unknown player');

final ratingsForPlayerProvider = Provider.family<List<RatingRecord>, String>(
    (ref, id) => (ref.watch(ratingsProvider).value ?? const <RatingRecord>[]).where((r) => r.playerId == id).toList());
