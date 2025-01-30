import 'package:objective_c/objective_c.dart';

class FFINSErrorMock implements NSError {

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(invocation.memberName.toString().split('"')[1]);
  }
}
