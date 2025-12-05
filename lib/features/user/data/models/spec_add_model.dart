// To parse this JSON data, do
//
//     final specAddModel = specAddModelFromJson(jsonString);

import 'package:dio/dio.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';

import 'package:mpd_client/core/data/repository/storage_repository.dart';

// SpecAddModel specAddModelFromJson(String str) => SpecAddModel.fromJson(json.decode(str));

// String specAddModelToJson(SpecAddModel data) => json.encode(data.toJson());

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

  FormData? get toJsonDocument {
    final data = FormData.fromMap({
      'user': StorageRepository.getInt(StorageKeys.USERID),
      'type': 1,
    });
    if (avatar == null) return null;
    data.files.add(MapEntry('avatar', MultipartFile.fromFileSync(avatar!)));
    return data;
  }
}
