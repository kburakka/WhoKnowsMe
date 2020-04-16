import 'package:my_app/core/model/base_model.dart';

class User extends BaseModel{
  String key;
  String deviceId;
  String name;

  User({this.key, this.deviceId, this.name});

  User.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    deviceId = json['deviceId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['deviceId'] = this.deviceId;
    data['name'] = this.name;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }
}