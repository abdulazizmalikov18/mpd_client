import 'dart:io';

import 'package:dio/dio.dart';

class SendMessageEntity {
  String text;
  File? file;
  String slugName;

  SendMessageEntity({
    required this.text,
    required this.slugName,
    this.file,
  });

  FormData toData() {
    final data = FormData.fromMap({
      "text": text,
    });
    if (file != null) {
      data.files.add(
        MapEntry(
          "file",
          MultipartFile.fromFileSync(
            file!.path,
            filename: file!.path.split(Platform.pathSeparator).last,
          ),
        ),
      );
    }
    return data;
  }
}
