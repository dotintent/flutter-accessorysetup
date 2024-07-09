import 'package:flutter_accessorysetup/flutter_accessorysetup_event.dart';
import 'package:flutter_accessorysetup/flutter_accessorysetup_platform.dart';

class FlutterAccessorysetup {
  FlutterAccessorysetupPlatform get _platform => FlutterAccessorysetupPlatform.instance;

  Stream<FlutterAccessorysetupSessionEvent> get sessionStream => _platform.sessionStream;

  Future<String?> getPlatformVersion() {
    return _platform.getPlatformVersion();
  }

  Future<void> activate() async {
    await _platform.activate();
  }

  Future<void> showBlePicker(String name, String asset, String? serviceUUID, String? nameSubstring) async {
    await _platform.showBlePicker(name, asset, serviceUUID, nameSubstring);
  }
}
