import 'package:flutter/src/services/platform_channel.dart';
import 'package:flutter_accessorysetup/flutter_accessorysetup_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_accessorysetup/flutter_accessorysetup.dart';
import 'package:flutter_accessorysetup/flutter_accessorysetup_platform.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class ShowBlePickerParams {
  String name;
  String asset;
  String? serviceUUID;
  String? nameSubstring;

  ShowBlePickerParams({
    required this.name,
    required this.asset,
    this.serviceUUID,
    this.nameSubstring,
  });
}

class MockFlutterAccessorysetupPlatform
    with MockPlatformInterfaceMixin
    implements FlutterAccessorysetupPlatform {
  List<bool> activeCalls = [];
  List<ShowBlePickerParams> showBlePickerCalls = [];

  @override
  Stream<FlutterAccessorysetupSessionEvent> get sessionStream =>
      const Stream<FlutterAccessorysetupSessionEvent>.empty();

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> activate() async {
    activeCalls.add(true);
  }

  @override
  Future<void> showBlePicker(
    String name,
    String asset,
    String? serviceUUID,
    String? nameSubstring,
  ) async {
    showBlePickerCalls.add(ShowBlePickerParams(
      name: name,
      asset: asset,
      serviceUUID: serviceUUID,
      nameSubstring: nameSubstring,
    ));
  }

  @override
  EventChannel get eventChannel => throw UnimplementedError();

  @override
  MethodChannel get methodChannel => throw UnimplementedError();
}

void main() {
  test('$FlutterAccessorysetupPlatform is the default instance', () {
    expect(FlutterAccessorysetupPlatform.instance, isInstanceOf<FlutterAccessorysetupPlatform>());
  });

  test('getPlatformVersion', () async {
    final flutterAccessorysetupPlugin = FlutterAccessorysetup();
    final fakePlatform = MockFlutterAccessorysetupPlatform();
    FlutterAccessorysetupPlatform.instance = fakePlatform;

    expect(await flutterAccessorysetupPlugin.getPlatformVersion(), '42');
  });

   test('activate', () async {
    final flutterAccessorysetupPlugin = FlutterAccessorysetup();
    final fakePlatform = MockFlutterAccessorysetupPlatform();
    FlutterAccessorysetupPlatform.instance = fakePlatform;

    await flutterAccessorysetupPlugin.activate();

    expect(fakePlatform.activeCalls.length, 1);
  });

   test('showBlePicker', () async {
    final flutterAccessorysetupPlugin = FlutterAccessorysetup();
    final fakePlatform = MockFlutterAccessorysetupPlatform();
    FlutterAccessorysetupPlatform.instance = fakePlatform;

    await flutterAccessorysetupPlugin.showBlePicker('name', 'asset', 'serviceUUID', 'nameSubstring');

    expect(fakePlatform.showBlePickerCalls.length, 1);
    expect(fakePlatform.showBlePickerCalls.firstOrNull?.name, 'name');
    expect(fakePlatform.showBlePickerCalls.firstOrNull?.asset, 'asset');
    expect(fakePlatform.showBlePickerCalls.firstOrNull?.serviceUUID, 'serviceUUID');
    expect(fakePlatform.showBlePickerCalls.firstOrNull?.nameSubstring, 'nameSubstring');
  });
}
