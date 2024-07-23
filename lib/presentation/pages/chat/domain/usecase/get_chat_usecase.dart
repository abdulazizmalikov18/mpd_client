// import 'package:dwed_client/core/exceptions/failures.dart';
// import 'package:dwed_client/core/usecases/usecase.dart';
// import 'package:dwed_client/core/utils/either.dart';
// import 'package:dwed_client/features/chat/domain/entity/get_chat_entity.dart';

// import '../../../../../domain/models/chat/base_message.dart';
// import '../../../../../domain/abstract_repo/chat_repository.dart';

// class GetChatUseCase extends UseCase<BaseMessage, GetChatEntity> {
//   final ChatRepository repository;

//   const GetChatUseCase({
//     required this.repository,
//   });

//   @override
//   Future<Either<Failure, BaseMessage>> call(GetChatEntity params) async => repository.getChats(params);
// }
