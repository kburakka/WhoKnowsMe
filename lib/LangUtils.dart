import 'package:flutter/material.dart';
import 'package:my_app/AppLocalizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangUtils {
  static const String PREFS_LANGUAGE = "lang";

  static void saveLanguage(Locale locale) {
    AppLocalizations.updateLocale(locale);
    SharedPreferences.getInstance().then((prefs) {
      String curLang = prefs.getString(PREFS_LANGUAGE) ?? "";
      if (curLang != locale.languageCode)
        prefs.setString(PREFS_LANGUAGE, locale.languageCode);
    });
       
  }
  static Future<String> getLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREFS_LANGUAGE) ?? "en";
  }
}
