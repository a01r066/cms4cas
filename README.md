# CMS — Casino Management

A Flutter app (web, Android, iOS) built from **Kilby, Fox & Lucas — _Casino Operations Management_, 2nd ed. (Wiley, 2005)**. It turns the book's formulas, procedures and controls into working tools for the pit, cage, credit, compliance, marketing and management, with every calculation tied back to the page it comes from.

**v1 modules:** player rating & comps · table games accounting & hold · credit & markers · currency compliance (MTL, aggregation, CTR, barred list, SAR) · promotion & deal evaluator · staffing & table-opening economics · knowledge library · settings, users & roles.

## Repository

```
app/                      Flutter app — open THIS folder in Android Studio / VS Code
  firebase/               Firestore rules, Cloud Functions for privileged actions, hosting config
  docs/                   PRD, journeys, architecture, data model, UI/UX, testing report, user guide, screenshots
packages/casino_engine/   Pure-Dart calculation engine with book citations (65 golden tests)
kb/                       Knowledge base: chapter notes, 168-term glossary, reference tables,
                          independent Python implementation of 45 book examples
```

| Doc | |
|---|---|
| [01 PRD](app/docs/01_PRD.md) | Vision, roles, scope, book vs. app additions |
| [02 User journeys](app/docs/02_user_journeys.md) | Mermaid flows for each role |
| [03 Architecture](app/docs/03_architecture.md) | Layers, flavors, backends, roles & permissions, security |
| [04 Data model](app/docs/04_data_model.md) | Collections, fields, who may write what |
| [05 UI/UX](app/docs/05_ui_ux.md) | Principles, layout, screens |
| [06 Testing report](app/docs/06_testing_report.md) | Results, book cross-checks, errata, limitations |
| [07 User guide](app/docs/07_user_guide.md) | How to use each module |
| [08 Build and deploy](app/docs/08_build_and_deploy.md) | Release workflow, web/Android/iOS builds, signing, App Check, rollback |

## Tech stack

| Concern | Package |
|---|---|
| State / DI | `flutter_riverpod` 3 (`Provider`, `StreamProvider`, `StateNotifier` from `legacy.dart`) |
| Models | `freezed` 4 + `json_serializable` (`build.yaml`: `explicit_to_json`) |
| Errors | `dartz` — `ResultFuture<T> = Future<Either<Failure, T>>` |
| Routing | `go_router` 18 — `StatefulShellRoute.indexedStack` |
| Flavors | `flutter_flavorizr` — `dev`, `prod` |
| Backend | Firebase Auth, Firestore, Cloud Functions, App Check, Crashlytics — or a local device backend in dev |
| Domain maths | `casino_engine` (path package, `dart:math` only) |

## Architecture at a glance

The app follows the `flutter-riverpod-firebase-architecture` conventions. Every feature with data looks the same:

```
app/lib/
  main.dart · flavors.dart · bootstrap.dart · firebase_options_{dev,prod}.dart
  app/        app.dart, session_cleanup.dart, local_backend.dart
  core/       error/ typedefs/ storage/ backend/ session/ routing/ theme/ widgets/ util/
  shared/providers/   prefs, firebase, backend (RecordStore + FunctionsGateway)
  features/<feature>/
    data/datasources/     <feature>_remote_datasource.dart   (+ <feature>_local_actions.dart)
    data/models/          @freezed + fromJson/toJson + fromEntity/toEntity
    data/repositories/    <feature>_repository_impl.dart     try/catch → Either<Failure, T>
    domain/entities/      @freezed, no JSON
    domain/repositories/  abstract interface
    presentation/providers/  <feature>_providers.dart · _state.dart · _notifier.dart
    presentation/pages/ · presentation/widgets/
```

Features with data: `auth`, `settings`, `players`, `tables`, `credit`, `compliance`; `demo_data` loads and removes test data. Calculator-only features (`home`, `evaluate`, `staffing`, `library`) have only `presentation/pages`.

Look and feel: one brand palette (forest green, lime, mint) in `core/theme/theme.dart`, with a phone layout (floating bottom bar) and a quieter desktop layout at ≥ 1000 px (sidebar, hold chart on Home and Tables). Details and screenshots: [`app/docs/05_ui_ux.md`](app/docs/05_ui_ux.md).

