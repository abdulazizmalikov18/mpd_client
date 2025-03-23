
import 'package:dio/dio.dart';

class DocumentPutParam {
  final String file;
  final int type;
  final bool? status;
  final bool? professional;
  final int? public;
  final String? description;

  const DocumentPutParam({
    required this.file,
    required this.type,
    this.status,
    this.public,
    this.professional,
    this.description,
  });

  FormData get body {
    final formData = FormData.fromMap({
      "type": type,
      if (status != null) "status": status,
      if (public != null) "public": public,
      if (professional != null) "professional": professional,
      if (description != null) "description": description,
    });
    return formData;
  }
}
