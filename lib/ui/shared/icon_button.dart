import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/extension/hex_color.dart';
import 'package:my_app/ui/view/join_test.dart';
import 'package:my_app/ui/view/test_view.dart';

class HomeIconButton extends StatelessWidget {
  final String title;
  final String imageName;
  final String type;
  const HomeIconButton({Key key, this.title, this.imageName, this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var container = Container(
      margin: const EdgeInsets.all(50),
      child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: FlatButton(
              onPressed: () {
                if (type == "create") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TestView(fromJoin: false,),
                      settings: RouteSettings(arguments: this.title)));
                }else if(type == "join"){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => JoinTest(),
                      settings: RouteSettings(arguments: this.title)));
                }
              },
              padding: EdgeInsets.all(0.0),
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Image.asset('assets/images/' + this.imageName + '.png'),
                  Text(
                    title + "   ",
                    style: TextStyle(
                        fontSize: 25, color: HexColor.fromHex('f5ecce')),
                  )
                ],
              ))),
      width: 130,
      height: 200,
    );
    return container;
  }
}