- **Datasources throw, repositories return `Either`.** Widgets only show `Failure.displayMessage`.
- **Reads** are `StreamProvider`s keyed on the signed-in operator (empty when signed out). **Writes** go through one `StateNotifier` per feature.
- **The client never writes privileged state.** These go through named actions — Cloud Functions on Firebase, Dart handlers with the same checks on the local backend:

  | Action | Rule enforced server-side |
  |---|---|
  | `setUserRole` | Only an admin assigns roles; the first user of an empty casino may only make themself admin; removes the registrant's access request |
  | `signCreditApplication` | Signer must hold a credit role; one signature per person; stamped from the server profile |
  | `decideCreditApplication` | Approve only when Table 6.2 is met and, for referred files, the Credit Manager has signed |
  | `issueMarker` | Amount ≤ available credit (approved line − open markers) |
  | `recordMarkerPayment` | 0 < amount ≤ balance |
  | `signMarkerWriteOff` / `writeOffMarker` | Two of President/GM, VP Finance, Credit Manager, Director of Cage (p.105) |
  | `advanceCtr` | Required fields before *prepared*; reviewer ≠ preparer; filed only after review |

## Requirements

- Flutter **3.50+** (Dart 3.14) — `flutter --version`
- For Firebase: Firebase CLI (`npm i -g firebase-tools`), FlutterFire CLI (`dart pub global activate flutterfire_cli`), Node.js 24 for Functions (Cloud Functions runtime `nodejs24`; Node 20 was decommissioned on 2026-10-30)
- iOS builds: macOS with Xcode

## Open in the IDE

1. **File → Open** the `app/` folder (not the repository root).
2. If the IDE says *Dart SDK is not configured*: **Settings → Languages & Frameworks → Flutter → Flutter SDK path** (the Dart SDK comes with Flutter).
3. `flutter pub get`.
4. Run configurations: set **Build flavor** to `dev` or `prod` (Android/iOS), or pick Chrome for web.

## Firebase config is not in git

The Firebase app config files contain API keys, so they are in `.gitignore`: `app/lib/firebase_options_{dev,prod}.dart`, `app/android/app/src/<flavor>/google-services.json`, `app/ios/config/<flavor>/GoogleService-Info.plist` and FlutterFire's `app/firebase.json`. After cloning, create them one of two ways:

| You have… | Run (from the repo root) | Result |
|---|---|---|
| access to CMS4Cas / CMS4Cas-Dev | `bash app/tool/firebase_setup.sh --skip-deploy` | real config for both flavors |
| no Firebase access | `bash app/tool/use_placeholder_firebase_config.sh` | placeholders from `app/config/firebase_placeholders/` — builds and runs on the local backend; Firebase mode explains what to run |

Neither script overwrites files that are already there (except `firebase_setup.sh`, which regenerates the real ones).

## Run locally (dev flavor, no backend)

```bash
bash app/tool/use_placeholder_firebase_config.sh   # first time on a fresh clone, if you have no Firebase access
cd app
flutter pub get
flutter run -d chrome              # web: dev flavor by default
flutter run --flavor dev           # Android / iOS
```

Data is stored on the device (browser localStorage on web). On first launch create the administrator. **The local backend has no passwords** — use it for evaluation, demos and training only.

## Demo / test data

A realistic data set that exercises every screen. It's built by `features/demo_data/data/demo_data_generator.dart` from the app's own models and the engine formulas, so the numbers agree (theo, win/hold, Table 6.2 signatures, CTR aggregates). Dates are relative to today, and every id starts with `demo-`, so it can be removed without touching real records.

| Area | What you get |
|---|---|
| Staff | 9 users, one per role, with credit authority: admin/President, Casino Manager, Credit Manager, VP Finance, Host, Pit, Cage (Director of Cage), Compliance, Auditor |
| Players & ratings | 14 players (2 without ID on file); ~50 rated sessions over 30 days, including the book's roulette example (theo $1,065.15, p.221) |
| Tables | 10 tables (BJ, craps, roulette, baccarat; BA-02 uses name credit); 14 days × 3 shifts; BJ-04 holds below objective (Investigate); one documented BA-01 hit |
| Credit | Lines approved under Table 6.2; one awaiting a signature, one referred to the Credit Manager (4 in 14), a draft, a decline |
| Markers | Open markers in every aging bucket, a partial payment, one paid, one settled with a 2-signature write-off, one write-off waiting for a 2nd signature |
| Compliance | Today's reportable cash-in with no CTR yet (Home alert), a CTR draft for an unidentified patron, a filed CTR, MTL entries, near-threshold structuring with an open SAR case, a SAR due within a week, a filed SAR, barred patrons, one access request |

