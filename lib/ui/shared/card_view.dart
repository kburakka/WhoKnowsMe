import 'package:flutter/material.dart';
import 'package:my_app/AppLocalizations.dart';
import 'package:my_app/core/model/Question.dart';
import 'package:my_app/ui/shared/question_text.dart';



class CardView extends StatefulWidget {
  final Question question;

  const CardView({Key key, this.question}) : super(key: key);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        child: ListTile(
            title: QuestionText(question: widget.question),
            subtitle: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blueGrey)
                  ),
                  color: widget.question.state == 1 ? Colors.indigo : Colors.white38,
                  textColor: widget.question.state == 1 ? Colors.white : Colors.black,
                  child: Text(AppLocalizations.getString('yes')),
                  onPressed: () {setState(() {
                    widget.question.state = 1;
                  }); },
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blueGrey)
                  ),
                  child: Text(AppLocalizations.getString('no')),
                  color: widget.question.state == 0 ? Colors.indigo : Colors.white38,
                  textColor: widget.question.state == 0 ? Colors.white : Colors.black,
                  onPressed: () {setState(() {
                    widget.question.state = 0;
                  });},
                ),
              ],
            )));
  }
}