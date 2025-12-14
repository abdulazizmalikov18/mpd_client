// To parse this JSON data, do
//
//     final specAddModel = specAddModelFromJson(jsonString);

// SpecAddModel specAddModelFromJson(String str) => SpecAddModel.fromJson(json.decode(str));

// String specAddModelToJson(SpecAddModel data) => json.encode(data.toJson());

import 'package:dio/dio.dart';

class SpecAddModel {
  // final int position;
  final int specCat;
  final int job;
  final String? avatar;
  final String? bio;

  SpecAddModel({
    // required this.position,
    required this.specCat,
    required this.job,
    this.avatar,
    this.bio,
  });

  factory SpecAddModel.fromJson(Map<String, dynamic> json) => SpecAddModel(
    // position: (json['position'] as num).toInt(),
    specCat: (json['spec_cat'] as num).toInt(),
    job: (json['job'] as num).toInt(),
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    bio: json['bio'] != null ? json['bio'] as String : null,
  );

  Map<String, dynamic> toJson() => {
    // 'position': position,
    'spec_cat': specCat,
    'job': job,
    'avatar': avatar,
    'bio': bio,
  };

  FormData get toJsonDocument {
    final data = FormData.fromMap({
      'spec_cat': specCat,
      'job': job,
      'bio': bio,
    });

    if (avatar != null && avatar!.isNotEmpty) {
      data.files.add(MapEntry('avatar', MultipartFile.fromFileSync(avatar!)));
    }
    return data;
  }
}
