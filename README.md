# Flutter Accessory Kit

## 📗 Apple Docs

- <https://developer.apple.com/documentation/accessorysetupkit/discovering-and-configuring-accessories>
- <https://developer.apple.com/documentation/accessorysetupkit/authorizing-a-bluetooth-accessory-to-share-a-dice-roll>

## ⚙️ Installation

‼ **you should use xCode 16 and iOS 18 to use that package, don't forget to setup the [cocoapods](./example/ios/Podfile) correctly too** ‼

### You should add the keys to the [Info.plist](./example/ios/Runner/Info.plist) of the iOS app to make it work 
 * ALWAYS: (Bluetooth or WiFi, or both)
 ```
 <key>NSAccessorySetupKitSupports</key>
 <array>
	<string>Bluetooth</string>
	<string>WiFi</string>
 </array>
 ```
 * when you use the ``ASDiscoveryDescriptor`` with ``bluetoothServiceUUID``
 ```
 <key>NSAccessorySetupBluetoothServices</key>
 <array>
 	<string>149E9E42-33AD-41AD-8665-70D153533EC1</string>
 </array>
 ```
* when you use the ``ASDiscoveryDescriptor`` with ``bluetoothNameSubstring``
 ‼ **Does not work in the iOS 18 Developer beta 2** ‼ 
 ```
 <key>NSAccessorySetupBluetoothNames</key>
 <array>
 	<string>DeviceName</string>
 </array>
 ```
* there is an option with manufacturer ID that is not covered here

‼ **If you miss the required key the app will crash when you show the picker** ‼

### Use the FlutterAccessorysetup class

See the full code example in the [Example app](./example/lib/main.dart) 

```
    final _flutterAccessorysetupPlugin = FlutterAccessorysetup();

    _flutterAccessorysetupPlugin.sessionStream.listen((event) => setState(() {
        // handle session events here
        // async errors will be delivered as session events too
    }

    try {
      await _flutterAccessorysetupPlugin.activate();
      await _flutterAccessorysetupPlugin.showPicker();
    } on PlatformException {
      debugPrint('Failed to show the picker');
    }
```

----
## 🧑‍🦯 Know how

‼ The AccessorySetup does not work on the Simulator ‼ 

* When user close the Picker by tapping cross button, the showPicker closure emits an error (ASErrorDomain, code 700)

* If the device have been connected previously, it will be in the ``session.accessories`` array right after the session was activated event. 
‼ **This device will not discoverable by Setup Picker until the User disconnects it from the settings** ‼

* When the User selects the device using picker, 
  *  the device will be displayed in the MyDevices section of the `Settings/Bluetooth` screen
  * the device info will screen will display image and name you provided to the descriptor during the discovery process (the same that user see in the picker)

----

## ✅ TODO

next steps:

- [v] update the documentation to note all required steps and limitations of the AccessorySetupKit

- [ ] introduce customization for the device discovery:
* name
* image
* custom services UUID

- [ ] find a way to work with the Flutter ble package (setup kit gives the Peripheral ID which the app ble should work with)
* investigate what is the Ble package we use in Flutter in the company
* implement handling the discovered Ble device using that package.

- [ ] introduce unit tests

- [ ] implement wifi setup

- [ ] check the migration sequence and implementation in Flutter (for example app)