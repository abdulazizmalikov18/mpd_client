import 'package:mpd_client/domain/entity/chat/get_chat_entity.dart';
import 'package:mpd_client/domain/entity/chat/get_users_entity.dart';
import 'package:mpd_client/domain/entity/chat/send_message_entity.dart';
import 'package:mpd_client/domain/models/chat/chat_group.dart';
import 'package:mpd_client/domain/models/chat/chat_user.dart';
import 'package:mpd_client/domain/models/chat/create_group_model.dart';
import 'package:mpd_client/domain/models/chat/message.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

import '../entity/chat/get_group_chat_entity.dart';

abstract interface class ChatRepository {
  const ChatRepository();

  Future<Either<Failure, GenericPagination<ChatGroupModel>>> getGroups(GetGroupChatEntity param);

  Future<Either<Failure, GenericPagination<MessageModel>>> getMessages(GetChatEntity param);
  Future<Either<Failure, bool>> readAllMessage(String groupSlug);
  Future<Either<Failure, GenericPagination<MessageModel>>> sendMessage(SendMessageEntity param);

  Future<Either<Failure, GenericPagination<ChatUserModel>>> getAllUsers(GetChatUserEntity params);

  Future<Either<Failure, ChatGroupModel>> createUserChat({required String username});

  Future<Either<Failure, ChatGroupModel>> createGroup(CreateGroupModel params);
}
