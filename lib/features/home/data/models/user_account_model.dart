// To parse this JSON data, do
//
//     final userAccountModel = userAccountModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_account_model.g.dart';

UserAccountModel userAccountModelFromJson(String str) =>
    UserAccountModel.fromJson(json.decode(str));

String userAccountModelToJson(UserAccountModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class UserAccountModel {
  @JsonKey(name: "username")
  final String username;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "surname")
  final String surname;
  @JsonKey(name: "lastname")
  final String lastname;
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "phone")
  final String phone;
  @JsonKey(name: "public_phone")
  final String publicPhone;
  @JsonKey(name: "pinfl")
  final String pinfl;
  @JsonKey(name: "birthday")
  final String birthday;
  @JsonKey(name: "gender")
  final String gender;
  @JsonKey(name: "bio")
  final String bio;
  @JsonKey(name: "lang")
  final String lang;
  @JsonKey(name: "status")
  final int status;
  @JsonKey(name: "is_related")
  final bool isRelated;
  @JsonKey(name: "login")
  final String login;
  @JsonKey(name: "region")
  final MainCat region;
  @JsonKey(name: "main_cat")
  final MainCat mainCat;
  @JsonKey(name: "avatar")
  final String avatar;
  @JsonKey(name: "qrcode")
  final String qrcode;
  @JsonKey(name: "has_password")
  final bool hasPassword;
  @JsonKey(name: "background_image")
  final String backgroundImage;
  @JsonKey(name: "is_subscribed_to_user")
  final bool isSubscribedToUser;

  const UserAccountModel({
    this.username = "",
    this.name = "",
    this.surname = "",
    this.lastname = "",
    this.email = "",
    this.phone = "",
    this.publicPhone = "",
    this.pinfl = "",
    this.birthday = "",
    this.gender = "",
    this.bio = "",
    this.lang = "",
    this.status = 0,
    this.isRelated = false,
    this.login = "",
    this.region = const MainCat(),
    this.mainCat = const MainCat(),
    this.avatar = "",
    this.qrcode = "",
    this.hasPassword = false,
    this.backgroundImage = "",
    this.isSubscribedToUser = false,
  });

  factory UserAccountModel.fromJson(Map<String, dynamic> json) =>
      _$UserAccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountModelToJson(this);
}

@JsonSerializable()
class MainCat {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;

  const MainCat({
    this.id = 0,
    this.name = "",
  });

  factory MainCat.fromJson(Map<String, dynamic> json) =>
      _$MainCatFromJson(json);

  Map<String, dynamic> toJson() => _$MainCatToJson(this);
}
