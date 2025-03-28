import 'dart:io';

import 'package:dio/dio.dart';

class CreateGroupModel {
  List<String>? chatUsers;
  String name;
  String? slugName;
  String? avatar;
  bool? isPrivate;
  bool? isUserToUser;

  CreateGroupModel({
    required this.name,
    this.chatUsers,
    this.slugName,
    this.avatar,
    this.isPrivate,
    this.isUserToUser,
  });

  FormData toJsonFormData() {
    final data = FormData.fromMap({
      "name": name,
      "chat_users": chatUsers ?? "",
      "slug_name": slugName ?? "",
      "is_private": isPrivate ?? "",
      "is_user_to_user": isUserToUser ?? "",
    });
    if (avatar != null) {
      data.files.add(
        MapEntry(
          "avatar",
          MultipartFile.fromFileSync(
            avatar!,
            filename: avatar!.split(Platform.pathSeparator).last,
          ),
        ),
      );
    }
    return data;
  }
}
