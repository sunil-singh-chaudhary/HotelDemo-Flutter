import 'package:design_demo/screen/UsersPage.dart';
import 'package:design_demo/screen/HomePage.dart';
import 'package:design_demo/screen/SettingsPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('bottomNavigation test hompage', (WidgetTester tester) async {
    // Build the app.
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    // Tap on the second item in the bottom navigation bar.
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();

    // Verify that the ProfilePage is displayed.
    expect(find.byType(UsersPage), findsOneWidget);

    // Tap on the third item in the bottom navigation bar.
    await tester.tap(find.byIcon(Icons.person));
    await tester.pump();
    // Verify that the SettingsPage is displayed.
    expect(find.byType(SettingsPage), findsOneWidget);

    // Tap on the first item in the bottom navigation bar.
    await tester.tap(find.byIcon(Icons.home));
    await tester.pump();

    // Verify that the HomePage is displayed.
    expect(find.byType(HomePage), findsOneWidget);
  });
}
