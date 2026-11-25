#!/usr/bin/env bash
# Pre-release gate: everything that must be green before a build goes to users.
#
#   bash app/tool/release_check.sh            # analyze + all test suites
#   bash app/tool/release_check.sh --quick    # skip the Python book check and Functions tests
#
# Stops at the first failure. Run from anywhere.
set -euo pipefail
APP="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(cd "$APP/.." && pwd)"
QUICK=0; [[ "${1:-}" == "--quick" ]] && QUICK=1
step() { printf '\n▸ %s\n' "$1"; }

step "Generated code is up to date"
(cd "$APP" && dart run build_runner build -d >/dev/null)
if [[ -d "$ROOT/.git" ]] && ! git -C "$ROOT" diff --quiet -- '*.freezed.dart' '*.g.dart'; then
  echo "✗ build_runner changed generated files — commit them first:"; git -C "$ROOT" diff --stat -- '*.freezed.dart' '*.g.dart'; exit 1
fi

step "Static analysis (no errors or warnings)"
(cd "$APP" && flutter analyze --no-fatal-infos)

step "Engine tests"
(cd "$ROOT/packages/casino_engine" && dart test --reporter=compact)

step "App tests"
(cd "$APP" && flutter test --reporter=compact)

if [[ $QUICK == 0 ]]; then
  step "Cloud Functions tests"
  FN="$APP/firebase/functions"
  [[ -d "$FN/node_modules" ]] || npm --prefix "$FN" install --silent
  npm --prefix "$FN" test --silent

  if [[ -f "$ROOT/kb/book_formulas.py" ]]; then
    step "Book formulas (independent Python check)"
    python3 "$ROOT/kb/book_formulas.py" | tail -1
  fi
fi

step "Version"
grep -E '^version:' "$APP/pubspec.yaml"
echo; echo "✓ Ready to build. Bump the version in app/pubspec.yaml if this is a new store release."
