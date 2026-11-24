#!/usr/bin/env bash
# Connects the app to Firebase:  dev → "CMS4Cas-Dev",  prod → "CMS4Cas".
#
# Run once on your Mac from anywhere:   bash app/tool/firebase_setup.sh
#   --skip-deploy     only generate the app config, don't deploy rules/functions
#   DEV_PROJECT_ID=… PROD_PROJECT_ID=…   use these ids instead of looking projects up by name
#
# What it does
#   1. Finds the project ids of CMS4Cas-Dev and CMS4Cas (firebase projects:list).
#   2. flutterfire configure for each flavor → lib/firebase_options_{dev,prod}.dart,
#      registering Android/iOS/web apps with the flavor's package / bundle id.
#      Android: google-services.json per flavor (android/app/src/<flavor>/).
#      iOS: GoogleService-Info.plist per flavor (ios/config/<flavor>/), bound to that flavor's
#      Debug/Release/Profile build configurations only — a dev build never carries prod config.
#   3. Writes firebase/.firebaserc with aliases dev / prod.
#   4. Creates the Firestore database if missing and deploys rules + Cloud Functions to both.
set -euo pipefail

DEV_NAME="CMS4Cas-Dev"
PROD_NAME="CMS4Cas"
REGION="asia-southeast1"   # Firestore location + Functions region (Singapore)
DEV_ANDROID="store.cms4cas.app.dev"; DEV_IOS="store.cms4cas.app.dev"
PROD_ANDROID="store.cms4cas.app";    PROD_IOS="store.cms4cas.app"

APP_DIR="$(cd "$(dirname "$0")/.." && pwd)"
# firebase/ may live inside app/ or next to it.
if [[ -d "$APP_DIR/firebase" ]]; then FB_DIR="$APP_DIR/firebase"; else FB_DIR="$(cd "$APP_DIR/../firebase" && pwd)"; fi
DEPLOY=1
[[ "${1:-}" == "--skip-deploy" ]] && DEPLOY=0

need() { command -v "$1" >/dev/null 2>&1 || { echo "✗ '$1' not found — install with: $2"; exit 1; }; }
need node "https://nodejs.org (v24 LTS)"
need firebase "npm i -g firebase-tools"
need flutter "https://docs.flutter.dev/get-started/install"
need flutterfire "dart pub global activate flutterfire_cli   (and add ~/.pub-cache/bin to PATH)"

echo "▸ Checking Firebase login…"
firebase projects:list --json >/dev/null 2>&1 || firebase login

# Project id from display name (or the id itself).
resolve() {
  firebase projects:list --json | node -e '
    let s = ""; process.stdin.on("data", d => s += d).on("end", () => {
      const want = process.argv[1];
      const all = (JSON.parse(s).result || []);
      const m = all.filter(p => p.displayName === want || p.projectId === want || p.projectId === want.toLowerCase());
      if (m.length !== 1) {
        console.error(`✗ Expected one Firebase project named "${want}", found ${m.length}.`);
        console.error("  Your projects: " + all.map(p => `${p.displayName} (${p.projectId})`).join(", "));
        console.error("  Set DEV_PROJECT_ID / PROD_PROJECT_ID to choose explicitly.");
        process.exit(1);
      }
      console.log(m[0].projectId);
    });' "$1"
}

DEV_ID="${DEV_PROJECT_ID:-$(resolve "$DEV_NAME")}"
PROD_ID="${PROD_PROJECT_ID:-$(resolve "$PROD_NAME")}"
echo "▸ dev  → $DEV_NAME ($DEV_ID)"
echo "▸ prod → $PROD_NAME ($PROD_ID)"
[[ "$DEV_ID" == "$PROD_ID" ]] && { echo "✗ dev and prod resolve to the same project"; exit 1; }

cd "$APP_DIR"
flutter pub get >/dev/null

configure() { # flavor projectId androidPkg iosBundle
  local flavor=$1 id=$2 pkg=$3 bundle=$4
  mkdir -p "android/app/src/$flavor" "ios/config/$flavor"
  # The first run registers the apps and writes the Dart options; the iOS plist must be
  # attached to each of the flavor's build configurations (FlutterFire flavor setup).
  for cfg in Debug Release Profile; do
    echo "▸ flutterfire configure ($flavor → $id, iOS $cfg-$flavor)"
    flutterfire configure \
      --project="$id" \
      --out="lib/firebase_options_$flavor.dart" \
      --platforms=android,ios,web \
      --android-package-name="$pkg" \
      --ios-bundle-id="$bundle" \
      --android-out="android/app/src/$flavor/google-services.json" \
      --ios-out="ios/config/$flavor/GoogleService-Info.plist" \
      --ios-build-config="$cfg-$flavor" \
      --overwrite-firebase-options \
      --yes
  done
}
configure dev  "$DEV_ID"  "$DEV_ANDROID"  "$DEV_IOS"
configure prod "$PROD_ID" "$PROD_ANDROID" "$PROD_IOS"

# Each flutterfire run may append its Gradle plugin lines again; keep one of each.
for g in android/settings.gradle.kts android/app/build.gradle.kts; do
  awk '/START: FlutterFire Configuration/{f=1} /END: FlutterFire Configuration/{f=0}
       f && /id\(/ { if (seen[$0]++) next } { print }' "$g" > "$g.tmp" && mv "$g.tmp" "$g"
done

cat > "$FB_DIR/.firebaserc" <<JSON
{
  "projects": {
    "default": "$DEV_ID",
    "dev": "$DEV_ID",
    "prod": "$PROD_ID"
  }
}
JSON
echo "▸ Wrote firebase/.firebaserc (aliases: dev, prod)"

if [[ $DEPLOY == 1 ]]; then
  cd "$FB_DIR"
  echo "▸ Installing Cloud Functions dependencies"
  npm --prefix functions install --silent
  for alias in dev prod; do
    id=$([[ $alias == dev ]] && echo "$DEV_ID" || echo "$PROD_ID")
    if ! firebase firestore:databases:list --project "$id" 2>/dev/null | grep -q "(default)"; then
      echo "▸ Creating Firestore database in $REGION for $id"
      firebase firestore:databases:create "(default)" --location="$REGION" --project "$id"
    fi
    echo "▸ Deploying rules + functions to $alias ($id)"
    firebase deploy --only firestore:rules,functions --project "$alias" --non-interactive
  done
fi

cat <<TXT

✓ Firebase connected.  dev → $DEV_ID   prod → $PROD_ID

Do these once in the Firebase console for BOTH projects (no CLI for them):
  • Authentication → Sign-in method → enable Email/Password
  • Authentication → Users → add your own account
  • Billing: Cloud Functions need the Blaze plan
  • (prod) App Check → register the web app with reCAPTCHA v3 and pass the site key as
    --dart-define=APPCHECK_WEB_KEY=<key> when building web

Run:
  flutter run --flavor dev --dart-define=USE_FIREBASE=true     # CMS4Cas-Dev
  flutter run --flavor prod                                     # CMS4Cas
  flutter run -d chrome --dart-define=FLAVOR=dev --dart-define=USE_FIREBASE=true
Then sign in and choose "Set up as first administrator".
TXT
