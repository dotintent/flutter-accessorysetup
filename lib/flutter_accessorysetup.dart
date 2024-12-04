import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:objective_c/objective_c.dart';
import 'package:ffi/ffi.dart';

import 'package:flutter_accessorysetup/gen/ios/accessory_setup_bindings.dart';
import 'package:flutter_accessorysetup/helpers.dart';


class FlutterAccessorysetupFFI {
  // final lib = ffi.DynamicLibrary.open('flutter_accessorysetup');

  final session = FFIAccessorySession.alloc().init();

  late final delegate = FFIAccessorySessionDelegate.implementAsListener(
    handleEvent_: handleEvent,
    didShowPickerWithError_: didShowPicker,
    didRenameAccessory_withError_: didRenameAccessory,
    didRemoveAccessory_withError_: didRemoveAccessory,
    didFinishAuthorizationForAccessory_withError_: didFinishAuthorization,
    didFailAuthorizationForAccessory_withError_: didFailAuthorization
  );

  // endregion

  void activate() {
    print("Set Delegate");
    session.setDelegate_(delegate);
    print("Activate");
    session.activate();
    sleep(const Duration(seconds: 2));
    print("Get accessories: ${session.accessories}");
    getLogs();
  }

  // region Delegate

  void handleEvent(ASAccessoryEvent event) {
    print('Accessory Event Received: $event');
    print('Type: ${event.eventType}');
    print('Accessory: ${event.accessory}');
    print('Error: ${event.error}');
  }

  void didShowPicker(NSError? nsError) {

  }

  void didRenameAccessory(ASAccessory accessory, NSError? nsError) {

  }

  void didRemoveAccessory(ASAccessory accessory, NSError? nsError) {

  }

  void didFinishAuthorization(ASAccessory accessory, NSError? nsError) {

  }

  void didFailAuthorization(ASAccessory accessory, NSError? nsError) {

  }

  // endregion

  // region Logs

  void getLogs() {
    final logs = session.logs.toStringList();
    print("logs count: ${logs.length}");
    for (final log in logs) {
      print(log);
    }
  }

  // endregion
}
