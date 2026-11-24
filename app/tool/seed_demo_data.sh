#!/usr/bin/env bash
# Load demo data into CMS4Cas-Dev (refuses production): regenerates the data set from the
# app's generator, writes it to Firestore and creates the demo staff logins.
#
#   bash app/tool/seed_demo_data.sh                 # load (asks for one password for all demo logins)
#   bash app/tool/seed_demo_data.sh --remove        # delete demo docs and demo logins
#   bash app/tool/seed_demo_data.sh --casino main --no-logins
#
# Needs: Flutter/Dart, Node.js 22+, and Google credentials for the dev project:
#   gcloud auth application-default login     (or --service-account <key.json>)
set -euo pipefail
APP_DIR="$(cd "$(dirname "$0")/.." && pwd)"
FN="$APP_DIR/firebase/functions"
[[ -d "$FN/node_modules/firebase-admin" ]] || npm --prefix "$FN" install --silent
if [[ " $* " != *" --remove "* ]]; then
  (cd "$APP_DIR" && dart run tool/export_demo_data.dart --out firebase/seed/demo_data.json)
fi
exec npm --prefix "$FN" run -s seed:demo -- --project dev "$@"
