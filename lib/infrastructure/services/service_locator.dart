import 'package:get_it/get_it.dart';
import 'package:mpd_client/application/auth/auth_bloc.dart';
import 'package:mpd_client/infrastructure/apis/account_service.dart';
import 'package:mpd_client/infrastructure/services/api_service.dart';

final serviceLocator = GetIt.I;

void setupLocator() {
  // Dio Setting Objects
  serviceLocator.registerFactory(DioSettings.new);
  // Auth Objects
  serviceLocator.registerSingleton(AuthBloc());
  serviceLocator.registerSingleton<AccountService>(AccountService.create());
  // // serviceLocator.registerSingleton(Debouncer(milliseconds: 300));
  //
  // // Chat Objects
  // _chatRegister();
  //
  // //Account
  // _account();
  //
  // // Lenta Objects
  // _lenta();
}
//
// void _chatRegister() {
//   serviceLocator.registerSingleton<ChatRemoteDataSource>(
//     ChatRemoteDataSourceImpl(),
//   );
//   serviceLocator.registerSingleton<ChatRepository>(
//     ChatRepositoryImpl(
//       remoteDataSource: serviceLocator(),
//       // connectionInfo: serviceLocator(),
//     ),
//   );
//
//   serviceLocator.registerFactory(() => GetGroupChatUseCase(repository: serviceLocator()));
//   serviceLocator.registerFactory(() => GetChatUseCase(repository: serviceLocator()));
//   serviceLocator.registerFactory(() => SendMessageUseCase(repository: serviceLocator()));
//   serviceLocator.registerFactory(() => ChatGetAllUsers(repository: serviceLocator()));
//   serviceLocator.registerFactory(() => CreateUserChatUseCase(repository: serviceLocator()));
//   serviceLocator.registerFactory(() => CreateGroupChatUseCase(repository: serviceLocator()));
//
//   serviceLocator.registerFactory(
//         () => ChatBloc(
//       getGroupChat: serviceLocator(),
//       getChat: serviceLocator(),
//       sendMessage: serviceLocator(),
//       getAllUsers: serviceLocator(),
//       createUserChat: serviceLocator(),
//       createGroupChat: serviceLocator(),
//     ),
//   );
// }
//
// void _account() {
//   serviceLocator.registerSingleton<AccountRepository>(AccountRepositoryImpl(dataSource: AccountDataSourceImpl()));
//   serviceLocator.registerFactory(() => AccountsBloc());
// }
//
// void _lenta() {
//   serviceLocator.registerSingleton<LentaRemoteDataSourceImpl>(LentaRemoteDataSourceImpl());
//   serviceLocator.registerSingleton<LentaRepository>(LentaRepositoryImpl(remoteDataSource: serviceLocator<LentaRemoteDataSourceImpl>()));
//   serviceLocator.registerSingleton<GetCommentsUseCase>(GetCommentsUseCase());
//   serviceLocator.registerSingleton<GetPostsUseCase>(GetPostsUseCase());
//   serviceLocator.registerSingleton<SendLikeUnLikeUseCase>(SendLikeUnLikeUseCase());
//   serviceLocator.registerSingleton<SendCommentUseCase>(SendCommentUseCase());
//   serviceLocator.registerSingleton<CreatePostUseCase>(CreatePostUseCase());
//
//   serviceLocator.registerFactory(() => PostBloc(
//     serviceLocator<GetPostsUseCase>(),
//     serviceLocator<SendLikeUnLikeUseCase>(),
//     serviceLocator<CreatePostUseCase>(),
//   ));
//   serviceLocator.registerFactory(() => CommentBloc(
//     serviceLocator<GetCommentsUseCase>(),
//     serviceLocator<SendCommentUseCase>(),
//   ));
// }
