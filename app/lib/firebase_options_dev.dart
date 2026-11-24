// Placeholder for the dev Firebase project. Generate the real file with:
//   flutterfire configure --project=<dev-project-id> --out=lib/firebase_options_dev.dart \
//     --android-package-name=com.cmskiss.cms_kiss.dev --ios-bundle-id=com.cmskiss.cmsKiss.dev --no-apply-gradle-plugins
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => throw UnsupportedError(
      'The dev Firebase project is not configured. Run flutterfire configure (see the comment at the top of lib/firebase_options_dev.dart).');
}
