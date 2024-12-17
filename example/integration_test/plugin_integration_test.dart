// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://docs.flutter.dev/cookbook/testing/integration/introduction


import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_accessorysetup/flutter_accessorysetup.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('activate test', (WidgetTester tester) async {
    final setup = FlutterAccessorySetup();
    final firstEventFuture = setup.eventStream.first;

    setup.activate();
    final event = await firstEventFuture.timeout(Duration(seconds: 2));

    expect(event.error, null, reason: 'during activation the error should be null');
    expect(event.accessory, null, reason: 'during activation the accessory should be null');
  });
}
