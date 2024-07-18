# tmed_client

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

dart fix --apply --code=await_only_futures
dart fix --apply --code=prefer_const_constructors
dart fix --apply --code=unnecessary_brace_in_string_interps
dart fix --apply --code=unnecessary_import
dart fix --apply --code=unnecessary_non_null_assertion
dart fix --apply --code=unnecessary_this
dart fix --apply --code=unused_import
dart fix --apply --code=use_super_parameters

run with null safety:
flutter run --no-sound-null-safety

build apk with low size:
flutter build apk --split-per-abi

build appbundle:
flutter build appbundle --release --build-name=1.0.7 --build-number=9

build runner:
flutter pub run build_runner build --delete-conflicting-outputs

rename app:
rename setAppName --targets ios,android --value "T-MED"
rename setBundleId --targets ios,android --value "com.dwed.dwed"

generation eyse:
flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart --source-dir ./lib/assets/strings/

Flutter Localization Gen

flutter gen-l10n
