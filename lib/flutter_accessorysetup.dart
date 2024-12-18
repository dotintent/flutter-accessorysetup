import 'dart:async';
import 'dart:io';

import 'package:objective_c/objective_c.dart';
import 'package:flutter/services.dart';

import 'package:flutter_accessorysetup/gen/ios/accessory_setup_bindings.dart';
import 'package:flutter_accessorysetup/helpers.dart';


/// The main class of the library that provides service functionality
/// Use it to activate the session and find and configure devices
class FlutterAccessorySetup {
  Stream<ASAccessoryEvent> get eventStream => _eventsController.stream;
  List<ASAccessory> get accessories => _session.accessories.toList();
  final _session = FFIAccessorySession.alloc().init();
  final _eventsController = StreamController<ASAccessoryEvent>();

  late final _delegate = FFIAccessorySessionDelegate.implementAsListener(
      handleEvent_: _handleEvent,
      didShowPickerWithError_: _didShowPicker,
      didRenameAccessory_withError_: _didRenameAccessory,
      didRemoveAccessory_withError_: _didRemoveAccessory,
      didFinishAuthorizationForAccessory_withError_: _didFinishAuthorization,
      didFailAuthorizationForAccessory_withError_: _didFailAuthorization);
  // TODO: bind completers to accessories to enable multiple calls
  Completer<void>? _showPickerCompleter;
  Completer<void>? _renameAccessoryCompleter;
  Completer<void>? _removeAccessoryCompleter;
  Completer<void>? _finishAuthorizationForAccessoryCompleter;
  Completer<void>? _failAuthorizationForAccessoryCompleter;

  void dispose() {
    _eventsController.close();
  }

  // region Interface

  /// Activates the session.
  /// You should activate the session before using it
  void activate() {
    _session.setDelegate_(_delegate);
    _session.activate();
  }

  /// Shows device picker
  Future<void> showPicker() async {
    final completer = Completer<void>();
    _showPickerCompleter = completer;
    _session.showPicker();
    return completer.future;
  }

  /// Shows device picker configured with list of `ASPickerDisplayItem`
  Future<void> showPickerForItems(List<ASPickerDisplayItem> items) async {
    final completer = Completer<void>();
    _showPickerCompleter = completer;
    _session.showPickerForItems_(items.toNSArray());
    return completer.future;
  }

  /// Shows device picker configured for a single device
  /// parameters:
  /// - name: the name of the device to display in picker
  /// - asset: the asset of the device image to display in picker
  /// - serviceID: the service UUID advertised by device (to search for a particular device)
  Future<void> showPickerForDevice(
      String name, String asset, String serviceID) async {
    final completer = Completer<void>();
    _showPickerCompleter = completer;

    final image = await nativeUIImageWithDartAsset(asset);
    if (image == null) {
      throw FlutterAccessorysetupError(
          code: 1, description: "Failed to load UIImage for the asset: $asset");
    }
    final descriptor = ASDiscoveryDescriptor.alloc().init();
    descriptor.bluetoothServiceUUID =
        CBUUID.UUIDWithString_(serviceID.toNSString());
    final item = ASPickerDisplayItem.alloc()
        .initWithName_productImage_descriptor_(
            name.toNSString(), image, descriptor);
    _session.showPickerForItems_([item].toNSArray());
    return completer.future;
  }

  /// Renames provided accessory using the `ASAccessoryRenameOptions`
  Future<void> renameAccessory(
      ASAccessory accessory, ASAccessoryRenameOptions options) async {
    final completer = Completer<void>();
    _renameAccessoryCompleter = completer;
    _session.renameAccessory_options_(accessory, options);
    return completer.future;
  }

  /// Removes provided accessory (disconnects from the app)
  Future<void> removeAccessory(ASAccessory accessory) async {
    final completer = Completer<void>();
    _removeAccessoryCompleter = completer;
    _session.removeAccessory_(accessory);
    return completer.future;
  }

