#!/usr/bin/env bash
# Create or update a CMS login (admin) with email/password in CMS4Cas-Dev or CMS4Cas.
#
#   bash app/tool/create_admin.sh --project dev --email someone@cms4cas.store --name "Full Name"
#
# Asks for the password (hidden) unless you pass --password-reset-link (prints a link the person
# uses to choose their own). All options: app/firebase/functions/scripts/create-user.js.
# Needs: Node.js 22+, and Google credentials for the project:
#   gcloud auth application-default login     (or --service-account <key.json>)
set -euo pipefail
APP_DIR="$(cd "$(dirname "$0")/.." && pwd)"
if [[ -d "$APP_DIR/firebase/functions" ]]; then FN="$APP_DIR/firebase/functions"; else FN="$(cd "$APP_DIR/../firebase/functions" && pwd)"; fi
[[ -d "$FN/node_modules/firebase-admin" ]] || npm --prefix "$FN" install --silent
exec npm --prefix "$FN" run -s create:admin -- "$@"
