// import 'package:flutter/foundation.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// // import 'package:video_compress/video_compress.dart';

// class MediaCompresser {
//   static Future<Uint8List> compressAndTryCatchImage(String path) async {
//     Uint8List? result;
//     try {
//       result = (await FlutterImageCompress.compressWithFile(
//         path,
//         quality: 50,
//         format: CompressFormat.heic,
//       ));
//       result ??= (await FlutterImageCompress.compressWithFile(
//         path,
//         quality: 50,
//         format: CompressFormat.jpeg,
//       ))!;
//     } on UnsupportedError catch (e) {
//       debugPrint(' Compress Heic error ---------------------->$e');
//       result = (await FlutterImageCompress.compressWithFile(
//         path,
//         quality: 50,
//         format: CompressFormat.jpeg,
//       ))!;
//     }
//     return result;
//   }

//   // static Future<Uint8List> compressVideo(String path) async {
//   //   Uint8List result = (await VideoCompress.getByteThumbnail(path,
//   //       quality: 50, // default(100)
//   //       position: -1 // default(-1)
//   //       ))!;

//   //   return result;
//   // }
// }
