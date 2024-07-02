import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_accessorysetup/flutter_accessorysetup.dart';
import 'package:flutter_accessorysetup/flutter_accessorysetup_platform.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAccessorysetupPlatform
    with MockPlatformInterfaceMixin
    implements FlutterAccessorysetupPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterAccessorysetupPlatform initialPlatform = FlutterAccessorysetupPlatform.instance;

  test('$FlutterAccessorysetupPlatform is the default instance', () {
    expect(initialPlatform, isInstanceOf<FlutterAccessorysetupPlatform>());
  });

  test('getPlatformVersion', () async {
    final flutterAccessorysetupPlugin = FlutterAccessorysetup();
    final fakePlatform = MockFlutterAccessorysetupPlatform();
    FlutterAccessorysetupPlatform.instance = fakePlatform;

    expect(await flutterAccessorysetupPlugin.getPlatformVersion(), '42');
  });
}
