import 'package:flutter/services.dart' show appFlavor;
import 'package:flutter_web_plugins/url_strategy.dart';

import 'bootstrap.dart';
import 'flavors.dart';

void main() {
  // --flavor on Android/iOS; --dart-define=FLAVOR on web.
  F.appFlavor = F.fromName(appFlavor ?? const String.fromEnvironment('FLAVOR', defaultValue: 'dev'));
  // Web: clean URLs (/players/abc) instead of /#/players/abc; Firebase Hosting rewrites them to index.html.
  usePathUrlStrategy();
  bootstrap();
}
