import 'package:dio/dio.dart';
import 'package:mpd_client/core/exceptions/exceptions.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/pagination/models/generic_pagination.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/features/chat/data/entity/get_chat_entity.dart';
import 'package:mpd_client/features/chat/data/entity/get_group_chat_entity.dart';
import 'package:mpd_client/features/chat/data/entity/get_users_entity.dart';
import 'package:mpd_client/features/chat/data/entity/send_message_entity.dart';
import 'package:mpd_client/features/chat/data/repo/chat_repository.dart';
import 'package:mpd_client/features/chat/data/service/chat_service.dart';
import 'package:mpd_client/features/chat/domain/models/chat_group.dart';
import 'package:mpd_client/features/chat/domain/models/chat_user.dart';
import 'package:mpd_client/features/chat/domain/models/create_group_model.dart';
import 'package:mpd_client/features/chat/domain/models/message.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatService _remote;

  const ChatRepositoryImpl({
    required ChatService remote,
  }) : _remote = remote;

  @override
  Future<Either<Failure, GenericPagination<ChatGroupModel>>> getGroups(
      GetGroupChatEntity param) async {
    try {
      final response = await _remote.getGroups(param);
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, GenericPagination<MessageModel>>> getMessages(
      GetChatEntity param) async {
    try {
      final response = await _remote.getMessages(param);
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> readAllMessage(String groupSlug) async {
    try {
      final response = await _remote.readAllMessage(groupSlug);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, GenericPagination<MessageModel>>> sendMessage(
      SendMessageEntity param) async {
    try {
      final response = await _remote.sendMessage(param);
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, GenericPagination<ChatUserModel>>> getAllUsers(
      GetChatUserEntity params) async {
    try {
      final response = await _remote.getAllUsers(params);
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ChatGroupModel>> createUserChat(
      {required String username}) async {
    try {
      final response = await _remote.createUserToUser(username: username);
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ChatGroupModel>> createGroup(
      CreateGroupModel params) async {
    try {
      final response = await _remote.groupCreate(params);
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
