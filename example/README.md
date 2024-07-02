# Example App

## Requirements

- `fvm` (https://fvm.app/documentation/getting-started/installation)
- `brew` (https://brew.sh/)
- `cocoapods` (https://formulae.brew.sh/formula/cocoapods)
- `Flutter` v3.22.2
- `Android Studio` or `VSCode`

## Getting Started

According we're developing both for iOS and Android, a macOS based device is needed.
Those are the steps needed to build the app and contribute to the repo:

1. run `brew install cocoapods`
2. run `brew tap leoafarias/fvm`
3. run `brew install fvm`
4. run `fvm install` in the project folder
6. run `flutter pub get` to get all the dependencies
11. run `flutter run` to start the application

If the iOS build fails for `Cocoapods` reason, please run this command:

1. `cd iOS`
2. `pod repo update`
3. `pod install`

## Code Generators

The repo makes use of code generators to secure access to local assets and manipulate visual features across different platforms.

### Assets

After updating any Assets run:
`flutter pub run build_runner build --delete-conflicting-outputs`

If you're adding new directory, make sure to add its path to `pubspec.yaml` (in `assets:`).
