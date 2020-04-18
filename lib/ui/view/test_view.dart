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

  @override
  void initState() {
    super.initState();
    service = FirebaseService();
    realAnswers = [];
  }

  @override
  Widget build(BuildContext context) {
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
                  Expanded(child: _buildList()),
                  Padding(
                      padding: const EdgeInsets.all(30), child: _finalButon())
                ]))));
  }

  Widget _buildList() {
    if (widget.fromJoin) {
      Future<Test> test = service.getTest("-M5CrUk1fAR6aOW7L3SV");
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
      Future<List<Question>> questions = service.getQuestions();
      return FutureBuilder(
        future: questions,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                questions = (snapshot.data..shuffle()).take(5).toList();
                return _listView((snapshot.data..shuffle()).take(5).toList());
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

  Widget _finalButon() {
    if (widget.fromJoin) {
      return FlatButton.icon(
        color: Colors.white38,
        icon: Icon(Icons.send),
        label: Text(AppLocalizations.getString('send')),
        onPressed: () async {
          now = DateTime.now();
          Result result = new Result();
          result.date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
          result.fillerId = await SharedPref.getFirebaseKey();
          result.testId = "-M5CrUk1fAR6aOW7L3SV";
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
          service.postResult(result);
        },
      );
    } else {
      return FlatButton.icon(
        color: Colors.white38,
        icon: Icon(Icons.share),
        label: Text(AppLocalizations.getString('share')),
        onPressed: () async {
          now = DateTime.now();
          Test test = new Test();
          test.date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
          test.questions = questions;
          test.owner = await SharedPref.getFirebaseKey();
          service.postTest(test);
        },
      );
    }
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

  Widget get notFoundWidget => Center(child: Text("NOT FOUND"));
  Widget get waitingWidget => Center(child: CircularProgressIndicator());
}