**Local backend (no Firebase):** sign in as an administrator → **Settings → Demo data → Load demo data**. The demo staff then appear in the sign-in list, so you can try each role. **Remove demo data** deletes every `demo-` record and keeps your own profile.

**CMS4Cas-Dev (Firebase):** load from a terminal (it refuses the production project). The script uses the Admin SDK, which needs Google credentials for the dev project — `firebase login` alone is not enough:

```bash
# Option A: your Google account (gcloud CLI)
gcloud auth application-default login
gcloud auth application-default set-quota-project cms4cas-dev   # without it, creating logins fails
# Option B: a service-account key (Firebase console → Project settings → Service accounts), kept outside the repo
#   add --service-account ~/keys/cms4cas-dev-admin.json to the commands below

bash app/tool/seed_demo_data.sh                  # regenerates the data, writes Firestore, creates logins
bash app/tool/seed_demo_data.sh --remove         # deletes demo documents and demo logins
bash app/tool/seed_demo_data.sh --no-logins      # data only
```

The script asks for one password for all demo logins: `demo.admin@cms4cas.test`, `demo.cm@…`, `demo.credit@…`, `demo.vpf@…`, `demo.host@…`, `demo.pit@…`, `demo.cage@…`, `demo.compliance@…`, `demo.auditor@…`. The generated `app/firebase/seed/demo_data.json` is git-ignored. Set `FIREBASE_AUTH_EMULATOR_HOST` and `FIRESTORE_EMULATOR_HOST` to seed the emulators instead.

## Code generation

Generated `*.freezed.dart` and `*.g.dart` files are committed. After changing an entity, model or state class:

```bash
cd app
dart run build_runner build -d     # or: dart run build_runner watch -d
```

## Adding a feature

1. Create `features/<name>/` with the folders above (copy a small feature such as `settings` as a template).
2. Entity in `domain/entities` (freezed, no JSON) → model in `data/models` (freezed + `fromJson` + `fromEntity`/`toEntity`); enums store a `wire` value with a safe `fromWire` fallback.
3. Datasource over `recordStoreProvider` (and `functionsGatewayProvider` for privileged writes) → repository interface + impl returning `ResultFuture`.
4. Providers: datasource/repository `Provider`s, a `StreamProvider` that returns empty when `currentUserValueProvider` is null, a freezed state and a `StateNotifier`.
5. Privileged writes: add a Cloud Function in `app/firebase/functions/src/index.js`, its Dart twin in `data/datasources/<name>_local_actions.dart`, register it in `app/local_backend.dart`, and deny the client write in `app/firebase/firestore.rules`.
6. Add the route in `core/routing/route_names.dart` and `app_router.dart` (and `navItems` if it is a tab).
7. `dart run build_runner build -d`, then a notifier test using `test/helpers.dart`.

## Tests

```bash
cd packages/casino_engine && dart pub get && dart test     # 65 engine tests (book examples, rules)
cd ../../app && flutter test                                # 38 app tests (models, domain, notifiers, registration, demo data, widgets)
cd firebase/functions && npm install && npm test            # Functions load + Table 6.2 port (from app/)
cd ../../.. && python3 kb/book_formulas.py                  # 45 book examples (independent Python check)
```

Or all of them, plus analyzer and generated-code check, in one go: `bash app/tool/release_check.sh`.

## Firebase

| Flavor | Firebase project | Android package | iOS bundle id |
|---|---|---|---|
| dev | **CMS4Cas-Dev** | `store.cms4cas.app.dev` | `store.cms4cas.app.dev` |
| prod | **CMS4Cas** | `store.cms4cas.app` | `store.cms4cas.app` |

Region: `asia-southeast1` (Singapore) for Firestore and Cloud Functions.

**One-time setup (on your Mac):**

```bash
npm i -g firebase-tools
dart pub global activate flutterfire_cli
bash app/tool/firebase_setup.sh            # add --skip-deploy to only generate the app config
```

