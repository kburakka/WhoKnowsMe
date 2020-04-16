import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/LangUtils.dart';

enum Language { EN, TR }

class BlocLocalization extends Bloc<Language, Locale> {
  @override
  Locale get initialState => Locale("en");

  @override
  Stream<Locale> mapEventToState(Language event) async* {
    Locale locale = event == Language.TR ? Locale("tr") : Locale("en");
    LangUtils.saveLanguage(locale);
    yield locale;
  }
}