// import 'package:dwed_client/core/exceptions/failures.dart';
// import 'package:dwed_client/core/usecases/usecase.dart';
// import 'package:dwed_client/core/utils/either.dart';
// import 'package:dwed_client/features/chat/domain/entity/get_group_chat_entity.dart';
// import 'package:dwed_client/features/chat/domain/repository/chat_repository.dart';

// import '../../../../../domain/models/chat/chat_groups_reposone.dart';

// class GetGroupChatUseCase extends UseCase<ChatGroupsResponse, GetGroupChatEntity> {
//   final ChatRepository repository;

//   const GetGroupChatUseCase({
//     required this.repository,
//   });

//   @override
//   Future<Either<Failure, ChatGroupsResponse>> call(GetGroupChatEntity params) async => repository.getMyChat(params);
// }
