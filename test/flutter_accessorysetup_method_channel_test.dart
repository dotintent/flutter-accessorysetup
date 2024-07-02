import 'package:flutter/services.dart';
import 'package:flutter_accessorysetup/flutter_accessorysetup_platform.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final FlutterAccessorysetupPlatform platform = FlutterAccessorysetupPlatform();
  const MethodChannel channel = MethodChannel('com.withintent.flutter.package.flutter_accessorysetup.methods');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
