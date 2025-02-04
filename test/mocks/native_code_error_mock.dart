import 'package:flutter_accessorysetup/flutter_accessorysetup.dart';

class NativeCodeErrorMock implements NativeCodeError {
  @override
  int code = 1;

  @override
  String description = "NativeCodeErrorMock";

  @override
  String domain = "Tests";

  @override
  StackTrace? get stackTrace => throw UnimplementedError();
}