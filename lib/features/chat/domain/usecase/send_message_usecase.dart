// import 'package:dwed_client/core/exceptions/failures.dart';
// import 'package:dwed_client/core/usecases/usecase.dart';
// import 'package:dwed_client/core/utils/either.dart';
// import 'package:dwed_client/features/chat/domain/entity/send_message_entity.dart';

// import '../../../../../domain/models/chat/base_message.dart';
// import '../../../../../domain/abstract_repo/chat_repository.dart';

// class SendMessageUseCase extends UseCase<BaseMessage, SendMessageEntity> {
//   final ChatRepository repository;

//   const SendMessageUseCase({
//     required this.repository,
//   });

//   @override
//   Future<Either<Failure, BaseMessage>> call(SendMessageEntity params) async {
//     return await repository.sendMessage(params);
//   }
// }
