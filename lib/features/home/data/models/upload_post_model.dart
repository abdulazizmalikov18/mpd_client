// To parse this JSON data, do
//
//     final uploadPost = uploadPostFromJson(jsonString);

import 'package:dio/dio.dart';

class UploadPost {
  UploadPost({
    this.images,
    this.files,
    this.screenshots,
    this.aspectRatio,
    this.action,
    this.text,
    this.repost,
  });

  List<MultipartFile>? images;
  List<MultipartFile>? files;
  List<MultipartFile>? screenshots;
  String? aspectRatio;
  String? action;
  String? text;
  int? repost;

  Map<String, dynamic> toJson() => {
        "images": images == null
            ? []
            : List<MultipartFile>.from(images!.map((x) => x)),
        "files":
            files == null ? [] : List<MultipartFile>.from(files!.map((x) => x)),
        "screenshots": screenshots == null
            ? []
            : List<MultipartFile>.from(screenshots!.map((e) => e)),
        // "aspect_ratio": aspectRatio,
        "text": text,
      };
}
