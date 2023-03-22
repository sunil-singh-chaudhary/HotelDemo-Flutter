import 'package:design_demo/screen/FirstPage.dart';
import 'package:flutter/material.dart';

import '../screen/DetailsPage.dart';
import '../screen/HomePage.dart';
import '../screen/NotFoundPage.dart';
import '../screen/SettingsPage.dart';

class Routes {
  static const String home = '/';
  static const String details = '/details';
  static const String setting = '/settings';
  static const String firstpage = '/FirstPage';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => HomePage(),
      details: (context) => const DetailsPage(),
      setting: (context) => const SettingsPage(),
      firstpage: (context) => const FirstPage(),
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => HomePage());
      case details:
        return MaterialPageRoute(builder: (context) => const DetailsPage());
      case firstpage:
        return MaterialPageRoute(builder: (context) => const FirstPage());
      case setting:
        return MaterialPageRoute(builder: (context) => const SettingsPage());
      default:
        return MaterialPageRoute(builder: (context) => const NotFoundPage());
    }
  }
}
