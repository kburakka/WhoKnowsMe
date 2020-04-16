import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/LangUtils.dart';
import 'package:my_app/core/Constans.dart';
class AppLocalizations {
  static AppLocalizations _instance;
  Locale _locale;
  Function() _callback;

  Map<String, String> _strings = const {};
  AppLocalizations(this._locale, this._callback);

  static AppLocalizations of(BuildContext context,Function callback) {
    if (_instance == null)
      _instance = Localizations.of<AppLocalizations>(context, AppLocalizations);
      _instance._callback = callback;
      _instance._callback();
    return _instance;
  }

  static String getString(String key) {
    return _instance?._strings[key] ?? "";
  }

  static Future<void> updateLocale(Locale locale) async{
    if (_instance != null) {
      _instance._locale = locale;
      await _instance._loadStrings();
      Constants.languageCode = locale.languageCode;
    }
  }

  Future<void> _loadStrings() async {
    final String jsonString = await rootBundle.loadString(
      "assets/languages/${_locale.languageCode}.json",
    );
    _strings = Map.from(jsonDecode(jsonString));
    _callback();
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

void dummy(){}
  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }
  @override
  Future<AppLocalizations> load(Locale locale) async {
    final code = await LangUtils.getLanguageCode();
    Constants.languageCode = code;
    AppLocalizations appLocalization = AppLocalizations(Locale(code),dummy);
    await appLocalization._loadStrings();
    return appLocalization;
  }

  @override
  bool shouldReload(LocalizationsDelegate old) {
    return false;
  }
}