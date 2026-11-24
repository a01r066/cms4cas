import 'package:uuid/uuid.dart';

/// New document id (UUID v4).
String newId() => const Uuid().v4();
