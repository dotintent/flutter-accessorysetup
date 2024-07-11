# AccessorySetup Demo App

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

## How to use

In order to have it working you need a Google with BLE support broadcasting the service `FEF3` for Fast Pair, but you can adjust to any value your BLE device is providing.