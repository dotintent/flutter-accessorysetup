import 'package:flutter_accessorysetup/gen/ios/accessory_setup_bindings.dart';

class FFIASAccessoryMock implements ASAccessory {

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(invocation.memberName.toString().split('"')[1]);
  }
}
