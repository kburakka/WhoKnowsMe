import 'package:my_app/core/model/base_model.dart';

class Question extends BaseModel{
  String ingilizce;
  String turkce;
  int state;
  String key;

  Question({this.ingilizce, this.turkce, this.state});

  Question.fromJson(Map<String, dynamic> json) {
    ingilizce = json['ingilizce'];
    turkce = json['turkce'];
    if (json['state'] == null){
    state = -1;
    }else{
      state =json['state'];
    }
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingilizce'] = this.ingilizce;
    data['turkce'] = this.turkce;
    data['state'] = this.state;
    data['key'] = this.key;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return Question.fromJson(json);
  }
}