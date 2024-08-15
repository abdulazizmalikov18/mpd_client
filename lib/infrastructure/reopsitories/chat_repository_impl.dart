import 'package:mpd_client/domain/abstract_repo/chat_repository.dart';
import 'package:mpd_client/domain/entity/chat/get_chat_entity.dart';
import 'package:mpd_client/domain/entity/chat/get_group_chat_entity.dart';
import 'package:mpd_client/domain/entity/chat/get_users_entity.dart';
import 'package:mpd_client/domain/entity/chat/send_message_entity.dart';
import 'package:mpd_client/domain/models/chat/chat_group.dart';
import 'package:mpd_client/domain/models/chat/chat_user.dart';
import 'package:mpd_client/domain/models/chat/create_group_model.dart';
import 'package:mpd_client/domain/models/chat/message.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/infrastructure/apis/chat_service.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatService _remote;

  const ChatRepositoryImpl({
    required ChatService remote,
  }) : _remote = remote;

  @override
  Future<Either<Failure, GenericPagination<ChatGroupModel>>> getGroups(GetGroupChatEntity param) async {
    try {
      final response = await _remote.getGroups(param);
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
  Future<Either<Failure, GenericPagination<MessageModel>>> getMessages(GetChatEntity param) async {
    try {
      final response = await _remote.getMessages(param);
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
  Future<Either<Failure, bool>> readAllMessage(String groupSlug) async {
    try {
      final response = await _remote.readAllMessage(groupSlug);
      return Right(response);
    } catch (e) {
      return Left(ServerNotFoundFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GenericPagination<MessageModel>>> sendMessage(SendMessageEntity param) async {
    try {
      final response = await _remote.sendMessage(param);
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
