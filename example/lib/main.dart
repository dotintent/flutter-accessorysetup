import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_accessorysetup/flutter_accessorysetup.dart';
import 'package:flutter_accessorysetup_example/gen/assets.gen.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _deviceStatus = 'Disconnected';
  String _events = "";
  StreamSubscription<BluetoothAdapterState>? bleStateSubscription;


  @override
  void initState() {
    super.initState();
    // initPlatformState();
    FlutterAccessorysetupFFI().activate();
  }

  @override
  void deactivate() {
    bleStateSubscription?.cancel();
    super.deactivate();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // String platformVersion;
    // // Platform messages may fail, so we use a try/catch PlatformException.
    // // We also handle the message potentially returning null.
    // try {
    //   platformVersion =
    //       await _flutterAccessorysetupPlugin.getPlatformVersion() ??
    //           'Unknown platform version';
    // } on PlatformException {
    //   platformVersion = 'Failed to get a platform version';
    // }

    // try {
    //   await _flutterAccessorysetupPlugin.activate();
    // } on PlatformException {
    //   debugPrint('Failed to activate the session');
    // }

    // try {
    //   await _flutterAccessorysetupPlugin.showBlePicker(
    //       'My Ble', Assets.images.ble.path, '55AD5FE1-E877-486B-9CD9-A29C8584308D', null);
    // } on PlatformException {
    //   debugPrint('Failed to show the picker');
    // }

    // // If the widget was removed from the tree while the asynchronous platform
    // // message was in flight, we want to discard the reply rather than calling
    // // setState to update our non-existent appearance.
    // if (!mounted) return;

    // setState(() {
    //   _platformVersion = platformVersion;
    // });

    // _flutterAccessorysetupPlugin.sessionStream.listen((event) => setState(() {
    //       final eventDesc = event.toString();
    //       debugPrint('got session event: $eventDesc');
    //       _events = _events.isEmpty ? eventDesc : '$_events,\n$eventDesc';
    //       if (event is FlutterAccessorysetupEvent) {
    //         if (event.type == AccessoryEventType.accessoryChanged ||
    //             event.type == AccessoryEventType.accessoryAdded) {
    //           debugPrint('accessory added/changed: ${event.accessories})');
    //           setState(() {
    //             _pickedAccessory = event.accessories.firstOrNull;
    //           });
    //         }

    //         if (event.type == AccessoryEventType.pickerDidDismiss) {
    //           debugPrint('user picked accessory: $_pickedAccessory)');
    //           final accessory = _pickedAccessory;
    //           setState(() {
    //             _pickedAccessory = null;
    //           });
    //           final id = accessory?.bluetoothIdentifier;
    //           if (accessory != null &&
    //               id != null &&
    //               accessory.state == AccessoryState.authorized) {
    //             _connectWithoutScanning(id);
    //           } else {
    //             throw Exception(
    //                 'added accessory should have identifier and be authorized');
    //           }
    //         }
    //       }
    //     }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Accessory Setup app'),
        ),
        body: Center(
            child: Column(
          children: [
            Text('Running on: $_platformVersion\n'),
            const SizedBox(
              height: 15,
            ),
            Text('Device status: $_deviceStatus'),
            const SizedBox(
              height: 15,
            ),
            Text('Setup Session events: \n$_events'),
          ],
        )),
      ),
    );
  }

  // Connect device section

  Future<void> _connectWithoutScanning(String id) async {
    debugPrint('_connectWithoutScanning: $id');
    if (await FlutterBluePlus.isSupported == false) {
      debugPrint('Bluetooth is not supported by this device');
      return;
    }
    if (FlutterBluePlus.adapterStateNow == BluetoothAdapterState.on) {
      _connectDevice(id);
      return;
    }
    bleStateSubscription =
        FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      debugPrint('got adapter state: $state');
      if (state == BluetoothAdapterState.on) {
        _connectDevice(id);
        bleStateSubscription?.cancel();
      }
    });
  }

  Future<void> _connectDevice(String id) async {
    var device = BluetoothDevice.fromId(id);
    debugPrint('loaded device: $device');
    try {
      await device.connect();
      setState(() {
        _deviceStatus = 'Connected';
      });
      debugPrint('connected to device $device');
    } catch (e) {
      debugPrint('failed to connect: $e');
    }
  }
}
