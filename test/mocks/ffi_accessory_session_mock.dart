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
  void renameAccessory_options_(
      ASAccessory accessory, ASAccessoryRenameOptions options) {
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
  void finishAuthorizationForAccessory_settings_(
      ASAccessory accessory, ASAccessorySettings settings) {
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

  // @override
  // FFIAccessorySession autorelease() {
  //   // TODO: implement autorelease
  //   throw UnimplementedError();
  // }

  // @override
  // objc.ObjCObjectBase class2() {
  //   // TODO: implement class2
  //   throw UnimplementedError();
  // }

  // @override
  // bool conformsToProtocol_1(objc.Protocol aProtocol) {
  //   // TODO: implement conformsToProtocol_1
  //   throw UnimplementedError();
  // }

  // @override
  // objc.ObjCObjectBase copy() {
  //   // TODO: implement copy
  //   throw UnimplementedError();
  // }

  // @override
  // void dealloc() {
  //   // TODO: implement dealloc
  // }

  // @override
  // // TODO: implement debugDescription1
  // objc.NSString get debugDescription1 => throw UnimplementedError();

  // @override
  // // TODO: implement description1
  // objc.NSString get description1 => throw UnimplementedError();

  // @override
  // void doesNotRecognizeSelector_(Pointer aSelector) {
  //   // TODO: implement doesNotRecognizeSelector_
  // }

  // @override
  // void forwardInvocation_(objc.NSInvocation anInvocation) {
  //   // TODO: implement forwardInvocation_
  // }

  // @override
  // objc.ObjCObjectBase forwardingTargetForSelector_(Pointer aSelector) {
  //   // TODO: implement forwardingTargetForSelector_
  //   throw UnimplementedError();
  // }

  // @override
  // // TODO: implement hash1
  // int get hash1 => throw UnimplementedError();

  // @override
  // FFIAccessorySession init() {
  //   // TODO: implement init
  //   throw UnimplementedError();
  // }

  // @override
  // bool isEqual_(objc.ObjCObjectBase object) {
  //   // TODO: implement isEqual_
  //   throw UnimplementedError();
  // }

  // @override
  // bool isKindOfClass_(objc.ObjCObjectBase aClass) {
  //   // TODO: implement isKindOfClass_
  //   throw UnimplementedError();
  // }

  // @override
  // bool isMemberOfClass_(objc.ObjCObjectBase aClass) {
  //   // TODO: implement isMemberOfClass_
  //   throw UnimplementedError();
  // }

  // @override
  // bool isProxy() {
  //   // TODO: implement isProxy
  //   throw UnimplementedError();
  // }

  // @override
  // Pointer<NativeFunction<Void Function()>> methodForSelector_(
  //     Pointer aSelector) {
  //   // TODO: implement methodForSelector_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.NSMethodSignature methodSignatureForSelector_(Pointer aSelector) {
  //   // TODO: implement methodSignatureForSelector_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.ObjCObjectBase mutableCopy() {
  //   // TODO: implement mutableCopy
  //   throw UnimplementedError();
  // }

  // @override
  // objc.ObjCObjectBase performSelector_(Pointer aSelector) {
  //   // TODO: implement performSelector_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.ObjCObjectBase performSelector_withObject_(
  //     Pointer aSelector, objc.ObjCObjectBase object) {
  //   // TODO: implement performSelector_withObject_
  //   throw UnimplementedError();
  // }

  // @override
  // objc.ObjCObjectBase performSelector_withObject_withObject_(Pointer aSelector,
  //     objc.ObjCObjectBase object1, objc.ObjCObjectBase object2) {
  //   // TODO: implement performSelector_withObject_withObject_
  //   throw UnimplementedError();
  // }

  // @override
  // // TODO: implement ref
  // get ref => throw UnimplementedError();

  // @override
  // void release() {
  //   // TODO: implement release
  // }

  // @override
  // bool respondsToSelector_(Pointer aSelector) {
  //   // TODO: implement respondsToSelector_
  //   throw UnimplementedError();
  // }

  // @override
  // FFIAccessorySession retain() {
  //   // TODO: implement retain
  //   throw UnimplementedError();
  // }

  // @override
  // int retainCount() {
  //   // TODO: implement retainCount
  //   throw UnimplementedError();
  // }

  // @override
  // FFIAccessorySession self() {
  //   // TODO: implement self
  //   throw UnimplementedError();
  // }

  // @override
  // // TODO: implement superclass1
  // objc.ObjCObjectBase get superclass1 => throw UnimplementedError();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(invocation.memberName.toString().split('"')[1]);
  }
}
