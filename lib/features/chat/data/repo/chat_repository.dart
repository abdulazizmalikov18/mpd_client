import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/pagination/models/generic_pagination.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/features/chat/data/entity/get_chat_entity.dart';
import 'package:mpd_client/features/chat/data/entity/get_group_chat_entity.dart';
import 'package:mpd_client/features/chat/data/entity/get_users_entity.dart';
import 'package:mpd_client/features/chat/data/entity/send_message_entity.dart';
import 'package:mpd_client/features/chat/domain/models/chat_group.dart';
import 'package:mpd_client/features/chat/domain/models/chat_user.dart';
import 'package:mpd_client/features/chat/domain/models/create_group_model.dart';
import 'package:mpd_client/features/chat/domain/models/message.dart';

abstract interface class ChatRepository {
  const ChatRepository();

  Future<Either<Failure, GenericPagination<ChatGroupModel>>> getGroups(
    GetGroupChatEntity param,
  );

  Future<Either<Failure, GenericPagination<MessageModel>>> getMessages(
    GetChatEntity param,
  );
  Future<Either<Failure, bool>> readAllMessage(String groupSlug);
  Future<Either<Failure, GenericPagination<MessageModel>>> sendMessage(
    SendMessageEntity param,
  );

  Future<Either<Failure, GenericPagination<ChatUserModel>>> getAllUsers(
    GetChatUserEntity params,
  );

  Future<Either<Failure, ChatGroupModel>> createUserChat({
    required String username,
  });

  Future<Either<Failure, ChatGroupModel>> createGroup(CreateGroupModel params);

  Future<Either<Failure, bool>> reportMessage({
    required int messageId,
    required String reason,
  });

  Future<Either<Failure, bool>> blockUser({
    required String username,
  });
}
