import 'package:my_app/core/model/base_model.dart';

class Result extends BaseModel{
  String date;
  String fillerId;
  int score;
  String testId;

  Result({this.date, this.fillerId, this.score, this.testId});

  Result.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    fillerId = json['fillerId'];
    score = json['score'];
    testId = json['testId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['fillerId'] = this.fillerId;
    data['score'] = this.score;
    data['testId'] = this.testId;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return Result.fromJson(json);
  }
}