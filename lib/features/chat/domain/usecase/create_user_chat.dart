// import 'package:dwed_client/core/exceptions/failures.dart';
// import 'package:dwed_client/core/usecases/usecase.dart';
// import 'package:dwed_client/core/utils/either.dart';
// import 'package:dwed_client/features/chat/data/models/chat_group.dart';
// import 'package:dwed_client/features/chat/domain/repository/chat_repository.dart';

// class CreateUserChatUseCase extends UseCase<ChatGroup, String> {
//   final ChatRepository repository;

//   const CreateUserChatUseCase({
//     required this.repository,
//   });
//   @override
//   Future<Either<Failure, ChatGroup>> call(String params) {
//     return repository.createUserChat(username: params);
//   }
// }
