class Messagemodel {
  String? date;
  String? reciverid;
  String? text;

  Messagemodel({this.date, this.reciverid, this.text});

  Messagemodel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    reciverid = json['reciverid'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['reciverid'] = this.reciverid;
    data['text'] = this.text;
    return data;
  }
}
