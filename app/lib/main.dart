import 'package:flutter/services.dart' show appFlavor;

import 'bootstrap.dart';
import 'flavors.dart';

void main() {
  // --flavor on Android/iOS; --dart-define=FLAVOR on web.
  F.appFlavor = F.fromName(appFlavor ?? const String.fromEnvironment('FLAVOR', defaultValue: 'dev'));
  bootstrap();
}
