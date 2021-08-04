class Usermodel {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? uid;
  String? image;
  String? bio;
  String? cover;
  bool? isverficatedemail;

  Usermodel(
      {this.name,
      this.email,
      this.image,
      this.bio,
      this.cover,
      this.password,
      this.phone,
      this.uid,
      this.isverficatedemail});

  Usermodel.fromJson(Map<String, dynamic>? json) {
    name = json!["name"];
    email = json["email"];
    image = json["image"];
    bio = json["bio"];
    cover = json["cover"];
    password = json["password"];
    phone = json["phone"];
    uid = json["uid"];
    isverficatedemail = json["isverficatedemail"];
  }

  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'bio': bio,
      'image': image,
      'cover': cover,
      'phone': phone,
      'isverficatedemail': isverficatedemail,
      'uid': uid,
    };
  }
}
