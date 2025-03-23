// To parse this JSON data, do
//
//     final userImageUpdate = userImageUpdateFromJson(jsonString);

import 'dart:io';

import 'package:dio/dio.dart';

class UserImageUpdate {
  UserImageUpdate({
    required this.image,
    this.main,
    this.businessAva,
  });

  final String image;
  final bool? main;
  final bool? businessAva;

  factory UserImageUpdate.fromJson(Map<String, dynamic> json) =>
      UserImageUpdate(
        image: json["image"],
        main: json["main"],
        businessAva: json["business_ava"],
      );

  FormData toJson(bool isBackImage) {
    final data = FormData.fromMap({
      "image": image,
      "main": main,
      if (!isBackImage) "business_ava": businessAva,
    });
    final imageBinary = MultipartFile.fromFileSync(
      image,
      filename: image.split(Platform.pathSeparator).last,
    );
    data.files.add(MapEntry('image', imageBinary));
    return data;
  }
}
