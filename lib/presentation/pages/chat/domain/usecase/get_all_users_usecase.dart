// import 'package:dwed_client/core/exceptions/failures.dart';
// import 'package:dwed_client/core/usecases/usecase.dart';
// import 'package:dwed_client/core/utils/either.dart';
// import 'package:dwed_client/features/common/pagination/models/generic_pagination.dart';
// import 'package:dwed_client/features/chat/data/models/chat_user.dart';
// import 'package:dwed_client/features/chat/domain/entity/get_users_entity.dart';
// import 'package:dwed_client/features/chat/domain/repository/chat_repository.dart';

// class ChatGetAllUsers extends UseCase<GenericPagination<ChatUser>, GetChatUserEntity> {
//   final ChatRepository repository;

//   const ChatGetAllUsers({required this.repository});

//   @override
//   Future<Either<Failure, GenericPagination<ChatUser>>> call(GetChatUserEntity params) {
//     return repository.getAllUsers(params);
//   }
// }
