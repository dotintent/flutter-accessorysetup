import 'package:objective_c/objective_c.dart' as objc;

class NSArrayMock implements objc.NSArray {
  
  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(invocation.memberName.toString().split('"')[1]);
  }
}
