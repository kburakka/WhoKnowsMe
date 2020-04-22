import 'package:flutter/material.dart';
import 'package:my_app/AppLocalizations.dart';
import 'package:my_app/extension/hex_color.dart';
import 'package:my_app/ui/view/test_view.dart';

class JoinTest extends StatefulWidget {
  JoinTest({Key key}) : super(key: key);

  @override
  _JoinTestState createState() => _JoinTestState();
}

class _JoinTestState extends State<JoinTest> {
  TextEditingController roomIdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: HexColor.fromHex('484693'),
            title: Text(AppLocalizations.getString('join'))),
        body: Container(
          child: Center(
            child: IntrinsicHeight(
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(30),
                    child: new TextField(
                      controller: roomIdController,
                      style: new TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelStyle: new TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: AppLocalizations.getString('id'),
                      ),
                      cursorColor: Colors.white,
                    )),
                Padding(
                    padding: const EdgeInsets.all(30),
                    child: new FlatButton.icon(
                      color: Colors.white38,
                      icon: Icon(Icons.check),
                      label: Text(AppLocalizations.getString('enter')),
                      onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TestView(fromJoin: true,),
                          settings: RouteSettings(arguments: roomIdController.text)));
                      },
                    ))
              ]),
            ),
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                HexColor.fromHex('484693'),
                HexColor.fromHex('559596')
              ])),
        ));
  }
}
