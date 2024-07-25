import 'package:dio/dio.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';

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
    try {
    Log.e(images!.length.toString());
    Log.e(screenshots!.length.toString());
    Log.e(files!.length.toString());
    final imagesPart = images == null ? [] : images!.map((image) => MultipartFile.fromFileSync(image)).toList();
    final filesPart = images == null ? [] : files!.map((files) => MultipartFile.fromFileSync(files)).toList();
    final screenshotsPart = images == null ? [] : screenshots!.map((screenshots) => MultipartFile.fromFileSync(screenshots)).toList();

    final formData = FormData.fromMap({
      if (aspectRatio != null) 'aspect_ratio': aspectRatio,
      if (action != null) 'action': action!.name,
      if (text != null) 'text': text,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (link != null) 'link': link,
      if (repost != null) 'repost': repost,
      if (images != null) 'images': imagesPart,
      if (screenshots != null) 'screenshots': screenshotsPart,
      if (files != null) 'files': filesPart,
    });
    return formData;
    }catch(e, s) {
      Log.e(e.toString());
      Log.e(s.toString());
      return  FormData.fromMap({});
    }
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
