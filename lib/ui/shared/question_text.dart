import 'package:flutter/material.dart';
import 'package:my_app/core/Constans.dart';
import 'package:my_app/core/model/Question.dart';

class QuestionText extends StatelessWidget {
  final Question question;

  QuestionText({this.question});

  final code = Constants.languageCode;

  Widget build(BuildContext context) {
    return Text((() {
      if(code == "tr"){
        return question.turkce;}

      return question.ingilizce;
    })());
  }
}