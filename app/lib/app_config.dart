/// Build-time configuration.
/// Local mode (default): data stays on the device.
/// Cloud mode: `flutter run --dart-define=USE_FIREBASE=true --dart-define=CASINO_ID=<id>`
/// after running `flutterfire configure` (which writes lib/firebase_options.dart).
const kUseFirebase = bool.fromEnvironment('USE_FIREBASE');
const kCasinoId = String.fromEnvironment('CASINO_ID', defaultValue: 'main');
