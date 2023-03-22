import 'package:design_demo/main.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('First page test ', (WidgetTester tester) async {
    // Build the app.
    await tester.pumpWidget(const MyApp());

    // Verify that the current color is the expected color.
  });
}
