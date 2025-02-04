import 'package:flutter_accessorysetup/gen/ios/accessory_setup_bindings.dart';

class FFIASAccessoryEventMock implements ASAccessoryEvent {

  final ASAccessoryEventType _eventType;


  FFIASAccessoryEventMock(this._eventType);

  @override
  ASAccessoryEventType get eventType {
    return _eventType;
  }

  @override
  String toString() => 'FFIASAccessoryEventMock(type: $_eventType)';

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(invocation.memberName.toString().split('"')[1]);
  }
}
