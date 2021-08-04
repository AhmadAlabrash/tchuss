class Postmodel {
  String? uid;
  String? name;
  String? date;
  String? image;
  String? content;

  String? postimage;

  Postmodel(
      {this.name,
      this.content,
      this.image,
      this.postimage,
      this.uid,
      this.date});

  Postmodel.fromJson(Map<String, dynamic>? json) {
    name = json!["name"];
    date = json["date"];
    image = json["image"];
    postimage = json["postimage"];
    content = json["content"];

    uid = json["uid"];
  }

  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'date': date,
      'postimage': postimage,
      'content': content,
      'image': image,
      'uid': uid,
    };
  }
}
