
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
- run the app, by default it will use `cocoapods` to build the pub
- check that library's binary contains functions from `AccessorySetupBindings.m`
dart code will call that functions as native ones,
 and will be sad if there is nothing to call.
```
cd example/build/ios/Debug-iphonesimulator/flutter_accessorysetup/flutter_accessorysetup.framework
nm flutter_accessorysetup
```
- check that swift package builds correctly
    - open `Package.swift` with Xcode and uncomment  `// type: .dynamic,`
    - build it with Xcode
    - find the dynamic lib binary inside the folder:
    `.../DerivedData/flutter_accessorysetup-cxdfwrtgxkutoqhlafpyoelbredk/Build/Products/Debug-iphoneos/PackageFrameworks/flutter-accessorysetup.framework`
    - check that library's binary contains functions from `AccessorySetupBindings.m` 
    - comment `// type: .dynamic,` back
