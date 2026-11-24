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
        Flavor.dev => 'CMS (dev)',
        Flavor.prod => 'CMS',
      };

  /// prod always uses Firebase. dev uses device storage (no backend, no passwords)
  /// unless `--dart-define=USE_FIREBASE=true`.
  static bool get useFirebase => isProd || const bool.fromEnvironment('USE_FIREBASE');

  /// Each property's data lives under casinos/{casinoId}.
  static const casinoId = String.fromEnvironment('CASINO_ID', defaultValue: 'main');

  /// reCAPTCHA v3 site key for App Check on web (prod). Empty → App Check not activated on web.
  static const appCheckWebKey = String.fromEnvironment('APPCHECK_WEB_KEY');

  static Flavor fromName(String? n) => Flavor.values.firstWhere((f) => f.name == n, orElse: () => Flavor.dev);
}
