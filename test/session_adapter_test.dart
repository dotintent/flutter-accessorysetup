import 'dart:ffi';

import 'package:flutter_accessorysetup/flutter_accessorysetup.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_accessorysetup/src/testing.dart';
import 'package:flutter_accessorysetup/gen/ios/accessory_setup_bindings.dart';
import 'package:objective_c/objective_c.dart';

import 'mocks/ffi_accessory_mock.dart';
import 'mocks/ffi_accessory_settings_mock.dart';
import 'mocks/ffi_accessory_session_mock.dart';
import 'mocks/delegate_adapter_mock.dart';
import 'mocks/objc_ns_array_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FFIAccessorySessionMock sessionMock;
  late FFIAccessorySessionAdapter sut;

  setUp(() {
    sessionMock = FFIAccessorySessionMock();
    sut = FFIAccessorySessionAdapter(sessionMock);
  });

  tearDown(() {
  });

  test('session adapter sets up delegate when the `setDelegateAdapter` method called',
      () async {
    // Given
    final delegateAdapter = mockDelegateAdapter();
    // When
    sut.setDelegateAdapter(delegateAdapter);
    // Then
    expect(delegateAdapter, equals(sut.delegateAdapter));
    expect(delegateAdapter.isFFISessionDelegateCreated, equals(true));
    expect(sessionMock.calls.firstOrNull, equals(SessionMockMethodCall.setDelegate));
  });

  test('session adapter gets accessories when the ` get accessories` method called',
      () async {
    // Given
    // When
    sut.accessories;
    // Then
    expect(sessionMock.calls.firstOrNull, equals(SessionMockMethodCall.getAccessories));
  });

  test('session adapter gets accessories from the session when the `get accessories` method called',
      () async {
    // Given
    // When
    sut.accessories;
    // Then
    expect(sessionMock.calls.firstOrNull, equals(SessionMockMethodCall.getAccessories));
  });

  test('session adapter activates the session when the `activate` method called',
      () async {
    // Given
    // When
    sut.activate();
    // Then
    expect(sessionMock.calls.firstOrNull, equals(SessionMockMethodCall.activate));
  });

  test('session adapter invalidates the session  when the `invalidate` method called',
      () async {
    // Given
    // When
    sut.invalidate();
    // Then
    expect(sessionMock.calls.firstOrNull, equals(SessionMockMethodCall.invalidate));
  });

  test('session adapter nullifies the DelegateAdapter when the `invalidate` method called',
      () async {
    // Given
    sut.setDelegateAdapter(mockDelegateAdapter());
    // When
    sut.invalidate();
    // Then
    expect(sut.delegateAdapter, isNull);
  });

  test('session adapter gets accessories the session when the ` get accessories` method called',
      () async {
    // Given
    // When
    sut.accessories;
    // Then
    expect(sessionMock.calls.firstOrNull, equals(SessionMockMethodCall.getAccessories));
  });

  test('session adapter shows picker using the session when the `showPicker` method called',
      () async {
    // Given
    // When
    sut.showPicker();
    // Then
    expect(sessionMock.calls.firstOrNull, equals(SessionMockMethodCall.showPicker));
  });

  test('session adapter shows picker with items using the session when the `showPickerForItems_` method called',
      () async {
    // Given
    final items = NSArrayMock();
    // When
    sut.showPickerForItems_(items);
    // Then
    expect(sessionMock.calls.firstOrNull, equals(SessionMockMethodCall.showPickerForItems));
    expect(sessionMock.showPickerForItemsValue, equals(items));
  });

  test('session adapter renames accessories using session when the `renameAccessory_options_` method called',
      () async {
    // Given
    final accessory = FFIASAccessoryMock();
    final options = ASAccessoryRenameOptions.ASAccessoryRenameSSID;
    // When
    sut.renameAccessory_options_(accessory, options);
    // Then
    expect(sessionMock.calls.firstOrNull, equals(SessionMockMethodCall.renameAccessoryOptions));
    expect(sessionMock.renameAccessoryOptionsAccessoryValue, equals(accessory));
    expect(sessionMock.renameAccessoryOptionsOptionsValue, equals(options));
  });

  test('session adapter renames accessories using session when the `renameAccessory_options_` method called',
      () async {
    // Given
    final accessory = FFIASAccessoryMock();
    final options = ASAccessoryRenameOptions.ASAccessoryRenameSSID;
    // When
    sut.renameAccessory_options_(accessory, options);
    // Then
    expect(sessionMock.calls.firstOrNull, equals(SessionMockMethodCall.renameAccessoryOptions));
    expect(sessionMock.renameAccessoryOptionsAccessoryValue, equals(accessory));
    expect(sessionMock.renameAccessoryOptionsOptionsValue, equals(options));
  });

   test('session adapter removes the accessory using session when the `removeAccessory_` method called',
      () async {
    // Given
    final accessory = FFIASAccessoryMock();
    // When
    sut.removeAccessory_(accessory);
    // Then
    expect(sessionMock.calls.firstOrNull, equals(SessionMockMethodCall.removeAccessory));
    expect(sessionMock.removeAccessoryValue, equals(accessory));
  });

  test('session adapter finishes authorization of the accessory using session when the `finishAuthorizationForAccessory_settings_` method called',
      () async {
    // Given
    final accessory = FFIASAccessoryMock();
    final settings = FFIASAccessorySettingsMock();
    // When
    sut.finishAuthorizationForAccessory_settings_(accessory, settings);
    // Then
    expect(sessionMock.calls.firstOrNull, equals(SessionMockMethodCall.finishAuthorizationForAccessorySettings));
    expect(sessionMock.finishAuthorizationForAccessorySettingsAccessoryValue, equals(accessory));
  });

  test('session adapter fails authorization of the accessory using session when the `failAuthorizationForAccessory_` method called',
      () async {
    // Given
    final accessory = FFIASAccessoryMock();
    // When
    sut.failAuthorizationForAccessory_(accessory);
    // Then
    expect(sessionMock.calls.firstOrNull, equals(SessionMockMethodCall.failAuthorizationForAccessory));
    expect(sessionMock.failAuthorizationForAccessoryValue, equals(accessory));
  });
}
