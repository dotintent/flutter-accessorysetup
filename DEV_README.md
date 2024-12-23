
# Flutter Accessory Kit

## How to verify changes

### Cocoapods integration

- update the `FlutterAccessorySetup.swift` file
- update the `AccessorySetupBindings.h` if required
- run the generator for FFI:
```
fvm flutter pub run ffigen --config ffigen.yaml
```
- check the outputs of generator
- update `flutter_accessorysetup.dart` if required
- set lowest supported flutter version, for now it is `3.24.5`
```
fvm install 3.24.5
fvm use 3.24.5
```
- run the app. By default it will use `cocoapods` to build the pub
```
cd example
fvm flutter devices 
fvm flutter -d DEVICE_ID_FROM_DEVICES_OUTPUT
cd -
```
- check that library's binary contains functions from `AccessorySetupBindings.m`
Dart code will call that functions as native ones,
 and will fail if there is nothing to call.
```
cd example/build/ios/Debug-iphonesimulator/flutter_accessorysetup/flutter_accessorysetup.framework
nm flutter_accessorysetup
```
- verify that app works as expected

### Swift Package integration

- verify that swift package builds correctly:
    - open `Package.swift` with Xcode and uncomment  `// type: .dynamic,`
    - build it with Xcode
    - find the dynamic lib binary inside the folder:
    `.../DerivedData/flutter_accessorysetup-cxdfwrtgxkutoqhlafpyoelbredk/Build/Products/Debug-iphoneos/PackageFrameworks/flutter-accessorysetup.framework`
    - check that library's binary contains functions from `AccessorySetupBindings.m` 
    - comment `// type: .dynamic,` back

- ensure that plugin works with the swift package integration:
    - use the latest master:
    ```
    fvm install master
    fvm use master
    ```
    - run the app with package integration:
    ```
    cd example
    fvm flutter config --enable-swift-package-manager
    fvm flutter devices 
    fvm flutter -d DEVICE_ID_FROM_DEVICES_OUTPUT
    cd -
    ```
    - check that `Package.swift` of the example project contains the plugin package:
    ```
    cat ./example/ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage/Package.swift
    ```
    the dependencies section should contains something similar to: 
    ```
     dependencies: [
        .package(name: "flutter_accessorysetup", path: ".../flutter-accessorysetup/ios/flutter_accessorysetup"),
        .package(name: "integration_test", path: .../ios/integration_test")
    ],
    ```
    - verify that app works as expected
    - revert the flutter version
    ```
    fvm use 3.24.5
    fvm flutter -d DEVICE_ID_FROM_DEVICES_OUTPUT
    cd -
    ```
