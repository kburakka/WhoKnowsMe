import 'package:flutter/material.dart';
import 'package:my_app/AppLocalizations.dart';
import 'package:my_app/core/SharedPref.dart';
import 'package:my_app/core/model/Question.dart';
import 'package:my_app/core/model/Test.dart';
import 'package:my_app/core/service/firebase_service.dart';
import 'package:my_app/extension/hex_color.dart';
import 'package:my_app/ui/shared/card_view.dart';
import 'package:intl/intl.dart';

class TestView extends StatefulWidget {
  const TestView({Key key}) : super(key: key);

  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  FirebaseService service;
  @override
  void initState() {
    super.initState();
    service = FirebaseService();
  }

List<Question> questions;
DateTime now;

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
                  Expanded(
                      child: FutureBuilder(
                    future: service.getQuestions(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            questions = (snapshot.data..shuffle()).take(5).toList();
                            return _listView(
                                (snapshot.data..shuffle()).take(5).toList());
                          } else {
                            return notFoundWidget;
                          }
                          break;
                        default:
                          return waitingWidget;
                      }
                    },
                  )),
                  Padding(
                      padding: const EdgeInsets.all(30),
                      child: new FlatButton.icon(
                        color: Colors.white38,
                        icon: Icon(Icons.share),
                        label: Text(AppLocalizations.getString('share')), 
                        onPressed: () async {
                          questions.forEach((f) => print(f.state));
                                                    questions.forEach((f) => print(f.turkce));
                           now = DateTime.now();
                           Test test = new Test();
                           test.date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);   
                           test.questions = questions.map((f) => f.key).join(",");
                           test.answers = questions.map((f) => f.state).join(",");     
                           test.owner = await SharedPref.getFirebaseKey();      
                           service.postTest(test);                        
                        },
                      ))
                ]))));
  }

  Widget _listView(List<Question> list) => ListView.separated(
      itemCount: list.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => CardView(question: list[index],));

  Widget get notFoundWidget => Center(child: Text("NOT FOUND"));
  Widget get waitingWidget => Center(child: CircularProgressIndicator());
}
