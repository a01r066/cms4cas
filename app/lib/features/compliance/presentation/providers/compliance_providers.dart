import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/backend_providers.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/compliance_remote_datasource.dart';
import '../../data/repositories/compliance_repository_impl.dart';
import '../../domain/entities/compliance_entities.dart';
import '../../domain/repositories/compliance_repository.dart';

final complianceDataSourceProvider =
    Provider((ref) => ComplianceRemoteDataSource(ref.watch(recordStoreProvider), ref.watch(functionsGatewayProvider)));

final complianceRepositoryProvider =
    Provider<ComplianceRepository>((ref) => ComplianceRepositoryImpl(ref.watch(complianceDataSourceProvider)));

final cashTxProvider = StreamProvider<List<CashTxRecord>>((ref) {
  if (ref.watch(currentUserValueProvider) == null) return Stream.value(const []);
  return ref.watch(complianceRepositoryProvider).watchCashTx();
});

final ctrProvider = StreamProvider<List<CtrReport>>((ref) {
  if (ref.watch(currentUserValueProvider) == null) return Stream.value(const []);
  return ref.watch(complianceRepositoryProvider).watchCtrs();
});

final barredProvider = StreamProvider<List<BarredPatron>>((ref) {
  if (ref.watch(currentUserValueProvider) == null) return Stream.value(const []);
  return ref.watch(complianceRepositoryProvider).watchBarred();
});

/// Roles that may read SAR cases (firestore.rules). Others get an empty list, never a permission error.
const kSarReadRoles = {'admin', 'compliance_officer', 'casino_manager', 'auditor'};

final canReadSarsProvider = Provider<bool>((ref) => kSarReadRoles.contains(ref.watch(currentUserValueProvider)?.role.wire));

final sarProvider = StreamProvider<List<SarCase>>((ref) {
  if (!ref.watch(canReadSarsProvider)) return Stream.value(const []);
  return ref.watch(complianceRepositoryProvider).watchSars();
});
