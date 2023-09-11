import 'dart:convert';


UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.image,
    required this.id,
    required this.name,
    required this.email,
    this.notificationToken

  });

  String? image;
  String? id;
  String? name;
  String? email;
  String? notificationToken;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
        id: json["id"],
        image: json["image"],
        email: json["email"],
        name:json["name"],
        notificationToken:json["notificationToken"]??"",
      );


  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "image": image,
        "name": name,
        "email": email,
        "notificationToken": notificationToken,
      };

  UserModel copyWith({
    String? name,image,
  }) => UserModel(
      id: id,
      image: image?? image,
      email:  email,
      name: name?? name
  );
}