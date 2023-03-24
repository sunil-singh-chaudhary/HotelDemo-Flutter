import 'dart:async';
import 'package:design_demo/Routes/AppTheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'App.dart';
import 'Repositories/UserRepository.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    // ignore: prefer_const_constructors
    SystemUiOverlayStyle(
      statusBarColor: //Test done
          kbackgroudColor, // Set the status bar color to transparent
    ),
  );

  // Handles Flutter Errors
  FlutterError.onError = (details) {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      final error = details.exception;
      final stackTrace = details.stack ?? StackTrace.empty;
      Zone.current.handleUncaughtError(error, stackTrace);
    }
  };

  // Handles Dart Errors
  runZonedGuarded<void>(
    () {
      runApp(App(userRepository: UserRepository()));
    },
    (error, stackTrace) {
      debugPrint('Caught Dart Error');

      if (kDebugMode) {
        // In development, print [error] and [stackTrace].
        print(error);
        print(stackTrace);
      } else {
        /// In production, report to an error tracking system.
      }
    },
    zoneSpecification: const ZoneSpecification(),
    zoneValues: {},
  );
}
