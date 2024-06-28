
import 'flutter_accessorysetup_platform_interface.dart';

class FlutterAccessorysetup {
  Future<String?> getPlatformVersion() {
    return FlutterAccessorysetupPlatform.instance.getPlatformVersion();
  }
}
