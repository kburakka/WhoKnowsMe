class Qustion {
  String ingilizce;
  String turkce;
  int state;

  Qustion({this.ingilizce, this.turkce, this.state});

  Qustion.fromJson(Map<String, dynamic> json) {
    ingilizce = json['ingilizce'];
    turkce = json['turkce'];
    state = -1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingilizce'] = this.ingilizce;
    data['turkce'] = this.turkce;
    data['state'] = this.state;
    return data;
  }
}