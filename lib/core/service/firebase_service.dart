import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_app/core/model/Question.dart';
import 'package:my_app/core/model/Test.dart';
import 'package:my_app/core/model/User.dart';
import 'package:my_app/core/service/base_service.dart';

class FirebaseService {
  static const String FIREBASE_URL = 'https://whoknowsme-8e365.firebaseio.com';
  BaseService _baseService = BaseService.instance;

  Future<bool> getUser(String id) async {
    final response = await http.get("$FIREBASE_URL/users/$id.json");
    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body);
        if (jsonModel == null) return false;
        return true;
      default:
        return false;
    }
  }


  Future<List<Question>> getQuestions() async {
    var response = await _baseService.get<Question>(Question(), "questions");
    if (response is List<Question>) {
      print("okey");
    } else {
      print("hata");
    }
    return response;
  }

  Future postUser(User request) async {
    var jsonModel = json.encode(request.toJson());
    final response =
        await http.post("$FIREBASE_URL/users.json", body: jsonModel);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body);
        return jsonModel["name"];
      default:
        return "fail";
    }
  }

  Future postTest(Test request) async {
    var jsonModel = json.encode(request.toJson());
    final response =
        await http.post("$FIREBASE_URL/tests.json", body: jsonModel);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body);
        return jsonModel["name"];
      default:
        return "fail";
    }
  }

  Future getUsers() async {
    var response = await _baseService.get<User>(User(), "users");
    if (response is List<User>) {
      print("okey");
    } else {
      print("hata");
    }
    return response;
  }
}
