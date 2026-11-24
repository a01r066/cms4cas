import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/backend_providers.dart';
import '../../../settings/presentation/providers/settings_providers.dart';
import '../../data/datasources/demo_data_datasource.dart';
import '../../data/repositories/demo_data_repository_impl.dart';
import '../../domain/repositories/demo_data_repository.dart';

final demoDataDataSourceProvider = Provider((ref) => DemoDataDataSource(ref.watch(recordStoreProvider)));

final demoDataRepositoryProvider = Provider<DemoDataRepository>(
    (ref) => DemoDataRepositoryImpl(ref.watch(demoDataDataSourceProvider), () => ref.read(settingsProvider)));

/// Demo data can be loaded from the app only on the local backend; Firebase
/// projects are seeded with functions/scripts/seed-demo-data.js (dev only).
final demoDataAvailableProvider = Provider<bool>((ref) => ref.watch(backendProvider) == Backend.local);

final demoDataPresentProvider = StreamProvider.autoDispose<bool>((ref) => ref.watch(demoDataRepositoryProvider).watchPresent());
