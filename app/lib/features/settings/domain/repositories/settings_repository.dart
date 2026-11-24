import '../../../../core/typedefs/typedefs.dart';
import '../entities/app_settings.dart';

abstract interface class SettingsRepository {
  Stream<AppSettings> watch();
  ResultFuture<AppSettings> save(AppSettings settings);
}
