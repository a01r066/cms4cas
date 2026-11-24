# CMS — Casino Management

A Flutter app (web, Android, iOS) built from **Kilby, Fox & Lucas — _Casino Operations Management_, 2nd ed. (Wiley, 2005)**. It turns the book's formulas, procedures and controls into working tools for the pit, cage, credit, compliance, marketing and management, with every calculation tied back to the page it comes from.

**v1 modules:** player rating & comps · table games accounting & hold · credit & markers · currency compliance (MTL, aggregation, CTR, barred list, SAR) · promotion & deal evaluator · staffing & table-opening economics · knowledge library · settings, users & roles.

## Repository

```
app/                      Flutter app (Riverpod 3, go_router, dartz, Firebase optional)
packages/casino_engine/   Pure-Dart calculation engine with book citations and 65 golden tests
firebase/                 Firestore rules, setUserRole Cloud Function, hosting config
kb/                       Knowledge base: chapter notes, 168-term glossary, reference tables,
                          independent Python implementation of 45 book examples
docs/                     PRD, journeys, architecture, data model, UI/UX, testing report, user guide, screenshots
```

| Doc | |
|---|---|
| [01 PRD](docs/01_PRD.md) | Vision, roles, scope, book vs. app additions |
| [02 User journeys](docs/02_user_journeys.md) | Mermaid flows for each role |
| [03 Architecture](docs/03_architecture.md) | Layers, persistence modes, roles & permissions, security |
| [04 Data model](docs/04_data_model.md) | Collections and fields |
| [05 UI/UX](docs/05_ui_ux.md) | Principles, layout, screens |
| [06 Testing report](docs/06_testing_report.md) | Results, book cross-checks, errata, limitations |
| [07 User guide](docs/07_user_guide.md) | How to use each module |

## Requirements

- Flutter **3.50+** (Dart 3.14) — `flutter --version`
- For cloud mode: a Firebase project, Firebase CLI (`npm i -g firebase-tools`), FlutterFire CLI (`dart pub global activate flutterfire_cli`), Node 20 for Functions

## Run locally (no backend)

```bash
cd app
flutter pub get
flutter run -d chrome          # or an Android/iOS device or emulator
```

Data is stored on the device (browser localStorage on web). On first launch create the administrator. **Local mode has no passwords** — use it for evaluation and training only.

## Tests

```bash
cd packages/casino_engine && dart pub get && dart test    # 65 engine tests
cd ../../app && flutter test                               # 11 app tests
python3 ../kb/book_formulas.py                             # 45 book examples (independent check)
```

## Cloud mode (Firebase)

1. Create a Firebase project; enable **Authentication → Email/Password** and **Firestore**.
2. Configure the app:
   ```bash
   cd app
   flutterfire configure            # overwrites lib/firebase_options.dart
   ```
3. Deploy rules and the role function:
   ```bash
   cd ../firebase/functions && npm install && cd ..
   firebase use <project-id>
   firebase deploy --only firestore:rules,functions
   ```
4. Create the first user in **Firebase Console → Authentication** (or sign-up flow of your choice).
5. Run against Firebase:
   ```bash
   cd ../app
   flutter run -d chrome --dart-define=USE_FIREBASE=true --dart-define=CASINO_ID=main
   ```
   Sign in, then choose **Set up as first administrator**. The `setUserRole` function allows this only while the casino has no users.
6. Add other users: create their accounts in Authentication, then **Settings → Users & roles** with their email.

Each property uses its own `CASINO_ID`; data lives under `casinos/{CASINO_ID}/…`.

Before going live, test the rules with the emulator: `firebase emulators:start --only firestore,functions`.

## Build and deploy

```bash
# Web (served by Firebase Hosting from app/build/web)
cd app && flutter build web --release --dart-define=USE_FIREBASE=true --dart-define=CASINO_ID=main
cd ../firebase && firebase deploy --only hosting

# Android
cd app && flutter build appbundle --release --dart-define=USE_FIREBASE=true --dart-define=CASINO_ID=main

# iOS (on macOS with Xcode)
cd app && flutter build ipa --release --dart-define=USE_FIREBASE=true --dart-define=CASINO_ID=main
```

Set your own application id / bundle id (`com.cmskiss.cms_kiss` by default) and signing before store release. For offline/air-gapped web deployments add `--no-web-resources-cdn` and bundle fonts.

## Jurisdiction

Defaults are the book's (Nevada Regulation 6A / Title 31 as of 2003; Nevada and Atlantic City tax examples). Every threshold, the gaming-day cutoff, tax rate and comp policy are editable in **Settings**. Confirm them against your current local regulation before using the compliance module for real reporting.

## Sources and attribution

Formulas, procedures and reference figures: Kilby, J., Fox, J., & Lucas, A. F. (2005). _Casino Operations Management_ (2nd ed.). Wiley. Page references in the app use the book's printed page numbers. The knowledge base contains notes and paraphrase, not reproduced text.
