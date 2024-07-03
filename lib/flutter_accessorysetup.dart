import 'package:flutter_accessorysetup/flutter_accessorysetup_event.dart';
import 'package:flutter_accessorysetup/flutter_accessorysetup_platform.dart';

class FlutterAccessorysetup {
  final platform = FlutterAccessorysetupPlatform.instance;

  Stream<FlutterAccessorysetupSessionEvent> get sessionStream => platform.sessionStream;

  Future<String?> getPlatformVersion() {
    return platform.getPlatformVersion();
  }

  Future<void> activate() async {
    await platform.activate();
  }

  Future<void> showBlePicker(String name, String asset, String? serviceUUID, String? nameSubstring) async {
    await platform.showBlePicker(name, asset, serviceUUID, nameSubstring);
  }
}
