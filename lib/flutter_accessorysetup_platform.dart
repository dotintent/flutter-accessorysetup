import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class FlutterAccessorysetupPlatform extends PlatformInterface {
  /// Constructs a FlutterAccessorysetupPlatform.
  FlutterAccessorysetupPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAccessorysetupPlatform _instance =
      FlutterAccessorysetupPlatform();
  static FlutterAccessorysetupPlatform get instance => _instance;

  @visibleForTesting
  static set instance(FlutterAccessorysetupPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // Concrete implementation goes here

  @visibleForTesting
  final methodChannel = const MethodChannel(
      'com.withintent.flutter.package.flutter_accessorysetup.methods');

  /// The event channel used to listen for events from the native platform.
  @visibleForTesting
  final eventChannel = const EventChannel(
      'com.withintent.flutter.package.flutter_accessorysetup.events');

  Stream<dynamic> get sessionStream => eventChannel.receiveBroadcastStream();

  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  Future<void> activate() async {
    await methodChannel.invokeMethod<int>('activate');
  }

  Future<void> showBlePicker(String name, String asset, String? serviceUUID,
      String? nameSubstring) async {
    await methodChannel.invokeMethod<int>(
      'showBlePicker',
      {
        'name': name, 
        'asset': asset,
        'serviceUUID': serviceUUID,
        'nameSubstring': nameSubstring
      },
    );
  }
}
