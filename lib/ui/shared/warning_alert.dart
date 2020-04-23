import 'package:flutter/material.dart';
import 'package:my_app/AppLocalizations.dart';

class WarningAlert extends StatelessWidget {
  final String body;
  final String title;
  final route;

  const WarningAlert({Key key, this.body, this.title, this.route})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _alert(context);
  }

  Widget _alert(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(body),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.getString('ok')),
          onPressed: () {
            if (route == null){
              Navigator.of(context).pop();
            }else{
              Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => route));
            }
          },
        ),
      ],
    );
  }
}
