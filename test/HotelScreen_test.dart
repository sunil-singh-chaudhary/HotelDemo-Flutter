import 'package:design_demo/Routes/list_data.dart';
import 'package:design_demo/main.dart';
import 'package:design_demo/screen/HotelScreen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Hotel screen page test ', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
                children: hotel_list
                    .map((singleHotel) => HotelScreen(hotel_list: singleHotel))
                    .toList()),
          ),
        ),
      ),
    );

    // Verify that the screen displays the correct number of items
    expect(find.byType(HotelScreen), findsNWidgets(hotel_list.length));

    // Find the horizontal scroll view
    final scrollViewFinder = find.byType(SingleChildScrollView);

    // Verify that the scroll view was found
    expect(scrollViewFinder, findsOneWidget);

    for (final item in hotel_list) {
      //isImageAsset
      final placeFinder = find.text(item['place']);
      final destinationFinder = find.text(item['destination']);
      final priceFinder = find.text(item['Price']);

      // Verify that the destination and price widgets were found
      expect(placeFinder, findsWidgets);
      expect(destinationFinder, findsWidgets);
      expect(priceFinder, findsWidgets);
    }

    // final decorationFinder = find.byWidgetPredicate(
    //     (widget) => widget is DecoratedBox && widget.decoration != null);
    // expect(decorationFinder, findsWidgets);

    //  final decorationFinder = find.byWidgetPredicate((widget) => widget is DecoratedBox
    //   && widget.decoration != null && widget.decoration is BoxDecoration &&
    //   (widget.decoration as BoxDecoration).image != null);
    // expect(decorationFinder, findsOneWidget);

    // final imageFinder = find.byWidgetPredicate((widget) => widget is Image &&
    //  widget.image is AssetImage && widget.key ==
    //   Key((decorationFinder.evaluate().first.widget.decoration as BoxDecoration).image.toString()));
    // expect(imageFinder, findsOneWidget);

    // final imageFinder = find.byWidgetPredicate(
    //     (widget) => widget is Image && widget.image is AssetImage);
    // expect(imageFinder, findsOneWidget);
  });
}
