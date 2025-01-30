import 'dart:ffi';

import 'package:flutter_accessorysetup/flutter_accessorysetup.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_accessorysetup/src/testing.dart';

import 'mocks/ffi_accessory_session_mock.dart';
// import 'mocks/objc_ns_array_mock.dart';
import 'mocks/delegate_adapter_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FFIAccessorySessionMock sessionMock;
  late FFIAccessorySessionAdapter sessionAdapter;
  late FlutterAccessorySetup sut;

  setUp(() {
    sessionMock = FFIAccessorySessionMock();
    sessionAdapter = FFIAccessorySessionAdapter(sessionMock);
    sut = FlutterAccessorySetup(sessionAdapter: sessionAdapter);
  });

  tearDown(() {
    sut.dispose();
  });

  // Tests

  test('sut calls activate and sets up delegate adapter when the `activate` method called',
      () async {
    // Given
    sut = FlutterAccessorySetup(
        sessionAdapter: sessionAdapter,
        delegateAdapterFactory: DelegateAdapterMock.new);
    // When
    sut.activate();
    // Then
    expect(sessionAdapter.delegateAdapter, isNotNull);
    expect(
        sessionMock.calls,
        equals([
          SessionMockMethodCall.setDelegate,
          SessionMockMethodCall.activate
        ]));
  });
}
