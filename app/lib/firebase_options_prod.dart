// Placeholder for the prod Firebase project. Generate the real file with:
//   flutterfire configure --project=<prod-project-id> --out=lib/firebase_options_prod.dart \
//     --android-package-name=com.cmskiss.cms_kiss --ios-bundle-id=com.cmskiss.cmsKiss --no-apply-gradle-plugins
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => throw UnsupportedError(
      'The prod Firebase project is not configured. Run flutterfire configure (see the comment at the top of lib/firebase_options_prod.dart).');
}
