#!/usr/bin/env bash
# Build and deploy the Flutter web app to Firebase Hosting.
#
#   bash app/tool/deploy_web.sh dev                  # → https://cms4cas-dev.web.app (CMS4Cas-Dev)
#   bash app/tool/deploy_web.sh prod                 # → https://cms4cas.web.app     (CMS4Cas)
#   bash app/tool/deploy_web.sh prod --preview qa    # temporary preview URL, live site untouched
#   bash app/tool/deploy_web.sh prod --build-only    # just build app/build/web
#
# Options
#   --casino <id>          CASINO_ID (default main)
#   --preview <channel>    deploy to a preview channel (expires after 7 days)
#   --build-only           build, don't deploy (output in app/build/web)
# Environment
#   APPCHECK_WEB_KEY       reCAPTCHA v3 site key for App Check on web (recommended for prod)
#
# Needs the real Firebase config (bash app/tool/firebase_setup.sh) and `firebase login`.
set -euo pipefail

FLAVOR="${1:-}"; shift || true
[[ "$FLAVOR" == "dev" || "$FLAVOR" == "prod" ]] || { echo "Usage: bash app/tool/deploy_web.sh dev|prod [--casino id] [--preview channel] [--build-only]"; exit 1; }
CASINO="main"; CHANNEL=""; BUILD_ONLY=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --casino) CASINO="$2"; shift 2 ;;
    --preview) CHANNEL="$2"; shift 2 ;;
    --build-only) BUILD_ONLY=1; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

APP_DIR="$(cd "$(dirname "$0")/.." && pwd)"
if [[ -d "$APP_DIR/firebase" ]]; then FB_DIR="$APP_DIR/firebase"; else FB_DIR="$(cd "$APP_DIR/../firebase" && pwd)"; fi
OPTIONS="$APP_DIR/lib/firebase_options_$FLAVOR.dart"

# Never ship placeholder config.
if [[ ! -f "$OPTIONS" ]] || grep -q "PLACEHOLDER\|is not configured" "$OPTIONS" || ! grep -q "static const FirebaseOptions web" "$OPTIONS"; then
  echo "✗ $OPTIONS is missing, a placeholder, or has no web config."
  echo "  Run: bash app/tool/firebase_setup.sh --skip-deploy"
  exit 1
fi

DEFINES=(--dart-define=FLAVOR="$FLAVOR" --dart-define=CASINO_ID="$CASINO")
[[ "$FLAVOR" == "dev" ]] && DEFINES+=(--dart-define=USE_FIREBASE=true)
if [[ -n "${APPCHECK_WEB_KEY:-}" ]]; then
  DEFINES+=(--dart-define=APPCHECK_WEB_KEY="$APPCHECK_WEB_KEY")
else
  echo "⚠ APPCHECK_WEB_KEY not set: App Check is off for this web build."
  [[ "$FLAVOR" == "prod" ]] && echo "  If App Check enforcement is on for CMS4Cas, the web app will be blocked — set the key first."
fi

cd "$APP_DIR"
echo "▸ Building web ($FLAVOR, casino \"$CASINO\")"
flutter pub get >/dev/null
# Self-host CanvasKit/fonts instead of loading them from gstatic: works on restricted casino networks.
flutter build web --release --no-web-resources-cdn "${DEFINES[@]}"
echo "✓ Built app/build/web"
[[ $BUILD_ONLY == 1 ]] && exit 0

command -v firebase >/dev/null || { echo "✗ firebase CLI not found: npm i -g firebase-tools"; exit 1; }
# The Firebase CLI only deploys files inside the folder holding firebase.json, so copy the build
# into app/firebase/hosting_public (git-ignored) — fresh each time, so no stale files are served.
PUBLIC="$FB_DIR/hosting_public"
rm -rf "$PUBLIC" && mkdir -p "$PUBLIC" && cp -R "$APP_DIR/build/web/." "$PUBLIC/"
find "$PUBLIC" -name '*.map' -delete   # don't publish source maps
echo "✓ Copied build to ${PUBLIC#$APP_DIR/../}"
cd "$FB_DIR"
if [[ -n "$CHANNEL" ]]; then
  echo "▸ Deploying preview channel \"$CHANNEL\" to $FLAVOR"
  firebase hosting:channel:deploy "$CHANNEL" --project "$FLAVOR" --expires 7d
else
  echo "▸ Deploying hosting to $FLAVOR"
  firebase deploy --only hosting --project "$FLAVOR"
fi
