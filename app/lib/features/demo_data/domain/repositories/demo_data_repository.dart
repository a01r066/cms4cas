import '../../../../core/typedefs/typedefs.dart';

abstract class DemoDataRepository {
  /// Generates the demo set (dates relative to now) and writes it. Returns records written.
  ResultFuture<int> load();

  /// Removes all demo records, keeping [keepUserId]'s profile. Returns records removed.
  ResultFuture<int> remove({String? keepUserId});

  Stream<bool> watchPresent();
}
