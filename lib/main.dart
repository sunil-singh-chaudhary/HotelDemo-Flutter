import 'package:design_demo/Routes/AppTheme.dart';
import 'package:design_demo/Routes/visibilityModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Routes/AppLocalizations.dart';
import 'Routes/Routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    // ignore: prefer_const_constructors
    SystemUiOverlayStyle(
      statusBarColor: //Test done
          kbackgroudColor, // Set the status bar color to transparent
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<visibilityModel>(
              create: (_) => visibilityModel())
        ],
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ' '),
              Locale('es', ' '),
            ],
            title: AppLocalizations.of(context)?.translate('app_name') ??
                'Hello', //AppLocalizations.of(context).getTranslate('title_Home'),
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: Routes.home,
            routes: Routes.getRoutes(),
            onGenerateRoute: Routes.generateRoute,
          );
        });
  }
}
