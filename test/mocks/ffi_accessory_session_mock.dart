import 'package:objective_c/objective_c.dart' as objc;

import 'package:flutter_accessorysetup/gen/ios/accessory_setup_bindings.dart';

import 'objc_ns_array_mock.dart';

enum SessionMockMethodCall {
  getLogs,
  getAccessories,
  setDelegate,
  activate,
  invalidate,
  showPicker,
  showPickerForItems,
  renameAccessoryOptions,
  removeAccessory,
  finishAuthorizationForAccessorySettings,
  failAuthorizationForAccessory
}

class FFIAccessorySessionMock implements FFIAccessorySession {
  // region Mocking

  List<SessionMockMethodCall> _calls = [];
  List<SessionMockMethodCall> get calls => _calls;

  objc.NSArray? showPickerForItemsValue;

  ASAccessory? renameAccessoryOptionsAccessoryValue;
  ASAccessoryRenameOptions? renameAccessoryOptionsOptionsValue;

  ASAccessory? removeAccessoryValue;

  ASAccessory? finishAuthorizationForAccessorySettingsAccessoryValue;
  ASAccessorySettings? finishAuthorizationForAccessorySettingsSettingsValue;

  ASAccessory? failAuthorizationForAccessoryValue;

  // callbacks

  Function? activateCallback;
  Function? invalidateCallback;
  Function? showPickerCallback;
  Function? showPickerForItemsCallback;
  Function? renameAccessoryOptionsCallback;
  Function? removeAccessoryCallback;
  Function? finishAuthorizationForAccessorySettingsCallback;
  Function? failAuthorizationForAccessoryCallback;

  // resetting

  void resetMock() {
    _calls = [];
    showPickerForItemsValue = null;
    renameAccessoryOptionsAccessoryValue = null;
    renameAccessoryOptionsOptionsValue = null;
    removeAccessoryValue = null;
    finishAuthorizationForAccessorySettingsAccessoryValue = null;
    finishAuthorizationForAccessorySettingsSettingsValue = null;
    failAuthorizationForAccessoryValue = null;
  }

  // endregion

  // region Overwrites

  @override
  objc.NSArray get logs {
    calls.add(SessionMockMethodCall.getAccessories);
    return NSArrayMock();
  }

  @override
  objc.NSArray get accessories {
    calls.add(SessionMockMethodCall.getAccessories);
    return NSArrayMock();
  }

  @override
  void setDelegate_(objc.ObjCObjectBase delegate) {
    calls.add(SessionMockMethodCall.setDelegate);
  }

  @override
  void activate() {
    calls.add(SessionMockMethodCall.activate);
    activateCallback?.call();
  }

  @override
  void invalidate() {
    calls.add(SessionMockMethodCall.invalidate);
    invalidateCallback?.call();
  }

  @override
  void showPicker() {
    calls.add(SessionMockMethodCall.showPicker);
    showPickerCallback?.call();
  }

  @override
  void showPickerForItems_(objc.NSArray items) {
    calls.add(SessionMockMethodCall.showPickerForItems);
    showPickerForItemsValue = items;
    showPickerForItemsCallback?.call();
  }

  /// renameAccessory:options:
  @override
  // ignore: non_constant_identifier_names
  void renameAccessory_options_(ASAccessory accessory, ASAccessoryRenameOptions options) {
    calls.add(SessionMockMethodCall.renameAccessoryOptions);
    renameAccessoryOptionsAccessoryValue = accessory;
    renameAccessoryOptionsOptionsValue = options;
    renameAccessoryOptionsCallback?.call();
  }

  /// removeAccessory:
  @override
  void removeAccessory_(ASAccessory accessory) {
    calls.add(SessionMockMethodCall.removeAccessory);
    removeAccessoryValue = accessory;
    removeAccessoryCallback?.call();
  }

  /// finishAuthorizationForAccessory:settings:
  @override
  // ignore: non_constant_identifier_names
  void finishAuthorizationForAccessory_settings_(ASAccessory accessory, ASAccessorySettings settings) {
    calls.add(SessionMockMethodCall.finishAuthorizationForAccessorySettings);
    finishAuthorizationForAccessorySettingsAccessoryValue = accessory;
    finishAuthorizationForAccessorySettingsSettingsValue = settings;
    finishAuthorizationForAccessorySettingsCallback?.call();
  }

  @override
  void failAuthorizationForAccessory_(ASAccessory accessory) {
    calls.add(SessionMockMethodCall.failAuthorizationForAccessory);
    failAuthorizationForAccessoryValue = accessory;
    failAuthorizationForAccessoryCallback?.call();
  }

  // endregion

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(invocation.memberName.toString().split('"')[1]);
  }
}
