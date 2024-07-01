import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_accessorysetup/flutter_accessorysetup_platform_interface.dart';

/// An implementation of [FlutterAccessorysetupPlatform] that uses method channels.
class MethodChannelFlutterAccessorysetup extends FlutterAccessorysetupPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.withintent.flutter.package.flutter_accessorysetup.methods');

  /// The event channel used to listen for events from the native platform.
  @visibleForTesting
  final eventChannel = const EventChannel('com.withintent.flutter.package.flutter_accessorysetup.events');

  @override
  Stream<dynamic> get sessionStream => eventChannel.receiveBroadcastStream();

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> activate() async {
    await methodChannel.invokeMethod<int>('activate');
  }

  @override
  Future<void> showPicker() async {
    await methodChannel.invokeMethod<int>('showPicker');
  }
}