  /// Finishes the Authorization for accessory using `ASAccessorySettings`
  Future<void> finishAuthorizationForAccessory(
      ASAccessory accessory, ASAccessorySettings settings) async {
    final completer = Completer<void>();
    _finishAuthorizationForAccessoryCompleter = completer;
    _session.finishAuthorizationForAccessory_settings_(accessory, settings);
    return completer.future;
  }

  /// Fails the Authorization for the accessory
  Future<void> failAuthorizationForAccessory(ASAccessory accessory) async {
    final completer = Completer<void>();
    _failAuthorizationForAccessoryCompleter = completer;
    _session.failAuthorizationForAccessory_(accessory);
    return completer.future;
  }

  // endregion

  // region Delegate

  void _handleEvent(ASAccessoryEvent event) {
    _eventsController.add(event);
  }

  void _didShowPicker(NSError? nsError) {
    if (nsError != null) {
      _showPickerCompleter?.completeError(NativeCodeError(nsError));
      return;
    }
    _showPickerCompleter?.complete();
  }

  void _didRenameAccessory(ASAccessory accessory, NSError? nsError) {
    if (nsError != null) {
      _renameAccessoryCompleter?.completeError(NativeCodeError(nsError));
      return;
    }
    _renameAccessoryCompleter?.complete();
  }

  void _didRemoveAccessory(ASAccessory accessory, NSError? nsError) {
    if (nsError != null) {
      _removeAccessoryCompleter?.completeError(NativeCodeError(nsError));
      return;
    }
    _removeAccessoryCompleter?.complete();
  }

  void _didFinishAuthorization(ASAccessory accessory, NSError? nsError) {
    if (nsError != null) {
      _finishAuthorizationForAccessoryCompleter
          ?.completeError(NativeCodeError(nsError));
      return;
    }
    _finishAuthorizationForAccessoryCompleter?.complete();
  }

  void _didFailAuthorization(ASAccessory accessory, NSError? nsError) {
    if (nsError != null) {
      _failAuthorizationForAccessoryCompleter
          ?.completeError(NativeCodeError(nsError));
      return;
    }
    _failAuthorizationForAccessoryCompleter?.complete();
  }

  // endregion

  // region Helpers

  /// Prints logs from the native code
  /// Use it for debugging the native part of the code
  void printNativeSessionLogs() {
    final logs = _session.logs.toDartStringList();
    print("logs count: ${logs.length}");
    for (final log in logs) {
      print(log);
    }
  }

  // Loads an image from the flutter dart asset
  static Future<UIImage?> nativeUIImageWithDartAsset(String asset) async {
    final bytes = await rootBundle.load(asset);
    return UIImage.imageWithData_(bytes.toNSData());
  }

  // endregion
}

/// The class for errors occurred in the Dart code of the library
class FlutterAccessorysetupError extends Error {
  late final int code;
  late final String description;

  FlutterAccessorysetupError({required this.code, required this.description});

  @override
  String toString() =>
      'FlutterAccessorysetupError(code: $code, description: $description)';
}

/// The class for errors occurred in the Native code of the library
class NativeCodeError extends Error {
  late final String domain;
  late final int code;
  late final String description;

  NativeCodeError(NSError nsError) {
    code = nsError.code;
    domain = nsError.domain.toDartString();
    description = nsError.localizedDescription.toDartString();
  }

  @override
  String toString() =>
      'NativeCodeError(domain: $domain, code: $code, description: $description)';
}

/// Exposing native properties as Dart types
extension ASAccessoryDartExtension on ASAccessory {
  String? get dartBluetoothIdentifier {
    return bluetoothIdentifier?.toDartUUIDString();
  }
}

/// Exposing native properties as Dart types
extension ASAccessoryEventDartExtension on ASAccessoryEvent {
  NativeCodeError? get dartError {
    final nsError = error;
    if (nsError != null) {
      return NativeCodeError(nsError);
    }
    return null;
  }

  String get dartDescription => 'AccessoryEvent($eventType, e: $dartError)';
}
