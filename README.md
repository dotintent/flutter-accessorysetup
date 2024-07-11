# Flutter Accessory Kit

## 🚇 Install

```
flutter pub get TBD
```

## ⚙️ Setup

- You should use xCode 16 and iOS 18 or higher to use that package, don't forget to setup the [cocoapods](./example/ios/Podfile) correctly too.

- You should add the keys to the [Info.plist](./example/ios/Runner/Info.plist) of the iOS app to make it work. <br>
  ⚠️ **If you miss the required key the app will crash when you show the picker** ⚠️
  <br><br>

  - ALWAYS: (Bluetooth or WiFi, or both)

  ```
  <key>NSAccessorySetupKitSupports</key>
  <array>
    <string>Bluetooth</string>
    <string>WiFi</string>
  </array>
  ```

  - when you use the `ASDiscoveryDescriptor` with `bluetoothServiceUUID`<br>
    ⚠️ **The UUID string must be upper-cased here** ⚠️
    <br><br>

  ```
  <key>NSAccessorySetupBluetoothServices</key>
  <array>
    <string>149E9E42-33AD-41AD-8665-70D153533EC1</string>
  </array>
  ```

  - when you use the `ASDiscoveryDescriptor` with `bluetoothNameSubstring`<br>
    ⚠️ **Does not work in the iOS 18 Developer beta 2** ⚠️
    <br><br>

  ```
  <key>NSAccessorySetupBluetoothNames</key>
  <array>
    <string>DeviceName</string>
  </array>
  ```

  - there is an option with manufacturer ID that is not covered here

- Use the FlutterAccessorysetup class. See the full code example in the [Example app](./example/lib/main.dart)

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

---

## ℹ️ What we know

⚠️ The AccessorySetup does not work on the Simulator ⚠️

- When user close the Picker by tapping cross button, the showPicker closure emits an error (ASErrorDomain, code 700)

- ⚠️ **When the person picks an ble accessory the picker sends an event of type **ASAccessoryEventType.accessoryChanged**, it might be that the picker sends an event of type **ASAccessoryEventType.accessoryAdded** but I can't reproduce it at all ⚠️ 

- If the device have been connected previously, it will be in the `session.accessories` array right after the session was activated event.<br>
  ⚠️ **This device will not discoverable by Setup Picker until the User disconnects it from the settings** ⚠️

- When the User selects the device using picker,
  - the device will be displayed in the `MyDevices` section of the `Settings/Bluetooth` screen
  - the device's `info screen` will display image and name you provided to the ``ASPickerDisplayItem`` during the discovery process (the same that user saw in the picker)

- When used deletes the App, the device will be disconnected automatically. It won't be displayed in the `MyDevices` section of the `Settings/Bluetooth` screen anymore.

---


## 📗 References

- <https://developer.apple.com/documentation/accessorysetupkit/discovering-and-configuring-accessories>
- <https://developer.apple.com/documentation/accessorysetupkit/authorizing-a-bluetooth-accessory-to-share-a-dice-roll>
