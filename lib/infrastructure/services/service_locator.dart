import 'package:get_it/get_it.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/application/auth/auth_bloc.dart';
import 'package:mpd_client/application/comment/comment_bloc.dart';
import 'package:mpd_client/application/post/post_bloc.dart';
import 'package:mpd_client/domain/abstract_repo/chat_repository.dart';
import 'package:mpd_client/domain/abstract_repo/lenta_repository.dart';
import 'package:mpd_client/infrastructure/apis/account_service.dart';
import 'package:mpd_client/infrastructure/apis/appoinment_remote_datasource.dart';
import 'package:mpd_client/infrastructure/apis/chat_service.dart';
import 'package:mpd_client/infrastructure/apis/doctor_profile_remote_datasource.dart';
import 'package:mpd_client/infrastructure/apis/lenta_service.dart';
import 'package:mpd_client/infrastructure/apis/user_remote_datasource.dart';
import 'package:mpd_client/infrastructure/apis/yandex_doctor_remote_datasources.dart';
import 'package:mpd_client/infrastructure/reopsitories/appoinment_repository.dart';
import 'package:mpd_client/infrastructure/reopsitories/auth_repository.dart';
import 'package:mpd_client/infrastructure/reopsitories/chat_repository_impl.dart';
import 'package:mpd_client/infrastructure/reopsitories/doctor_profile_repository.dart';
import 'package:mpd_client/infrastructure/reopsitories/lenta_repository_impl.dart';
import 'package:mpd_client/infrastructure/reopsitories/user_repository.dart';
import 'package:mpd_client/infrastructure/reopsitories/yandex_doctor_repository.dart';
import 'package:mpd_client/infrastructure/services/api_service.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/chat_bloc.dart';

final serviceLocator = GetIt.I;

void setupLocator() {
  // Dio Setting Objects
  serviceLocator.registerFactory(DioSettings.new);
  // Auth Objects
  serviceLocator.registerSingleton(AuthBloc());
  serviceLocator.registerFactory(() => AccountsBloc());
  serviceLocator.registerSingleton<AccountService>(AccountService.create());
  serviceLocator.registerSingleton<AuthRepository>(const AuthRepository());
  // // serviceLocator.registerSingleton(Debouncer(milliseconds: 300));
  //
  // // Lenta Objects
  _lenta();

  //Doctor Yandex
  _doctor();

  // // Chat Objects
  _chatRegister();

  // Appointment Objects
  _appointment();

  _profile();
}

//
void _chatRegister() {
  // Service
  serviceLocator.registerSingleton<ChatService>(ChatService.create());
  //Repo
  serviceLocator.registerSingleton<ChatRepository>(ChatRepositoryImpl(remote: serviceLocator<ChatService>()));
  // Bloc
  serviceLocator.registerFactory(() => ChatBloc(serviceLocator<ChatRepository>()));
}

//
// void _account() {
//   serviceLocator.registerSingleton<AccountRepository>(AccountRepositoryImpl(dataSource: AccountDataSourceImpl()));
//   serviceLocator.registerFactory(() => AccountsBloc());
// }
//
void _lenta() {
  serviceLocator.registerSingleton<LentaService>(LentaService.create());
  serviceLocator.registerSingleton<LentaRepository>(LentaRepositoryImpl(remoteDataSource: serviceLocator<LentaService>()));

  serviceLocator.registerFactory(() => PostBloc(serviceLocator<LentaRepository>()));
  serviceLocator.registerFactory(() => CommentBloc(serviceLocator<LentaRepository>()));
}

void _doctor() {
  serviceLocator.registerSingleton<YandexDoctorRepository>(YandexDoctorRepository(remoteDataSource: YandexDoctorRemoteDataSource()));
}


void _appointment() {
  serviceLocator.registerSingleton(AppoinmentRepository(appoinmentRemoteDataSource: AppoinmentRemoteDataSource()));
}

void _profile() {
  serviceLocator.registerSingleton(DoctorProfileRepository( remoteDataSource: DoctorProfileRemoteDataSource()));
  serviceLocator.registerSingleton<UserRepository>( UserRepository(mainRemoteDataSource: UserRemoteDataSource()));

}