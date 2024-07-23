import 'package:mpd_client/domain/entity/chat/get_chat_entity.dart';
import 'package:mpd_client/domain/entity/chat/get_users_entity.dart';
import 'package:mpd_client/domain/entity/chat/send_message_entity.dart';
import 'package:mpd_client/domain/models/chat/chat_group.dart';
import 'package:mpd_client/domain/models/chat/chat_user.dart';
import 'package:mpd_client/domain/models/chat/create_group_model.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

import '../models/chat/base_message.dart';
import '../models/chat/chat_groups_reposone.dart';
import '../entity/chat/get_group_chat_entity.dart';

abstract interface class ChatRepository {
  const ChatRepository();

  Future<Either<Failure, ChatGroupsResponse>> getMyChat(GetGroupChatEntity param);

  Future<Either<Failure, BaseMessage>> getChats(GetChatEntity param);

  Future<Either<Failure, BaseMessage>> sendMessage(SendMessageEntity param);

  Future<Either<Failure, GenericPagination<ChatUserModel>>> getAllUsers(GetChatUserEntity params);

  Future<Either<Failure, ChatGroupModel>> createUserChat({required String username});

  Future<Either<Failure, ChatGroupModel>> createGroup(CreateGroupModel params);
}
