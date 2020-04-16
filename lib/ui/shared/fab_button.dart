import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/AppLocalizations.dart';
import 'package:my_app/BlocLocalization.dart';

class FabButton extends StatefulWidget {
  @override
  _FabButtonState createState() => _FabButtonState();
}

class _FabButtonState extends State<FabButton> {

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => FloatingActionButton.extended(
              onPressed: () {
                BlocProvider.of<BlocLocalization>(context).add(Language.TR);
              },
              label: Text(AppLocalizations.getString('create')),
              icon: Icon(Icons.thumb_up),
              backgroundColor: Colors.pink,
            ));
  }
}