
# Flutter Accessory Kit

# How to update

- update the `FlutterAccessorySetup.swift` file
- update the `AccessorySetupBindings.h` if required
- run the generator for ffi
```
fvm flutter pub run ffigen --config ffigen.yaml
```
- check the outputs of generator
- update `flutter_accessorysetup.dart` if required
- run the app
- check that library's binary contains functions from `AccessorySetupBindings.m`
dart code will call that functions as native ones,
 and will be sad if there is nothing to call.
```
cd example/build/ios/Debug-iphonesimulator/flutter_accessorysetup/flutter_accessorysetup.framework
nm flutter_accessorysetup
```
