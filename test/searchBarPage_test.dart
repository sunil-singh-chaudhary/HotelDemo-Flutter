import 'package:design_demo/Routes/visibilityModel.dart';
import 'package:design_demo/main.dart';
import 'package:design_demo/screen/searchBarPage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Search page test ', (WidgetTester tester) async {
    // Initialize the Flutter bindings.
    TestWidgetsFlutterBinding.ensureInitialized();

    // Create an instance of the provider.
    visibilityModel myProvider = visibilityModel();
    // Wrap the widget tree with the provider and your predefined class.
    await tester.pumpWidget(
      ChangeNotifierProvider<visibilityModel>(
        create: (context) => myProvider,
        child: const MaterialApp(home: searchBarPage()),
      ),
    );
    // // Enter text into the search TextField
    final textFieldFinder = find.byKey(const Key('search_textfield'));
    expect(find.byType(ListView), findsNothing);

    await tester.enterText(textFieldFinder, 'a');
    await tester.pump();
    expect(find.byType(ListView), findsOneWidget);

    await tester.enterText(
        textFieldFinder, 'a'); //show clear button when enter textfield
    await tester.pump();
    expect(find.byIcon(Icons.clear), findsOneWidget);

    await tester.tap(find.byIcon(Icons.clear));
    //when click on clear icon show nothin in listv
    await tester.pump();
    expect(find.byType(ListView), findsNothing);

    await tester.enterText(textFieldFinder, 'apple');
    await tester.pump();
    expect(find.byType(ListView), findsOneWidget);

    // Type 'a' in the search field.
    await tester.enterText(find.byType(TextField), 'a');
    await tester.pump();

    // Verify that only ' 'a' related ' is visible in the list.
    expect(find.text('apple'), findsOneWidget);
    expect(find.text('banana'), findsOneWidget);
    expect(find.text('cherry'), findsNothing);

    //listview item select and show in searchbox

    await tester.enterText(textFieldFinder, 'apple');
    await tester.pumpAndSettle();
    // find the list item with the matching text
    final listItem = find.widgetWithText(ListTile, 'apple');
    // tap the list item
    await tester.tap(listItem);
    await tester.pumpAndSettle();
    // verify that the item was selected
    expect(find.text('apple'), findsOneWidget);
  });
}
