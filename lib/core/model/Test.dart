import 'package:my_app/core/model/Question.dart';
import 'package:my_app/core/model/base_model.dart';

class Test extends BaseModel{
  String date;
  String owner;
  String id;
  String name;

  List<Question> questions;

  Test({this.id,this.date, this.owner, this.questions});

  Test.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    owner = json['owner'];
    name = json['name'];
    id = json['id'];
    if (json['questions'] != null) {
      questions = new List<Question>();
      json['questions'].forEach((v) {
        questions.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['owner'] = this.owner;
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return Test.fromJson(json);
  }
}