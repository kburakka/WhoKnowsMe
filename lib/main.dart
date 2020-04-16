import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_app/AppLocalizations.dart';
import 'package:my_app/ui/view/MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [Locale("en"), Locale("tr")],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
       localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
         return locale;
       },
       home: MyHomePage(),
    );
  }
}

