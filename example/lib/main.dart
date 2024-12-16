import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_accessorysetup/flutter_accessorysetup.dart';
import 'package:flutter_accessorysetup/gen/ios/accessory_setup_bindings.dart';
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
  String _deviceStatus = 'Disconnected';
  String _events = "";
  ASAccessory? _pickedAccessory;
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
  StreamSubscription<ASAccessoryEvent>? _eventsSubscription;
  final accessorySetup = FlutterAccessorysetupFFI();

  @override
  void initState() {
    super.initState();
    _activateAccessorySession();
  }

  @override
  void deactivate() {
    _adapterStateSubscription?.cancel();
    _eventsSubscription?.cancel();
    accessorySetup.dispose();
    super.deactivate();
  }

  Future<void> _activateAccessorySession() async {
    accessorySetup.eventStream.listen((event) {
      debugPrint('Got event: ${event.eventType}');
      setState(() {
        _events += '\n\r${event.dartDescription};\n\r';
      });
      if (event.eventType ==
          ASAccessoryEventType.ASAccessoryEventTypeActivated) {
        connect();
      } else if (event.eventType ==
              ASAccessoryEventType.ASAccessoryEventTypeAccessoryAdded ||
          event.eventType ==
              ASAccessoryEventType.ASAccessoryEventTypeAccessoryChanged) {
        setState(() {
          _pickedAccessory = event.accessory;
        });
      } else if (event.eventType ==
          ASAccessoryEventType.ASAccessoryEventTypePickerDidDismiss) {
        debugPrint('user picked accessory: $_pickedAccessory)');
        final accessory = _pickedAccessory;
        setState(() {
          _pickedAccessory = null;
        });
        final id = accessory?.dartBluetoothIdentifier;
        if (accessory != null &&
            id != null &&
            accessory.state == ASAccessoryState.ASAccessoryStateAuthorized) {
          _connectWithoutScanning(id);
        } else {
          throw Exception(
              'added accessory should have identifier and be authorized');
        }
      }
    });
    accessorySetup.activate();
  }

  Future<void> connect() async {
    final firstAccessoryId =
        accessorySetup.accessories.firstOrNull?.dartBluetoothIdentifier;
    if (firstAccessoryId != null) {
      debugPrint('Got an accessory, will try to connect: $firstAccessoryId');
      await _connectWithoutScanning(firstAccessoryId);
      return;
    }

    try {
      // to make it work you need to set up info plist keys
      // NSAccessorySetupBluetoothServices -> UUID
      // and NSAccessorySetupKitSupports -> Bluetooth
      accessorySetup.showPickerForDevice('My Ble', Assets.images.ble.path,
          '55AD5FE1-E877-486B-9CD9-A29C8584308D');
    } catch (e) {
      if (e is NativeCodeError) {
        debugPrint('Got native code error: $e');
      } else {
        debugPrint('Got error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Accessory Setup App'),
        ),
        body: Center(
            child: Column(
          children: [
            Text('Device Status: $_deviceStatus'),
            const SizedBox(
              height: 15,
            ),
            Text('Setup Session Events: \n$_events'),
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
    _adapterStateSubscription =
        FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      debugPrint('got adapter state: $state');
      if (state == BluetoothAdapterState.on) {
        _connectDevice(id);
        _adapterStateSubscription?.cancel();
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
