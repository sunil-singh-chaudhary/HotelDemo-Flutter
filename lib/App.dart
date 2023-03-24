import 'package:design_demo/Repositories/UserRepository.dart';
import 'package:design_demo/Routes/visibilityModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

import 'Routes/AppLocalizations.dart';
import 'Routes/Routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  final UserRepository userRepository;
  App({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        //Repositoryprovider from flutter_bloc for use same object every widget
        //can be access as now where we want repository object of user
        //
        value: userRepository,
        child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<visibilityModel>(
              create: (_) => visibilityModel()),
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
