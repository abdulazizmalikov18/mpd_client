// To parse this JSON data, do
//
//     final userInfoUpdateModel = userInfoUpdateModelFromJson(jsonString);

import 'dart:convert';
import 'package:dio/dio.dart';

UserInfoUpdateModel userInfoUpdateModelFromJson(String str) =>
    UserInfoUpdateModel.fromJson(json.decode(str));

String userInfoUpdateModelToJson(UserInfoUpdateModel data) =>
    json.encode(data.toJson());

class UserInfoUpdateModel {
  UserInfoUpdateModel({
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
    this.imageAvatar,
    this.mainCat,
    this.region,
    this.diplom,
    this.pinfl,
    this.course,
    this.education,
    this.currentPlace,
  });

  String? username;
  String? name;
  String? surname;
  String? lastname;
  String? email;
  String? phone;
  String? birthday;
  String? gender;
  String? bio;
  int? status;
  bool? isRelated;
  dynamic imageAvatar;
  int? mainCat;
  String? avatar;
  String? backgroundImage;
  dynamic region;
  String? diplom;
  String? pinfl;
  String? course;
  String? education;
  String? currentPlace;

  factory UserInfoUpdateModel.fromJson(Map<String, dynamic> json) =>
      UserInfoUpdateModel(
        username: json["username"],
        name: json["name"],
        surname: json["surname"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        birthday: json["birthday"],
        gender: json["gender"],
        bio: json["bio"],
        status: json["status"],
        isRelated: json["is_related"],
        imageAvatar: json["image_avatar"],
        mainCat: json["main_cat"],
        region: json["region"],
      );

  Map<String, dynamic> toJson() {
    final birthDayFormated = birthday?.split('.').reversed.join('-');
    Map<String, dynamic> map = {
      if (name != null) "name": name,
      if (surname != null) "surname": surname,
      if (lastname != null) "lastname": lastname,
      if (birthday != null) "birthday": birthDayFormated,
      if (bio != null && bio!.isNotEmpty) "bio": bio,
      if (gender != null) "gender": gender,
      if (mainCat != null) "main_cat": mainCat,
      if (region != null) "region": region,
      if (diplom != null && diplom!.isNotEmpty && !diplom!.startsWith('http')) 
        "diplom": MultipartFile.fromFileSync(diplom!, filename: diplom!.split('/').last),
      if (pinfl != null && pinfl!.isNotEmpty) "pinfl": pinfl,
      if (course != null && course!.isNotEmpty && !course!.startsWith('http')) 
        "course": MultipartFile.fromFileSync(course!, filename: course!.split('/').last),
      if (education != null && education!.isNotEmpty) "education": education,
      if (currentPlace != null && currentPlace!.isNotEmpty) "current_place": currentPlace,
    };
    return map;
  }
}
