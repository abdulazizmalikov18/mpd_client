import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/exceptions/error_handle_new.dart';
import 'package:mpd_client/core/pagination/models/generic_pagination.dart';
import 'package:mpd_client/features/chat/data/entity/get_chat_entity.dart';
import 'package:mpd_client/features/chat/data/entity/get_group_chat_entity.dart';
import 'package:mpd_client/features/chat/data/entity/get_users_entity.dart';
import 'package:mpd_client/features/chat/data/entity/send_message_entity.dart';
import 'package:mpd_client/features/chat/data/service/response_handler.dart';
import 'package:mpd_client/features/chat/domain/models/chat_group.dart';
import 'package:mpd_client/features/chat/domain/models/chat_user.dart';
import 'package:mpd_client/features/chat/domain/models/create_group_model.dart';
import 'package:mpd_client/features/chat/domain/models/message.dart';

abstract interface class ChatService {
  const ChatService();

  factory ChatService.create() => ChatServiceImpl._();

  Future<ResponseHandler<GenericPagination<ChatGroupModel>>> getGroups(
    GetGroupChatEntity param,
  );

  Future<ResponseHandler<GenericPagination<MessageModel>>> getMessages(
    GetChatEntity param,
  );
  Future<bool> readAllMessage(String groupSlug);

  Future<ResponseHandler<GenericPagination<MessageModel>>> sendMessage(
    SendMessageEntity param,
  );

  Future<ResponseHandler<GenericPagination<ChatUserModel>>> getAllUsers(
    GetChatUserEntity params,
  );

  Future<ResponseHandler<ChatGroupModel>> createUserToUser({
    required String username,
  });

  Future<ResponseHandler<ChatGroupModel>> groupCreate(CreateGroupModel params);

  Future<ResponseHandler<bool>> reportMessage({
    required int messageId,
    required String reason,
  });

  Future<ResponseHandler<bool>> blockUser({
    required String username,
  });
}

class ChatServiceImpl extends ChatService {
  final ErrorHandleNew _handle = ErrorHandleNew();

  ChatServiceImpl._();

  @override
  Future<ResponseHandler<GenericPagination<ChatGroupModel>>> getGroups(
    GetGroupChatEntity param,
  ) async {
    return _handle.apiCantrol(
      request: (client) {
        return client.get(
          "SMMS/api/v1.0/chat/chat-group/",
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
          queryParameters: param.toJson(),
        );
      },
      body: (response) {
        return ResponseHandler()..setData(
          GenericPagination.fromJson(
            response,
            (p0) => ChatGroupModel.fromJson(p0 as Map<String, dynamic>),
          ),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<GenericPagination<MessageModel>>> getMessages(
    GetChatEntity param,
  ) {
    return _handle.apiCantrol(
      request: (client) {
        return client.get(
          "SMMS/api/v1.0/chat/${param.groupSlug}/chat/",
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
          queryParameters: param.toJson(),
        );
      },
      body: (response) {
        return ResponseHandler()..setData(
          GenericPagination.fromJson(
            response,
            (p0) => MessageModel.fromJson(p0 as Map<String, dynamic>),
          ),
        );
      },
    );
  }

  @override
  Future<bool> readAllMessage(String groupSlug) {
    return _handle.apiCantrol(
      request: (client) {
        return client.post(
          "/SMMS/api/v1.0/chat/$groupSlug/chat/mark_all_message/",
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) => true,
    );
  }

  @override
  Future<ResponseHandler<GenericPagination<MessageModel>>> sendMessage(
    SendMessageEntity param,
  ) {
    return _handle.apiCantrol(
      request: (client) {
        return client.post(
          "SMMS/api/v1.0/chat/${param.slugName}/chat/",
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
          data: param.toData(),
        );
      },
      body: (response) {
        return ResponseHandler()..setData(
          GenericPagination.fromJson(
            response,
            (p0) => MessageModel.fromJson(p0 as Map<String, dynamic>),
          ),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<GenericPagination<ChatUserModel>>> getAllUsers(
    GetChatUserEntity params,
  ) {
    return _handle.apiCantrol(
      request: (client) {
        return client.get(
          "SMMS/api/v1.0/chat/users/",
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
          queryParameters: {
            "limit": params.limit,
            "offset": params.offset,
            "search": params.search,
          },
        );
      },
      body: (response) {
        return ResponseHandler()..setData(
          GenericPagination.fromJson(
            response,
            (users) => ChatUserModel.fromJson(jsonDecode(jsonEncode(users))),
          ),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<ChatGroupModel>> createUserToUser({
    required String username,
  }) async {
    return _handle.apiCantrol(
      request: (client) {
        return client.post(
          "SMMS/api/v1.0/chat/chat-group/user_to_user/",
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
          data: FormData.fromMap({"username": username}),
        );
      },
      body: (response) {
        return ResponseHandler()..setData(ChatGroupModel.fromJson(response));
      },
    );
  }

  @override
  Future<ResponseHandler<ChatGroupModel>> groupCreate(
    CreateGroupModel params,
  ) async {
    return _handle.apiCantrol(
      request: (client) {
        return client.post(
          "SMMS/api/v1.0/chat/chat-group/",
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
          data: params.toJsonFormData(),
        );
      },
      body: (response) {
        return ResponseHandler()..setData(ChatGroupModel.fromJson(response));
      },
    );
  }

  @override
  Future<ResponseHandler<bool>> reportMessage({
    required int messageId,
    required String reason,
  }) async {
    return _handle.apiCantrol(
      request: (client) {
        return client.post(
          "SMMS/api/v1.0/chat/message/$messageId/report/",
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
          data: FormData.fromMap({'reason': reason}),
        );
      },
      body: (response) {
        return ResponseHandler()..setData(true);
      },
    );
  }

  @override
  Future<ResponseHandler<bool>> blockUser({
    required String username,
  }) async {
    return _handle.apiCantrol(
      request: (client) {
        return client.post(
          "UMS/api/v1.0/account/block-user/",
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
          data: FormData.fromMap({'username': username}),
        );
      },
      body: (response) {
        return ResponseHandler()..setData(true);
      },
    );
  }
}
