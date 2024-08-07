import 'package:mpd_client/domain/abstract_repo/chat_repository.dart';
import 'package:mpd_client/domain/entity/chat/get_chat_entity.dart';
import 'package:mpd_client/domain/entity/chat/get_group_chat_entity.dart';
import 'package:mpd_client/domain/entity/chat/get_users_entity.dart';
import 'package:mpd_client/domain/entity/chat/send_message_entity.dart';
import 'package:mpd_client/domain/models/chat/chat_group.dart';
import 'package:mpd_client/domain/models/chat/chat_user.dart';
import 'package:mpd_client/domain/models/chat/create_group_model.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/infrastructure/apis/chat_service.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

import '../../domain/models/chat/base_message.dart';
import '../../domain/models/chat/chat_groups_reposone.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatService _remote;

  const ChatRepositoryImpl({
    required ChatService remote,
  }) : _remote = remote;

  @override
  Future<Either<Failure, ChatGroupsResponse>> getMyChat(GetGroupChatEntity param) async {
    try {
      final response = await _remote.getGroupChats(param);
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } catch (e) {
      return Left(ServerNotFoundFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseMessage>> getChats(GetChatEntity param) async {
    try {
      final response = await _remote.getChats(param);
      // if (!await _connectionInfo.isConnected) {
      //   return Left(const NetworkFailure(errorMessage: 'Connection failure'));
      // }
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } catch (e) {
      return Left(ServerNotFoundFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseMessage>> sendMessage(SendMessageEntity param) async {
    try {
      final response = await _remote.sendMessage(param);
      // if (!await _connectionInfo.isConnected) {
      //   return Left(const NetworkFailure(errorMessage: 'Connection failure'));
      // }
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } catch (e) {
      return Left(ServerNotFoundFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GenericPagination<ChatUserModel>>> getAllUsers(GetChatUserEntity params) async {
    try {
      final response = await _remote.getAllUsers(params);
      // if (!await _connectionInfo.isConnected) {
      //   return Left(const NetworkFailure(errorMessage: 'Connection failure'));
      // }
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } catch (e) {
      return Left(ServerNotFoundFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatGroupModel>> createUserChat({required String username}) async {
    try {
      final response = await _remote.createUserToUser(username: username);
      // if (!await _connectionInfo.isConnected) {
      //   return Left(const NetworkFailure(errorMessage: 'Connection failure'));
      // }
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } catch (e) {
      return Left(ServerNotFoundFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatGroupModel>> createGroup(CreateGroupModel params) async {
    try {
      final response = await _remote.groupCreate(params);
      // if (!await _connectionInfo.isConnected) {
      //   return Left(const NetworkFailure(errorMessage: 'Connection failure'));
      // }
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } catch (e) {
      return Left(ServerNotFoundFailure(errorMessage: e.toString()));
    }
  }
}