The script logs in if needed, finds both projects by name, runs `flutterfire configure` for each flavor (→ `lib/firebase_options_{dev,prod}.dart`, Android `google-services.json` in `android/app/src/<flavor>/`, iOS `GoogleService-Info.plist` in `ios/config/<flavor>/` bound to that flavor's build configurations), writes `app/firebase/.firebaserc` with the `dev`/`prod` aliases, creates the Firestore database if missing, and deploys rules and functions to both projects. If your project ids differ from what it finds, pass `DEV_PROJECT_ID=… PROD_PROJECT_ID=…`.

Then, in the Firebase console for **both** projects:
- Authentication → Sign-in method → enable **Email/Password**, and add your account under Users.
- Upgrade to the **Blaze** plan (needed for Cloud Functions).
- prod only: App Check → register the web app with reCAPTCHA v3; build web with `--dart-define=APPCHECK_WEB_KEY=<key>`.

**Run:**

```bash
cd app
flutter run --flavor dev --dart-define=USE_FIREBASE=true     # CMS4Cas-Dev
flutter run --flavor prod                                     # CMS4Cas (always Firebase)
flutter run -d chrome --dart-define=FLAVOR=dev --dart-define=USE_FIREBASE=true
```

**Accounts:**
- Staff register themselves on the sign-in screen (*Create an account*: name, work email, password ≥ 8 characters). Registering gives **no access**: it files a request, and the person sees a waiting screen until an administrator assigns a role.
- The very first account of a new casino chooses **Set up as first administrator** (allowed only while the casino has no users).
- Administrators approve registrations in **Settings → Users and roles → Waiting for a role** (*Assign role* / *Dismiss*). You can still create accounts yourself in Firebase Authentication and add them there by email.
- *Forgot password?* on the sign-in screen sends a reset email; new accounts get a verification email.

### App Check debug token (dev, simulators, debug builds)

Only **prod release** builds use real attestation (Play Integrity / App Attest — they don't work on simulators or in debug builds). Every other run — dev, or prod in debug on a simulator — uses App Check's debug provider. Register one fixed token for the dev app once, then pass it to every dev run so emulators, reinstalls and teammates all use it:

```bash
TOKEN=$(uuidgen)                      # keep it private, like a password — don't commit it
cd app/firebase && firebase appcheck:debugtokens:create "$TOKEN" --project dev --app <dev Android app id>   # repeat for the iOS app id
cd .. && flutter run --flavor dev --dart-define=USE_FIREBASE=true --dart-define=APPCHECK_DEBUG_TOKEN=$TOKEN
# prod in debug (simulator): register the token for the prod apps too (--project prod), then
flutter run --flavor prod --dart-define=APPCHECK_DEBUG_TOKEN=$TOKEN
```

App ids are in `lib/firebase_options_dev.dart` (`appId`) or Firebase console → Project settings. You can also add the token in Firebase console → App Check → Apps → ⋮ → *Manage debug tokens*. Without `APPCHECK_DEBUG_TOKEN` the SDK makes a random token per install and logs the command to register it. Only turn on App Check **enforcement** (Firestore, Auth, Functions) once your dev token and prod providers are registered.

### Create logins from the command line

For setting up a casino, or adding staff without the sign-up screen. Runs with the Admin SDK, so only project owners can use it; it creates (or updates) the Firebase Auth account **and** the CMS profile with its role, and clears any pending registration.

```bash
gcloud auth application-default login        # once; or pass --service-account <key.json>

# Administrator (prompts for the password, hidden)
bash app/tool/create_admin.sh --project dev  --email admin@cms4cas.store --name "Thanh Nguyen"

# Staff user with a role (and optionally credit signing authority)
bash app/tool/create_user.sh  --project prod --email floor1@cms4cas.store --name "Floor One" --role pit_supervisor
bash app/tool/create_user.sh  --project prod --email cm@cms4cas.store --name "Credit Mgr" --role credit_executive --credit-role credit_manager

# Let the person choose their own password: prints a reset link to send them
bash app/tool/create_user.sh  --project prod --email cage1@cms4cas.store --name "Cage One" --role cage_cashier --password-reset-link
```

| Option | |
|---|---|
| `--project` | `dev`, `prod` (from `app/firebase/.firebaserc`) or a project id |
| `--role` | `admin`, `casino_manager`, `pit_supervisor`, `cage_cashier`, `credit_executive`, `compliance_officer`, `marketing`, `auditor` |
| `--credit-role` | `president`, `vp_finance`, `casino_manager`, `credit_manager`, `shift_manager`, `host`, `cage_director`, or `none` to remove. Omitted on an existing user: kept |
| `--casino` | default `main` (must match `--dart-define=CASINO_ID`) |
| `--password-reset-link` | create without a password and print a link for the person |
| `--update-password` | for an existing account, also set a new password |
| `--password <pw>` | non-interactive (avoid: it stays in shell history) |

Running it again for an existing email updates the role and name and keeps the password. Accounts created this way are marked email-verified. To try it safely, start the emulators (`cd app/firebase && firebase emulators:start --only auth,firestore --project demo-cms4cas`) and export `FIREBASE_AUTH_EMULATOR_HOST=127.0.0.1:9099 FIRESTORE_EMULATOR_HOST=127.0.0.1:8080`.

Later deploys: `cd app/firebase && firebase deploy --only firestore:rules,functions --project dev` (or `prod`). Each property uses its own `CASINO_ID`; data lives under `casinos/{CASINO_ID}/…`. Test rules and functions in the emulator before going live: `firebase emulators:start --only firestore,functions`.

### Build-time options

| `--dart-define` | Default | Meaning |
|---|---|---|
| `FLAVOR` | `dev` | Flavor on web (Android/iOS use `--flavor`); `deploy_web.sh` sets it |
| `USE_FIREBASE` | `false` | dev only: use CMS4Cas-Dev instead of the local backend (prod always uses CMS4Cas) |
| `CASINO_ID` | `main` | Property whose data to use |
| `APPCHECK_WEB_KEY` | — | reCAPTCHA v3 site key for App Check on web |
| `APPCHECK_DEBUG_TOKEN` | — | debug/profile builds: fixed App Check debug token registered in the console |
| `FUNCTIONS_REGION` | `asia-southeast1` | Must match `setGlobalOptions` in `app/firebase/functions/src/index.js` |

## Build and deploy

Full guide — environments, release workflow, signing, App Check, rollback and the first-release checklist: **[`app/docs/08_build_and_deploy.md`](app/docs/08_build_and_deploy.md)**.

```bash
bash app/tool/release_check.sh                                  # gate: analyzer + all test suites (must be green)

# Backend (when rules or Functions changed) — before the apps
cd app/firebase && firebase deploy --only firestore:rules,functions --project dev   # then --project prod

# Web
bash app/tool/deploy_web.sh dev                                 # https://cms4cas-dev.web.app
APPCHECK_WEB_KEY=<site key> bash app/tool/deploy_web.sh prod --preview rc   # check the preview URL, then:
cd app/firebase && firebase hosting:clone cms4cas:rc cms4cas:live --project prod

# Android (needs app/android/key.properties — see key.properties.example)
cd app && flutter build appbundle --release --flavor prod --obfuscate --split-debug-info=build/symbols/android

# iOS (macOS, Xcode team set)
cd app && flutter build ipa --release --flavor prod --obfuscate --split-debug-info=build/symbols/ios
```

Bump `version: x.y.z+build` in `app/pubspec.yaml` before every store upload (the build number must always increase), tag the commit (`v1.2.0+7`), go to dev first, then prod.

## Known gaps

- User-facing strings are English and not yet in ARB files (next step: Vietnamese).
- Android/iOS flavor builds have not been compiled in the build environment, and Cloud Functions have not run in the Functions emulator; the web build, all tests, and the Auth/Firestore emulator checks (create-user, access-request rules, demo seeding) have.
- The app uses the system font; a brand typeface is not bundled yet.
- `package:flutter/material.dart` shows deprecation infos in Flutter 3.50 (`material_ui` migration pending).

## Jurisdiction

Defaults are the book's (Nevada Regulation 6A / Title 31 as of 2003; Nevada and Atlantic City tax examples). Every threshold, the gaming-day cutoff, tax rate and comp policy are editable in **Settings**. Confirm them against your current local regulation before using the compliance module for real reporting.

## Sources and attribution

Formulas, procedures and reference figures: Kilby, J., Fox, J., & Lucas, A. F. (2005). _Casino Operations Management_ (2nd ed.). Wiley. Page references in the app use the book's printed page numbers. The knowledge base contains notes and paraphrase, not reproduced text.
