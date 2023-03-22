import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;
  static Map<String, dynamic>? _localizedValues;

  static Future<AppLocalizations> load(Locale locale) async {
    final String jsonString = await rootBundle
        .loadString('assets/images/i18n/${locale.languageCode}.json');
    _localizedValues = json.decode(jsonString);
    return AppLocalizations(locale);
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  String? translate(String key) {
    print('key--> ${key}');
    print('value--> ${_localizedValues?[key]}');
    return _localizedValues?[key];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
