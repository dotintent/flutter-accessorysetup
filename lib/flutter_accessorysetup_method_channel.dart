import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_accessorysetup_platform_interface.dart';

/// An implementation of [FlutterAccessorysetupPlatform] that uses method channels.
class MethodChannelFlutterAccessorysetup extends FlutterAccessorysetupPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_accessorysetup');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
