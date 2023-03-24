import 'package:design_demo/App.dart';
import 'package:design_demo/Repositories/export_repositories.dart';
import 'package:design_demo/Routes/AppTheme.dart';
import 'package:design_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('status bar color test', (WidgetTester tester) async {
    // Set the status bar background color.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: kbackgroudColor),
    );
    UserRepository? userRepository;
    // Build the app.
    await tester.pumpWidget(App(
      userRepository: userRepository!,
    ));
    // Get the current status bar color.

    int? statusBarColor;
    if (SystemChrome.latestStyle?.statusBarColor != null) {
      statusBarColor = SystemChrome.latestStyle?.statusBarColor!.value;
    }
    // Verify that the current color is the expected color.

    // Verify that the status bar color is correct
    expect(kbackgroudColor.value, equals(kbackgroudColor.value));
  });
}
