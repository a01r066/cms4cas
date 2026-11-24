import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/backend_providers.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/credit_remote_datasource.dart';
import '../../data/repositories/credit_repository_impl.dart';
import '../../domain/entities/credit_application.dart';
import '../../domain/entities/credit_line.dart';
import '../../domain/entities/marker.dart';
import '../../domain/repositories/credit_repository.dart';

final creditDataSourceProvider =
    Provider((ref) => CreditRemoteDataSource(ref.watch(recordStoreProvider), ref.watch(functionsGatewayProvider)));

final creditRepositoryProvider = Provider<CreditRepository>((ref) => CreditRepositoryImpl(ref.watch(creditDataSourceProvider)));

final creditAppsProvider = StreamProvider<List<CreditApplication>>((ref) {
  if (ref.watch(currentUserValueProvider) == null) return Stream.value(const []);
  return ref.watch(creditRepositoryProvider).watchApplications();
});

final markersProvider = StreamProvider<List<Marker>>((ref) {
  if (ref.watch(currentUserValueProvider) == null) return Stream.value(const []);
  return ref.watch(creditRepositoryProvider).watchMarkers();
});

final creditAppByIdProvider = Provider.family<CreditApplication?, String>(
    (ref, id) => (ref.watch(creditAppsProvider).value ?? const <CreditApplication>[]).where((a) => a.id == id).firstOrNull);

final markersForPlayerProvider = Provider.family<List<Marker>, String>(
    (ref, id) => (ref.watch(markersProvider).value ?? const <Marker>[]).where((m) => m.playerId == id).toList());

final availableCreditProvider = Provider.family<CreditLine, String>((ref, playerId) => availableCredit(
      ref.watch(creditAppsProvider).value ?? const [],
      ref.watch(markersProvider).value ?? const [],
      playerId,
    ));
