// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel? userInfoModelFromJson(String str) =>
    UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel? data) => json.encode(data!.toJson());

class UserInfoModel {
  UserInfoModel({
    this.id,
    this.username,
    this.name,
    this.surname,
    this.lastname,
    this.email,
    this.phone,
    this.birthday,
    this.gender,
    this.bio,
    this.status,
    this.isRelated,
    this.region,
    this.mainCat,
    this.avatar,
    this.qrcode,
    this.hasPassword,
    this.backgroundImage,
  });

  int? id;
  String? username;
  String? name;
  String? surname;
  String? lastname;
  String? email;
  String? phone;
  DateTime? birthday;
  String? gender;
  String? bio;
  int? status;
  bool? isRelated;
  MainCat? region;
  MainCat? mainCat;
  String? avatar;
  String? qrcode;
  bool? hasPassword;
  String? backgroundImage;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        surname: json["surname"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        birthday:
            json["birthday"] != null ? DateTime.parse(json["birthday"]) : null,
        gender: json["gender"],
        bio: json["bio"],
        status: json["status"],
        isRelated: json["is_related"],
        region:
            json["region"] != null ? MainCat.fromJson(json["region"]) : null,
        mainCat: json["main_cat"] != null
            ? MainCat.fromJson(json["main_cat"])
            : null,
        avatar: json["avatar"],
        qrcode: json["qrcode"],
        hasPassword: json["has_password"],
        backgroundImage: json["background_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "surname": surname,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "birthday":
            "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "bio": bio,
        "status": status,
        "is_related": isRelated,
        "region": region!.toJson(),
        "main_cat": mainCat!.toJson(),
        "avatar": avatar,
        "qrcode": qrcode,
        "has_password": hasPassword,
        "background_image": backgroundImage
      };
}

class MainCat {
  MainCat({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory MainCat.fromJson(Map<String, dynamic> json) => MainCat(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
