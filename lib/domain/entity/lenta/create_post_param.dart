import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mpd_client/infrastructure/services/media_comperesser.dart';
import 'package:path/path.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CreatePostParam {
  List<String>? images;
  List<String>? files;
  List<String>? screenshots;
  String? aspectRatio;
  CreatePostAction? action;
  String? text;
  String? address;
  String? phone;
  String? link;
  String? repost;

  Future<FormData> get body async {
    final formData = FormData.fromMap({
      if (aspectRatio != null) 'aspect_ratio': aspectRatio,
      if (action != null) 'action': action!.name,
      if (text != null) 'text': text,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (link != null) 'link': link,
      if (repost != null) 'repost': repost,
    });

    if (images != null) {
      formData.files.addAll([
        for (var image in images!) MapEntry('images', await MultipartFile.fromFile(image)),
      ]);
    }
    if (files != null) {
      formData.files.addAll([
        for (var file in files!) MapEntry('files', await MultipartFile.fromFile(file)),
      ]);
    }
    if (screenshots != null) {
      formData.files.addAll([
        for (var screenshot in screenshots!) MapEntry('screenshots', await MultipartFile.fromFile(screenshot)),
      ]);
    }
    return formData;
  }

  Future<Map<String, Object?>> newToJson() async {
    final List<MultipartFile> postImages = [];
    final List<MultipartFile> postVideos = [];
    final List<MultipartFile> postVideosScreenshot = [];
    if (images != null) {
      for (var image in images!) {
        final compressedImage = await MediaCompresser.compressAndTryCatchImage(image);

        postImages.add(MultipartFile.fromBytes(compressedImage, filename: basename(image)));
      }
    }
    if (files != null) {
      for (var file in files!) {
        // final length = file.file.lengthSync();

        // final compressedVideo =
        //     await MediaCompresser.compressVideo(file.file.path);
        final uint8list = await VideoThumbnail.thumbnailFile(
          video: file,
          imageFormat: ImageFormat.JPEG,
          maxWidth: 400, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
          quality: 75,
        );
        final noCompressed = await File(file).readAsBytes();

        postVideosScreenshot.add(await MultipartFile.fromFile(uint8list!, filename: uint8list));

        postVideos.add(MultipartFile.fromBytes(noCompressed, filename: basename(file)));
      }
    }

    return {
      "images": List<MultipartFile>.from(postImages.map((x) => x)),
      "files": List<MultipartFile>.from(postVideos.map((x) => x)),
      "screenshots": List<MultipartFile>.from(postVideosScreenshot.map((e) => e)),
      "text": text,
    };
  }

  CreatePostParam({
    this.images,
    this.files,
    this.screenshots,
    this.aspectRatio,
    this.action,
    this.text,
    this.address,
    this.phone,
    this.link,
    this.repost,
  });
}

enum CreatePostAction {
  new_avatar,
  new_duty,
}
