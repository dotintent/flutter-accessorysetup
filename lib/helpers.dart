import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:objective_c/objective_c.dart';

import 'package:flutter/services.dart';
import 'package:flutter_accessorysetup/gen/ios/accessory_setup_bindings.dart';

NSObject? _convertKnownType(Object? o) {
  return switch (o) {
    null => null,
    final String s => NSString(s),
    final List<Object?> l => l.toNSArray(),
    final Map<Object?, Object?> m => m.toNSDictionary(),
    final int i => NSNumber.alloc().initWithInt_(i),
    final double d => NSNumber.alloc().initWithDouble_(d),
    final ByteData data => data.toNSData(),
    final ASMigrationDisplayItem item => item,
    final ASPickerDisplayItem item => item,
    _ => throw UnimplementedError('No conversion for $o'),
  };
}

NSObject _covertKnownTypeWithNSNull(Object? o) {
  return _convertKnownType(o) ?? NSNull.null1();
}

extension ListExtension on List {
  NSArray toNSArray() {
    final NSMutableArray array = NSMutableArray.arrayWithCapacity_(length);
    for (final Object? o in this) {
      array.addObject_(_covertKnownTypeWithNSNull(o));
    }
    return array;
  }
}

extension MapExtension on Map {
  NSDictionary toNSDictionary() {
    final NSMutableDictionary dict = NSMutableDictionary.dictionaryWithCapacity_(length);
    for (final MapEntry<Object?, Object?> entry in entries) {
      dict.setObject_forKey_(_covertKnownTypeWithNSNull(entry.value), _covertKnownTypeWithNSNull(entry.key));
    }
    return dict;
  }
}

extension NSArrayExtension on NSArray {
  List<T> toList<T>() {
    final List<dynamic> results = List.filled(count, null);
    for (int i = 0; i < count; i++) {
      final ObjCObjectBase object = objectAtIndex_(i);
      results[i] = object.downcast();
    }
    return results.cast();
  }

  List<String> toDartStringList() {
    return toList<NSString>().map((nsString) => nsString.toDartString()).toList();
  }
}

extension DartStringExtension on NSString {
  String toDartString() {
    final Pointer<Utf8> pointer = UTF8String.cast();
    return pointer.toDartString();
  }
}

extension DartStringUUIDExtension on NSUUID {
  String toDartUUIDString() {
    return UUIDString.toDartString();
  }
}

extension ObjCObjectBaseExtension on ObjCObjectBase {
  dynamic downcast() {
    if (ASAccessory.isInstance(this)) {
      return ASAccessory.castFrom(this);
    } else if (NSString.isInstance(this)) {
      return NSString.castFrom(this);
    } else if (UIImage.isInstance(this)) {
      return UIImage.castFrom(this);
    } else if (NSData.isInstance(this)) {
      return NSData.castFrom(this);
    } else if (NSNumber.isInstance(this)) {
      return NSNumber.castFrom(this);
    } else if (NSArray.isInstance(this)) {
      return NSArray.castFrom(this);
    } else if (NSError.isInstance(this)) {
      return NSError.castFrom(this);
    } else if (NSObject.isInstance(this)) {
      return NSObject.castFrom(this);
    }
    throw Exception('Unable to downcast ObjCObjectBase');
  }

  NSArray? toNSArray() {
    if (NSArray.isInstance(this)) {
      return NSArray.castFrom(this);
    }
    return null;
  }
}

extension NSDictionaryExtension on NSDictionary {
  Map<Object?, Object?> toMap() =>
      <Object?, Object?>{for (final ObjCObjectBase key in keyEnumerator().toList()) key: objectForKey_(key)?.downcast()};
}

extension NSEnumeratorExtension on NSEnumerator {
  List<ObjCObjectBase> toList() {
    final List<ObjCObjectBase> results = [];
    ObjCObjectBase? element;
    while ((element = nextObject()) != null) {
      results.add(element!);
    }
    return results;
  }
}

extension ByteDataToNativeExtension on ByteData {
  NSData toNSData() {
    return buffer.asInt8List().toNSData();
  } 
}
