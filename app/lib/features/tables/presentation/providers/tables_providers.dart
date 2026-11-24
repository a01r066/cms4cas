import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/backend_providers.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/tables_remote_datasource.dart';
import '../../data/repositories/tables_repository_impl.dart';
import '../../domain/entities/hit_record.dart';
import '../../domain/entities/table_def.dart';
import '../../domain/entities/table_shift.dart';
import '../../domain/repositories/tables_repository.dart';

final tablesDataSourceProvider = Provider((ref) => TablesRemoteDataSource(ref.watch(recordStoreProvider)));

final tablesRepositoryProvider = Provider<TablesRepository>((ref) => TablesRepositoryImpl(ref.watch(tablesDataSourceProvider)));

final tablesProvider = StreamProvider<List<TableDef>>((ref) {
  if (ref.watch(currentUserValueProvider) == null) return Stream.value(const []);
  return ref.watch(tablesRepositoryProvider).watchTables();
});

final shiftsProvider = StreamProvider<List<TableShift>>((ref) {
  if (ref.watch(currentUserValueProvider) == null) return Stream.value(const []);
  return ref.watch(tablesRepositoryProvider).watchShifts();
});

final hitsProvider = StreamProvider<List<HitRecord>>((ref) {
  if (ref.watch(currentUserValueProvider) == null) return Stream.value(const []);
  return ref.watch(tablesRepositoryProvider).watchHits();
});
