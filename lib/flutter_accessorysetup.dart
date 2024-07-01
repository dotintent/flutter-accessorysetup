
import 'package:flutter_accessorysetup/flutter_accessorysetup_platform_interface.dart';

class FlutterAccessorysetup {
  final platform = FlutterAccessorysetupPlatform.instance;

  Stream<dynamic> get sessionStream => platform.sessionStream;

  Future<String?> getPlatformVersion() {
    return platform.getPlatformVersion();
  }

  Future<void> activate() async {
    await platform.activate();
  }

  Future<void> showPicker() async {
    await platform.showPicker();
  }
}
