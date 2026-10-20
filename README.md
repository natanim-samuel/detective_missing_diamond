# Detective: The Missing Diamond

A Flutter mystery game with suspect interviews, evidence collection, investigation locations, deductions, multiple cases, and locally saved progress.

## Run it

1. Install Flutter and Android Studio.
2. Open a terminal in this folder.
3. Run:

```bash
flutter pub get
flutter run
```

If you already created a Flutter project, copy `lib/main.dart` into its `lib/main.dart`, replace the project's `pubspec.yaml` with this one (or add `shared_preferences: ^2.5.3` under dependencies), then run `flutter pub get`.

Progress is stored locally using `shared_preferences`. The reset icon in the top-right corner clears game progress.
