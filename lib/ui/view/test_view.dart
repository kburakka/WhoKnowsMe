import 'package:flutter/material.dart';
import 'package:my_app/AppLocalizations.dart';
import 'package:my_app/core/SharedPref.dart';
import 'package:my_app/core/model/Question.dart';
import 'package:my_app/core/model/Result.dart';
import 'package:my_app/core/model/Test.dart';
import 'package:my_app/core/service/firebase_service.dart';
import 'package:my_app/extension/hex_color.dart';
import 'package:my_app/ui/shared/card_view.dart';
import 'package:intl/intl.dart';
import 'package:my_app/ui/shared/warning_alert.dart';
import 'package:my_app/ui/view/MyHomePage.dart';
import 'package:share/share.dart';

class TestView extends StatefulWidget {
  final bool fromJoin;

  const TestView({Key key, this.fromJoin}) : super(key: key);

  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  FirebaseService service;
  List<Question> questions;
  DateTime now;
  List<int> realAnswers;
  TextEditingController nameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    service = FirebaseService();
    realAnswers = [];
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: HexColor.fromHex('484693'),
            title: Text(AppLocalizations.getString('questions'))),
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
                child: Column(children: [
                  Expanded(child: _buildList(id)),Padding(
                        padding: const EdgeInsets.only(
                          left: 30, top: 10, right: 30, bottom: 0),
                        child: new TextField(
                          controller: nameController,
                          style: new TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelStyle: new TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: AppLocalizations.getString('name'),
                          ),
                          cursorColor: Colors.white,
                        ))
                        ,
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 10, right: 0, bottom: 30),
                      child: _finalButon())
                ]))));
  }

  Widget _buildList(String id) {
    if (widget.fromJoin) {
      Future<Test> test = service.getTest(id);
      return FutureBuilder(
        future: test,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                return _listViewForJoin(snapshot.data);
              } else {
                return notFoundWidget;
              }
              break;
            default:
              return waitingWidget;
          }
        },
      );
    } else {
      Future<List<Question>> questionFuture = service.getQuestions();
      return FutureBuilder(
        future: questionFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                questions = (snapshot.data..shuffle()).take(10).toList();
                return _listView(questions);
              } else {
                return notFoundWidget;
              }
              break;
            default:
              return waitingWidget;
          }
        },
      );
    }
  }

  String id = "fail";
  Widget _finalButon() {
    if (widget.fromJoin) {
      return FlatButton.icon(
        color: Colors.white38,
        icon: Icon(Icons.send),
        label: Text(AppLocalizations.getString('send')),
        onPressed: () async{
          print(nameController.text);
          if (questions.map((f) => f.state).contains(-1) || nameController.text == "") {
            await _showTestDialog("fill");
          } else {
            now = DateTime.now();
            Result result = new Result();
            result.date = DateFormat('yyyy-MM-dd HH:mm:ss. SSS').format(now);
            result.fillerId = await SharedPref.getFirebaseKey();
            result.testId = id;
            int point = 0;
            List<int> fillerAnswers = questions.map((f) => f.state).toList();
            if (realAnswers.length == fillerAnswers.length) {
              for (var i = 0; i < realAnswers.length; i++) {
                if (realAnswers[i] == fillerAnswers[i]) {
                  point = point + 1;
                }
              }
            }
            result.score = point;
            await service.postResult(result);
            _neverSatisfied(point);
          }
        },
      );
    } else {
      return FlatButton.icon(
        color: Colors.white38,
        icon: Icon(Icons.share),
        label: Text(AppLocalizations.getString('share')),
        onPressed: () async {
          if (questions.map((f) => f.state).contains(-1) || nameController.text == "") {
            await _showTestDialog("fill");
          } else {
            now = DateTime.now();
            Test test = new Test();
            test.date = DateFormat('yyyy-MM-dd HH:mmssSSS').format(now);
            test.questions = questions;
            test.owner = await SharedPref.getFirebaseKey();
            test.name = nameController.text;

            test.id = test.owner.substring(test.owner.length - 1) +
                test.date.split(":")[1];

            id = await service.postTest(test);
            await _showTestDialog(id);
          }
        },
      );
    }
  }

  Future<void> _neverSatisfied(int point) async {
    String text = AppLocalizations.getString('point') + "$point.";
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WarningAlert(
            body: text,
            title: AppLocalizations.getString('congratulations'),
            route: MyHomePage());
      },
    );
  }

  Future<void> _showTestDialog(String type) async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (type == "fail") {
          return WarningAlert(
              body: "",
              title: AppLocalizations.getString('error'));
        } else if (type == "fill") {
          return WarningAlert(
              title: AppLocalizations.getString("warning"),
              body: AppLocalizations.getString("fill"));
        } else {
          return AlertDialog(
            title: Text('Tebrikler oyununuz kaydedildi. Oyun no : $id'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Share'),
                onPressed: () {
                  Share.share('check out my website https://example.com');
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      },
    );
  }

  Widget _listViewForJoin(Test test) {
    questions = test.questions;
    questions.forEach((f) => realAnswers.add(f.state));
    questions.forEach((f) => f.state = -1);

    return ListView.separated(
        itemCount: test.questions.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => CardView(
              question: test.questions[index],
            ));
  }

  Widget _listView(List<Question> list) => ListView.separated(
      itemCount: list.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => CardView(
            question: list[index],
          ));

  Widget get notFoundWidget => WarningAlert(title:AppLocalizations.getString('not_found'),body: AppLocalizations.getString("not_found_body"),);
  Widget get waitingWidget => Center(child: CircularProgressIndicator());
}
