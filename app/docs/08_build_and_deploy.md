# 08 · Build and deploy

How a change goes from your machine to users: web (Firebase Hosting), Android (Google Play), iOS (App Store), and the Firebase backend (Firestore rules and Cloud Functions). One-time Firebase setup, App Check debug tokens and creating logins are in the [README](../../README.md#firebase).

## Environments

| | dev | prod |
|---|---|---|
| Firebase project | CMS4Cas-Dev (`cms4cas-dev`, alias `dev`) | CMS4Cas (`cms4cas`, alias `prod`) |
| Web | https://cms4cas-dev.web.app | https://cms4cas.web.app |
| Android / iOS id | `store.cms4cas.app.dev` | `store.cms4cas.app` |
| Backend | local by default; Firebase with `USE_FIREBASE=true` | always Firebase |
| App Check | debug provider (register a debug token) | Play Integrity, App Attest → DeviceCheck, reCAPTCHA v3 on web |
| Crashlytics | off | on |
| Demo data | allowed (`tool/seed_demo_data.sh`) | **never** — the script refuses prod |

Everything goes to **dev first**, is checked there, then the same commit goes to prod.

## Toolchain

| Tool | Version used | Needed for |
|---|---|---|
| Flutter / Dart | 3.50.1 / 3.14 | everything |
| Node.js | 24 (Functions runtime `nodejs24`) | Functions, scripts |
| firebase-tools | 15 | deploys, emulators |
| flutterfire_cli | latest | generating Firebase config |
| JDK | 17 | Android |
| Android Studio / SDK | AGP 9 | Android |
| Xcode | current, with an Apple Developer team | iOS |
| gcloud CLI (optional) | — | Admin SDK scripts (create users, seed demo data) |

Check with `flutter doctor -v`, `node -v`, `firebase --version`.

## Release workflow

1. **Start from a clean, up-to-date `main`.** `git status` shows nothing to commit; `git pull`.
2. **Run the gate:** `bash app/tool/release_check.sh` — generated code current, analyzer clean, engine, app and Functions tests, the independent book-formula check. Don't build if anything fails.
3. **Bump the version** in `app/pubspec.yaml` for any store release: `version: 1.2.0+7` — the part before `+` is what users see (`versionName` / `CFBundleShortVersionString`); the number after `+` is the build number and **must increase on every upload** to Google Play or App Store Connect. Web-only releases may keep the version.
4. **Commit and tag:** `git commit -am "Release 1.2.0+7"`, `git tag v1.2.0+7`.
5. **Deploy the backend first** when rules or Functions changed (see below), dev then prod.
6. **Deploy to dev**, check it, then **prod** — web via a preview channel, apps via internal testing / TestFlight.
7. **Push the tag:** `git push && git push --tags`.

### Order of backend and app changes

| Change | Order |
|---|---|
| New callable, new field, looser rule | Backend first, then apps |
| Removed or renamed callable, stricter rule | Apps first; remove the old backend piece only once old app versions are gone |
| Both in one release | Make the backend accept old and new clients for one release |

Web users get the new version on their next page load; phone users keep old versions until they update, so backend changes must stay backward compatible for a while.

## Backend: Firestore rules and Cloud Functions

```bash
cd app/firebase
firebase emulators:start --only auth,firestore,functions      # optional: try changes locally first
firebase deploy --only firestore:rules,functions --project dev
firebase deploy --only firestore:rules,functions --project prod
```

- Functions run in `asia-southeast1` on Node 24; the region must match `FUNCTIONS_REGION` in the apps (default is the same).
- Rules-only change: `--only firestore:rules`. One function: `--only functions:issueMarker`.
- Rules apply immediately to every client, so test them in the emulator first.

## Web (Firebase Hosting)

```bash
bash app/tool/deploy_web.sh dev                                  # build + deploy to https://cms4cas-dev.web.app

export APPCHECK_WEB_KEY=<reCAPTCHA v3 site key for CMS4Cas>
bash app/tool/deploy_web.sh prod --preview rc                    # build + deploy to a preview URL (7 days); live site untouched
#   → open the preview URL it prints, sign in, check Home, Tables, Credit, Compliance
firebase hosting:clone cms4cas:rc cms4cas:live --project prod    # promote exactly what you checked (run in app/firebase)
```

`deploy_web.sh prod` without `--preview` deploys straight to live; use it for urgent fixes only. Other options: `--casino <id>` (`CASINO_ID`, default `main`) and `--build-only` (just `app/build/web`).

What the script does: refuses placeholder Firebase config, builds the flavor (`--release`, CanvasKit self-hosted), copies the build into `app/firebase/hosting_public/` (git-ignored; the Firebase CLI only deploys from its own folder), removes source maps and deploys. Caching and security headers are in `app/firebase/firebase.json`:
- `index.html`, JS and the service worker are revalidated on every load (`no-cache`), so a deploy reaches users on their next page load.
- Fonts, wasm and images are cached for one day.
- Headers block framing and indexing.

**Prod web requires `APPCHECK_WEB_KEY`** once App Check enforcement is on, otherwise every request is refused. A custom domain needs adding under Hosting **and** under Authentication → Settings → Authorized domains.

**Rollback:** Firebase console → Hosting → *Release history* → ⋮ → **Rollback** on the previous release (instant). Or check out the previous tag and run `deploy_web.sh prod` again.

## Android (Google Play)

### One-time: upload key and signing

1. Create an upload key and keep it **outside the repo**:
   ```bash
   keytool -genkey -v -keystore ~/keys/cms4cas-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
2. `cp app/android/key.properties.example app/android/key.properties` and fill in the path and passwords. Both the key file and `key.properties` are git-ignored. Store them in your password manager. Losing the upload key means a reset request to Google.
3. Without `key.properties`, release builds are signed with the debug key (fine for `flutter run --release`, rejected by Google Play).
4. In Play Console, create the app `store.cms4cas.app` and enrol in **Play App Signing** (Google holds the app signing key; you upload with the upload key).
5. **App Check (Play Integrity):** in Firebase console → Project settings → the prod Android app → add the **SHA-256 of the app signing key** (Play Console → Setup → App signing). Link the Firebase project's Google Cloud project in Play Console → App integrity. Then register the app under App Check → Play Integrity.

### Build and upload

```bash
cd app
flutter build appbundle --release --flavor prod --dart-define=CASINO_ID=main \
  --obfuscate --split-debug-info=build/symbols/android
firebase crashlytics:symbols:upload --app=<prod Android app id> build/symbols/android
```

Upload `build/app/outputs/bundle/prodRelease/app-prod-release.aab` to **Internal testing**, install from Play on a real device, sign in, check a few screens, then promote to Production. The app id comes from `lib/firebase_options_prod.dart` (`android.appId`). Keep `build/symbols/` for each release (not in git) — Crashlytics needs it to read obfuscated stack traces.

Dev build for testers: `flutter build apk --release --flavor dev --dart-define=USE_FIREBASE=true` (installs alongside prod; register the device's App Check debug token, see README).

## iOS (App Store)

### One-time

1. Open `app/ios/Runner.xcworkspace` in Xcode → target **Runner** → *Signing & Capabilities*: select your team for every configuration (`Debug-prod`, `Release-prod`, `Profile-prod`, and the `-dev` ones). Bundle ids are set per flavor.
2. Add the **App Attest** capability for the prod configurations (App Check then uses App Attest; without it, the app falls back to DeviceCheck, which works but is weaker). In App Check → Apps, register the prod iOS app with App Attest (and DeviceCheck with your `.p8` key).
3. In App Store Connect, create the app `store.cms4cas.app`.

### Build and upload

```bash
cd app
flutter build ipa --release --flavor prod --dart-define=CASINO_ID=main \
  --obfuscate --split-debug-info=build/symbols/ios
firebase crashlytics:symbols:upload --app=<prod iOS app id> build/symbols/ios
```

Upload `build/ios/ipa/*.ipa` with **Transporter** or Xcode → Organizer (or open `build/ios/archive/Runner.xcarchive`), test through **TestFlight** on a real device, then submit for review. App Attest does not work on the simulator; use a device, or a debug build with a debug token.

## Configuration per build

| Define | Web | Android / iOS | Notes |
|---|---|---|---|
| `FLAVOR` | set by `deploy_web.sh` | use `--flavor dev|prod` | |
| `CASINO_ID` | `--casino` | `--dart-define` | must match the casino used by `create_user.sh` and `seed_demo_data.sh` (default `main`) |
| `USE_FIREBASE` | dev only | dev only | prod always uses Firebase |
| `APPCHECK_WEB_KEY` | prod (and dev if enforced) | — | reCAPTCHA v3 site key |
| `APPCHECK_DEBUG_TOKEN` | — | dev / debug builds | never in prod release builds |
| `FUNCTIONS_REGION` | rarely | rarely | default `asia-southeast1` |

Firebase config files (`lib/firebase_options_*.dart`, `google-services.json`, `GoogleService-Info.plist`) come from `bash app/tool/firebase_setup.sh` and are git-ignored. A fresh clone without Firebase access runs `bash app/tool/use_placeholder_firebase_config.sh` and can build and test the dev flavor on the local backend, but `deploy_web.sh` refuses to ship placeholders.

## Before the first production release

- [ ] Email/Password sign-in enabled in both projects; Blaze plan on both.
- [ ] Rules and Functions deployed to prod; the first administrator created (`tool/create_admin.sh --project prod`).
- [ ] App Check: web reCAPTCHA v3 key, Play Integrity with the app signing SHA-256, App Attest/DeviceCheck registered. Check the App Check metrics show verified requests, **then** turn on enforcement for Firestore, Functions and Auth.
- [ ] Android upload key and `key.properties` in place; Play App Signing enabled.
- [ ] iOS team and App Attest capability set.
- [ ] Settings → jurisdiction thresholds confirmed against current local regulation (the defaults are the book's Nevada 2003 figures).
- [ ] No demo data in prod (`demo-` ids); demo logins exist only in CMS4Cas-Dev.
- [ ] Crashlytics receives a test crash from a prod build (then remove the test).

## Don'ts

- Don't commit Firebase config, `key.properties`, keystores, service-account keys, App Check debug tokens or `.p8` keys. `.gitignore` covers them, so check `git status` before every commit anyway.
- Don't deploy from a dirty working tree or an untagged commit.
- Don't run the Admin SDK scripts (`create_user.sh`, `seed_demo_data.sh`) against prod with a personal key on a shared machine.
- Don't turn on App Check enforcement before every client type reports verified requests.
