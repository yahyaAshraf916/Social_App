class SocialUserModel {
  String? uId;
  String? email;
  String? name;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVertified;
  SocialUserModel({
    this.uId,
    this.email,
    this.name,
    this.phone,
    this.isEmailVertified,
    this.image,
    this.cover,
    this.bio,
  });
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    uId = json["uId"];
    email = json["email"];
    name = json["name"];
    phone = json["phone"];
    image = json["image"];
    cover = json["cover"];
    bio = json["bio"];
    isEmailVertified = json["isEmailVertified"];
  }
  Map<String, dynamic> toMap() {
    return {
      "uId": uId,
      "email": email,
      "name": name,
      "phone": phone,
      "image": image,
      "cover": cover,
      "bio": bio,
      "isEmailVertified": isEmailVertified
    };
  }
}
