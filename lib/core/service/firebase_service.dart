import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_app/core/model/Question.dart';
class FirebaseService{
  static const String FIRABASE_URL = 'https://whoknowsme-8e365.firebaseio.com/';

  Future<List<Qustion>> getQuestions() async{
      final response = await http.get("$FIRABASE_URL/questions.json");
      
      switch (response.statusCode) {
        case HttpStatus.ok:
          final jsonModel = json.decode(response.body);
          final questionList = jsonModel.map((e) => Qustion.fromJson(e)).toList().cast<Qustion>();
          return questionList;
        default:
          return Future.error(response.statusCode);
      }
  }
}