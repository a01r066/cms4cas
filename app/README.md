# CMS app (Flutter)

The Flutter client for **CMS — Casino Management**. Setup, Firebase, flavors, build and deploy instructions are in the [repository README](../README.md); architecture in [docs/03_architecture.md](../docs/03_architecture.md).

```bash
flutter pub get
flutter run -d chrome                  # dev flavor, local backend
flutter run --flavor dev               # Android / iOS
dart run build_runner build -d         # after changing freezed / json models
flutter test                           # 21 tests
```

Layout: `lib/features/<feature>/{data,domain,presentation}` — datasource → repository (`Either`) → `StateNotifier`; freezed models and entities; privileged writes through `FunctionsGateway`.
