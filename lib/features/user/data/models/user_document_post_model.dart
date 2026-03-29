import 'package:dio/dio.dart';

class UserDocumentPostModel {
  final String filePath;
  final int? user;
  final int? type;
  final bool status;
  final int public;
  final bool professional;
  final String description;

  UserDocumentPostModel({
    required this.filePath,
    this.user,
    this.type,
    this.status = true,
    this.public = 0,
    this.professional = true,
    required this.description,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: filePath.split('/').last),
      if (user != null && user != 0) 'user': user,
      if (type != null && type != 0) 'type': type,
      'status': status,
      'public': public,
      'professional': professional,
      if (description.isNotEmpty) 'description': description,
    });
  }
}
