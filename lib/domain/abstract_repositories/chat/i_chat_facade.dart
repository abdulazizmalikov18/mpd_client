import 'package:dartz/dartz.dart';
import 'package:orient_motors/domain/common/failure.dart';
import 'package:orient_motors/domain/models/chat/chat.dart';
import 'package:orient_motors/domain/models/success_model/success_model.dart';

abstract class IChatFacade {
  Future<Either<ResponseFailure, SuccessModel>> addWhoWrote({required ChatWroteModel request});

  Future<Either<ResponseFailure, ChatBlockModel>> blockUser({required ChatBlockModel request});

  Future<Either<ResponseFailure, SuccessModel>> changeUserStatus({required UserStatusModel request});

  Future<Either<ResponseFailure, SuccessModel>> checkIsOnline({required UserStatusModel request});

  Future<Either<ResponseFailure, List<ContactModel>>> getContacts();

  Future<Either<ResponseFailure, SuccessModel>> createChatMessage({required ChatMessageReq request});

  Future<Either<ResponseFailure, ChatRoomModel>> createRoom({required ChatRoomModel request});

  Future<Either<ResponseFailure, ChatRoomModel>> getRoom({required int id});

  Future<Either<ResponseFailure, ChatUserModel>> getUser({required int id});

  Future<Either<ResponseFailure, List<ChatMessageRes>>> getMessage({required int roomId});

  Future<Either<ResponseFailure, RoomExistModel>> getRoomExistCheck({required ChatWroteModel request});
}
