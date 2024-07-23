import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mpd_client/domain/entity/chat/get_group_chat_entity.dart';
import 'package:mpd_client/domain/entity/chat/get_users_entity.dart';
import 'package:mpd_client/domain/entity/chat/send_message_entity.dart';
import 'package:mpd_client/domain/models/chat/chat_group.dart';
import 'package:mpd_client/domain/models/chat/chat_user.dart';
import 'package:mpd_client/domain/models/chat/create_group_model.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/infrastructure/services/error_handle.dart';
import 'package:mpd_client/infrastructure/services/response_handler.dart';

import '../../domain/entity/chat/get_chat_entity.dart';
import '../../domain/models/chat/base_message.dart';
import '../../domain/models/chat/chat_groups_reposone.dart';

abstract interface class ChatService {
  const ChatService();

  factory ChatService.create() => ChatServiceImpl._();

  Future<ResponseHandler<ChatGroupsResponse>> getGroupChats(GetGroupChatEntity param);

  Future<ResponseHandler<BaseMessage>> getChats(GetChatEntity param);

  Future<ResponseHandler<BaseMessage>> sendMessage(SendMessageEntity param);

  Future<ResponseHandler<GenericPagination<ChatUserModel>>> getAllUsers(GetChatUserEntity params);

  Future<ResponseHandler<ChatGroupModel>> createUserToUser({required String username});

  Future<ResponseHandler<ChatGroupModel>> groupCreate(CreateGroupModel params);
}

class ChatServiceImpl extends ChatService {
  final ErrorHandle _handle = ErrorHandle();

  ChatServiceImpl._();

  @override
  Future<ResponseHandler<ChatGroupsResponse>> getGroupChats(GetGroupChatEntity param) async {
    return _handle.apiCantrol(
      request: (client) {
        return client.get(
          "SMMS/api/v1.0/chat/chat-group/",
          // ApiConstants.apiGetGroupChats,
          queryParameters: param.toJson(),
        );
      },
      body: (response) {
        return ResponseHandler()
          ..setData(
            ChatGroupsResponse.fromJson(response),
          );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseMessage>> getChats(GetChatEntity param) {
    return _handle.apiCantrol(
      request: (client) {
        return client.get(
          "SMMS/api/v1.0/chat/${param.groupSlug}/chat/",
          // ApiConstants.apiGetChats(param: param.groupSlug),
          queryParameters: param.toJson(),
        );
      },
      body: (response) {
        return ResponseHandler()
          ..setData(
            BaseMessage.fromJson(response),
          );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseMessage>> sendMessage(SendMessageEntity param) {
    return _handle.apiCantrol(
      request: (client) {
        return client.post(
          "SMMS/api/v1.0/chat/${param.slugName}/chat/",
          // ApiConstants.apiGetChats(param: param.slugName),
          data: param.toData(),
        );
      },
      body: (response) {
        return ResponseHandler()..setData(BaseMessage.fromJson(response));
      },
    );
  }

  @override
  Future<ResponseHandler<GenericPagination<ChatUserModel>>> getAllUsers(GetChatUserEntity params) {
    return _handle.apiCantrol(
      request: (client) {
        return client.get(
          "SMMS/api/v1.0/chat/users/",
          queryParameters: {
            "limit": params.limit,
            "offset": params.offset,
            "search": params.search,
          },
        );
      },
      body: (response) {
        return ResponseHandler()
          ..setData(
            GenericPagination.fromJson(
              response,
              (users) => ChatUserModel.fromJson(jsonDecode(jsonEncode(users))),
            ),
          );
      },
    );
  }

  @override
  Future<ResponseHandler<ChatGroupModel>> createUserToUser({required String username}) async {
    return _handle.apiCantrol(
      request: (client) {
        return client.post("SMMS/api/v1.0/chat/chat-group/user_to_user/", data: FormData.fromMap({"username": username}));
      },
      body: (response) {
        return ResponseHandler()
          ..setData(
            ChatGroupModel.fromJson(response),
          );
      },
    );
  }

  @override
  Future<ResponseHandler<ChatGroupModel>> groupCreate(CreateGroupModel params) async {
    return _handle.apiCantrol(
      request: (client) {
        return client.post(
          "SMMS/api/v1.0/chat/chat-group/",
          data: params.toJsonFormData(),
        );
      },
      body: (response) {
        return ResponseHandler()
          ..setData(
            ChatGroupModel.fromJson(response),
          );
      },
    );
  }
}
