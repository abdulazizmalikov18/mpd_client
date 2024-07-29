import 'package:dio/dio.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';

class CreatePostParam {
  List<String> images;
  List<String> files;
  String? aspectRatio;
  CreatePostAction? action;
  String? text;
  String? address;
  String? phone;
  String? link;
  String? repost;

  Future<FormData> get body async {
    try {
      Log.e(images.length.toString());
      Log.e(files.length.toString());
      final imagesPart = images.map((image) async => await MultipartFile.fromFile(image)).toList();
      final filesPart = files.map((files) async => await MultipartFile.fromFile(files)).toList();
      Log.e(filesPart.length.toString());
      final formData = FormData.fromMap({
        if (aspectRatio != null) 'aspect_ratio': aspectRatio,
        if (action != null) 'action': action!.name,
        if (text != null) 'text': text,
        if (address != null) 'address': address,
        if (phone != null) 'phone': phone,
        if (link != null) 'link': link,
        if (repost != null) 'repost': repost,
        // if (images.isNotEmpty) 'images': imagesPart,
        // if (files.isNotEmpty) 'files': filesPart,
      });
      for (final file in filesPart) {
        formData.files.add(MapEntry('files', await file));
      }
      for (final image in imagesPart) {
        formData.files.add(MapEntry('images', await image));
      }
      return formData;
    } catch (e, s) {
      Log.e(e.toString());
      Log.e(s.toString());
      return FormData.fromMap({});
    }
  }

  CreatePostParam({
    this.images = const [],
    this.files = const [],
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
