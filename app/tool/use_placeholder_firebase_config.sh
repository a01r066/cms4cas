#!/usr/bin/env bash
# Fresh clone without Firebase access: install placeholder Firebase config so the app builds
# and runs on the local (no-backend) dev flavor. Never overwrites real config.
#
#   bash app/tool/use_placeholder_firebase_config.sh
#
# With access to CMS4Cas / CMS4Cas-Dev, run app/tool/firebase_setup.sh instead — it generates
# the real files. Both sets of files are listed in .gitignore and never reach GitHub.
set -euo pipefail
APP="$(cd "$(dirname "$0")/.." && pwd)"
T="$APP/config/firebase_placeholders"
put() { # template destination
  if [[ -e "$APP/$2" ]]; then echo "  keep     $2 (already present)"; else mkdir -p "$(dirname "$APP/$2")"; cp "$T/$1" "$APP/$2"; echo "  created  $2"; fi
}
for f in dev prod; do
  put "$f/firebase_options_$f.dart"   "lib/firebase_options_$f.dart"
  put "$f/google-services.json"       "android/app/src/$f/google-services.json"
  put "$f/GoogleService-Info.plist"   "ios/config/$f/GoogleService-Info.plist"
done
put "firebase.json" "firebase.json"
echo "Placeholder Firebase config in place. Run: flutter run --flavor dev   (local backend, no Firebase)"
