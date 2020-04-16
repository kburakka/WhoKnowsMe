import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/AppLocalizations.dart';
import 'package:my_app/BlocLocalization.dart';
import 'package:my_app/extension/hex_color.dart';
import 'package:my_app/ui/shared/fab.dart';
import 'package:my_app/ui/shared/fab_button.dart';
import 'package:my_app/ui/shared/icon_button.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void onPress() {}
  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context);
    return Scaffold(
        body: Center(
            child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            HexColor.fromHex('484693'),
            HexColor.fromHex('559596')
          ])),
      child: Center(
        child: IntrinsicHeight(
          child: Column(children: [
            HomeIconButton(
              imageName: 'joinTest',
              title: AppLocalizations.getString('join'),
            ),
            HomeIconButton(
              imageName: 'createTest',
              title: AppLocalizations.getString('create'),
            )
          ]),
        ),
      ),
    ))
    ,     
     floatingActionButton: BlocProvider<BlocLocalization>(child: FancyFab(), create: (context) => BlocLocalization())
     
     );
  }
}
