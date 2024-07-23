import 'package:chopper/chopper.dart';
import 'package:dio/dio.dart';

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

 
  Future<List<PartValue>> get body2 async { 
    return [
        for (var image in images!) PartValueFile('images', await MultipartFile.fromFile(image)),
        for (var file in files!) PartValueFile('files', await MultipartFile.fromFile(file)),
        for (var screenshot in screenshots!) PartValueFile('screenshots', await MultipartFile.fromFile(screenshot)),



    ];
  }

  Future<Map<String, Object?>> get body async {
    return {
      if (aspectRatio != null) 'aspect_ratio': aspectRatio,
      if (action != null) 'action': action!.name,
      if (text != null) 'text': text,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (link != null) 'link': link,
      if (repost != null) 'repost': repost,
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
