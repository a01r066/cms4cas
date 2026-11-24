/// Build flavors (flutter_flavorizr): `dev` and `prod`, separate Firebase projects.
///
/// Run: `flutter run --flavor dev` / `--flavor prod` (Android/iOS). Web has no
/// native flavors: pass `--dart-define=FLAVOR=prod`.
enum Flavor { dev, prod }

class F {
  static Flavor appFlavor = Flavor.dev;

  static String get name => appFlavor.name;
  static bool get isProd => appFlavor == Flavor.prod;

  static String get title => switch (appFlavor) {
        Flavor.dev => 'CMS4Cas (dev)',
        Flavor.prod => 'CMS4Cas',
      };

  /// prod always uses Firebase. dev uses device storage (no backend, no passwords)
  /// unless `--dart-define=USE_FIREBASE=true`.
  static bool get useFirebase => isProd || const bool.fromEnvironment('USE_FIREBASE');

  /// Each property's data lives under casinos/{casinoId}.
  static const casinoId = String.fromEnvironment('CASINO_ID', defaultValue: 'main');

  /// Firebase projects: CMS4Cas (prod) and CMS4Cas-Dev (dev). See app/tool/firebase_setup.sh.
  static String get firebaseProjectName => isProd ? 'CMS4Cas' : 'CMS4Cas-Dev';

  /// Cloud Functions region — must match setGlobalOptions in firebase/functions/src/index.js.
  static const functionsRegion = String.fromEnvironment('FUNCTIONS_REGION', defaultValue: 'asia-southeast1');

  /// Debug/profile builds (any flavor): a fixed App Check debug token (a UUID) registered once in the Firebase console,
  /// so every emulator / install / teammate uses the same one. Empty → the SDK generates a
  /// random token per install and logs it for registration.
  static const appCheckDebugToken = String.fromEnvironment('APPCHECK_DEBUG_TOKEN');

  /// reCAPTCHA v3 site key for App Check on web (prod). Empty → App Check not activated on web.
  static const appCheckWebKey = String.fromEnvironment('APPCHECK_WEB_KEY');

  static Flavor fromName(String? n) => Flavor.values.firstWhere((f) => f.name == n, orElse: () => Flavor.dev);
}
