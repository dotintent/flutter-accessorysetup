import 'package:objective_c/objective_c.dart' as objc;

import 'package:flutter_accessorysetup/src/testing.dart';

import 'objc_ns_array_mock.dart';

class DelegateAdapterMock extends DelegateAdapter {
  bool isFFISessionDelegateCreated = false;

  DelegateAdapterMock({
    required super.handleEvent,
    required super.didShowPickerWithError,
    required super.didRenameAccessoryWithError,
    required super.didRemoveAccessoryWithError,
    required super.didFinishAuthorizationForAccessoryWithError,
    required super.didFailAuthorizationForAccessoryWithError,
  });

  @override
  objc.ObjCObjectBase createFFISessionDelegate() {
    isFFISessionDelegateCreated = true;
    // returns any mock here, should not be used anyway
    return NSArrayMock();
  }
}

DelegateAdapterMock mockDelegateAdapter() {
    return DelegateAdapterMock(
      handleEvent: (_) => {},
      didShowPickerWithError: (_) => {},
      didRenameAccessoryWithError: (_, __) => {},
      didRemoveAccessoryWithError: (_, __) => {},
      didFinishAuthorizationForAccessoryWithError: (_, __) => {},
      didFailAuthorizationForAccessoryWithError: (_, __) => {});
}