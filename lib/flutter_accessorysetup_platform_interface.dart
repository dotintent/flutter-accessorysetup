import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_accessorysetup_method_channel.dart';

abstract class FlutterAccessorysetupPlatform extends PlatformInterface {
  /// Constructs a FlutterAccessorysetupPlatform.
  FlutterAccessorysetupPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAccessorysetupPlatform _instance = MethodChannelFlutterAccessorysetup();

  /// The default instance of [FlutterAccessorysetupPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAccessorysetup].
  static FlutterAccessorysetupPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAccessorysetupPlatform] when
  /// they register themselves.
  static set instance(FlutterAccessorysetupPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
