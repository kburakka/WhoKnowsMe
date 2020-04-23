import 'package:my_app/core/model/Test.dart';
import 'package:my_app/core/model/base_model.dart';

class FilterTest extends BaseModel{
  Test test;

  FilterTest({this.test});

  FilterTest.fromJson(Map<String, dynamic> json) {
    if (json.keys.length > 0){
      test = Test.fromJson(json[json.keys.first]);
    }
  }

  @override
  fromJson(Map<String, dynamic>json) {
      return FilterTest.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return null;
  }
}