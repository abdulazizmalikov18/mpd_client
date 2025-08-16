import 'package:flutter/services.dart';
import 'package:mpd_client/core/utils/log_service.dart';

class ImageDownloader {
  static Future<Uint8List> dowloadImage(String url) async {
    try {
      final image = await NetworkAssetBundle(Uri.parse(url)).load(url);
      Uint8List bytes = image.buffer.asUint8List();
      return bytes;
    } catch (e) {
      Log.d(e);
      final image = await NetworkAssetBundle(
        Uri.parse("https://www.no5.com/media/1772/place-holder-image.png"),
      ).load("https://www.no5.com/media/1772/place-holder-image.png");
      Uint8List bytes = image.buffer.asUint8List();
      return bytes;
    }
  }
}
