// ignore_for_file: non_constant_identifier_names

import 'package:objective_c/objective_c.dart' as objc;

import 'package:flutter_accessorysetup/gen/ios/accessory_setup_bindings.dart';

class FFIAccessorySessionAdapter {
  final FFIAccessorySession _session;
  DelegateAdapter? delegateAdapter;

  FFIAccessorySessionAdapter(this._session);

  objc.NSArray get logs {
    return _session.logs;
  }

  objc.NSArray get accessories {
    return _session.accessories;
  }

  void setDelegateAdapter(DelegateAdapter delegateAdapter) {
    this.delegateAdapter = delegateAdapter;
    _session.setDelegate_(delegateAdapter.createFFISessionDelegate());
  }

  void activate() {
    _session.activate();
  }

  void invalidate() {
    _session.invalidate();
    delegateAdapter = null;
  }

  void showPicker() {
    _session.showPicker();
  }

  void showPickerForItems_(objc.NSArray items) {
    _session.showPickerForItems_(items);
  }

  /// renameAccessory:options:
  void renameAccessory_options_(
      ASAccessory accessory, ASAccessoryRenameOptions options) {
    _session.renameAccessory_options_(accessory, options);
  }

  /// removeAccessory:
  void removeAccessory_(ASAccessory accessory) {
    _session.removeAccessory_(accessory);
  }

  /// finishAuthorizationForAccessory:settings:
  void finishAuthorizationForAccessory_settings_(
      ASAccessory accessory, ASAccessorySettings settings) {
    _session.finishAuthorizationForAccessory_settings_(accessory, settings);
  }

  void failAuthorizationForAccessory_(ASAccessory accessory) {
    _session.failAuthorizationForAccessory_(accessory);
  }
}

typedef DelegateAdapterFactory = DelegateAdapter Function({
  required void Function(ASAccessoryEvent) handleEvent,
  required void Function(objc.NSError?) didShowPickerWithError,
  required void Function(ASAccessory, objc.NSError?)
      didRenameAccessoryWithError,
  required void Function(ASAccessory, objc.NSError?)
      didRemoveAccessoryWithError,
  required void Function(ASAccessory, objc.NSError?)
      didFinishAuthorizationForAccessoryWithError,
  required void Function(ASAccessory, objc.NSError?)
      didFailAuthorizationForAccessoryWithError,
});

class DelegateAdapter {
  late final objc.ObjCObjectBase delegate;

  void Function(ASAccessoryEvent) handleEvent;
  late void Function(objc.NSError?) didShowPickerWithError;
  late void Function(ASAccessory, objc.NSError?) didRenameAccessoryWithError;
  late void Function(ASAccessory, objc.NSError?) didRemoveAccessoryWithError;
  late void Function(ASAccessory, objc.NSError?)
      didFinishAuthorizationForAccessoryWithError;
  late void Function(ASAccessory, objc.NSError?)
      didFailAuthorizationForAccessoryWithError;

  DelegateAdapter({
    required this.handleEvent,
    required this.didShowPickerWithError,
    required this.didRenameAccessoryWithError,
    required this.didRemoveAccessoryWithError,
    required this.didFinishAuthorizationForAccessoryWithError,
    required this.didFailAuthorizationForAccessoryWithError,
  });

  objc.ObjCObjectBase createFFISessionDelegate() {
    return FFIAccessorySessionDelegate.implementAsListener(
        handleEvent_: handleEvent,
        didShowPickerWithError_: didShowPickerWithError,
        didRenameAccessory_withError_: didRenameAccessoryWithError,
        didRemoveAccessory_withError_: didRemoveAccessoryWithError,
        didFinishAuthorizationForAccessory_withError_:
            didFinishAuthorizationForAccessoryWithError,
        didFailAuthorizationForAccessory_withError_:
            didFailAuthorizationForAccessoryWithError);
  }
}
