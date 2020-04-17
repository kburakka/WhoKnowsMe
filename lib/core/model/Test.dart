import 'package:my_app/core/model/base_model.dart';

class Test extends BaseModel{
  String answers;
  String date;
  String owner;
  String questions;

  Test({this.answers, this.date, this.owner, this.questions});

  Test.fromJson(Map<String, dynamic> json) {
    answers = json['answers'];
    date = json['date'];
    owner = json['owner'];
    questions = json['questions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answers'] = this.answers;
    data['date'] = this.date;
    data['owner'] = this.owner;
    data['questions'] = this.questions;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return Test.fromJson(json);
  }
}