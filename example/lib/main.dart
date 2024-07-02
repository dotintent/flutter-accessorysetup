import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_accessorysetup/flutter_accessorysetup.dart';
import 'package:flutter_accessorysetup_example/gen/assets.gen.dart';

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
  String _events = "";
  final _flutterAccessorysetupPlugin = FlutterAccessorysetup();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _flutterAccessorysetupPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get a platform version';
    }

    try {
      await _flutterAccessorysetupPlugin.activate();
    } on PlatformException {
      debugPrint('Failed to activate the session');
    }

    try {
      await _flutterAccessorysetupPlugin.showBlePicker(
        'My Device',
         Assets.images.ble.path,
        '149E9E42-33AD-41AD-8665-70D153533EC1',
        null
      );
    } on PlatformException {
      debugPrint('Failed to show the picker');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    _flutterAccessorysetupPlugin.sessionStream.listen((event) => setState(() {
      if (event is String) {
        _events = _events.isEmpty ? event : '$_events,\n$event';
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Accessory Setup app'),
        ),
        body: Center(
          child: Column(children: [
            Text('Running on: $_platformVersion\n'),
            const SizedBox(height: 15,),
            Text('Setup Session events: \n$_events'),
          ],)
          
        ),
      ),
    );
  }
}
