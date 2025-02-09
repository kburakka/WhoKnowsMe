import 'dart:convert';
import 'dart:io';

import 'package:my_app/core/model/base_header.dart';
import 'package:my_app/core/model/base_model.dart';
import 'package:http/http.dart' as http;

class BaseService {
  static const String FIREBASE_URL = "https://whoknowsme-8e365.firebaseio.com";

  static BaseService _instance = BaseService._private();
  BaseService._private();

  static BaseService get instance => _instance;

  Future get<T extends BaseModel>(T model, String child,
      {Header header}) async {
    // final response = await http.get("$FIREBASE_URL/$child.json?${header.key}=${header.value}");
    final response = await http.get("$FIREBASE_URL/$child.json");
    print("$FIREBASE_URL/$child.json");
    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body);

        if (jsonModel is Map) {
          if (jsonModel.length > 1) {
            List<T> list = [];
            jsonModel.forEach((key, value) {
              var newValue = value;
              newValue["key"] = key;
              list.add(model.fromJson(newValue));
            });
            return list;
          }
          return model.fromJson(jsonModel);
        } else if (jsonModel is List) {
          return jsonModel.map((value) {
            return model.fromJson(value);
          }).toList();
        }
        return jsonModel;
      case HttpStatus.unauthorized:
        // refresh token
        return response;
      // break;
      case HttpStatus.notFound:
        return "asd";
      default:
        return response;
    }
  }
}