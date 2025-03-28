import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mpd_client/core/connection/connection_info.dart';
import 'package:mpd_client/core/network/dio_settings.dart';
import 'package:mpd_client/features/appointment/data/datasources/appoinment_remote_datasource.dart';
import 'package:mpd_client/features/appointment/data/repositories/appoinment_repository.dart';
import 'package:mpd_client/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:mpd_client/features/authentication/data/repositories/auth_repository.dart';
import 'package:mpd_client/features/authentication/domain/blocs/refresh_token/refreshtoken_bloc.dart';
import 'package:mpd_client/features/chat/data/repo/chat_repository.dart';
import 'package:mpd_client/features/chat/data/repo/chat_repository_impl.dart';
import 'package:mpd_client/features/chat/data/service/chat_service.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat_group/chat_group_bloc.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat_message/bloc/chat_message_bloc.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/datasources/doctor_profile_remote_datasource.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/repositories/doctor_profile_repository.dart';
import 'package:mpd_client/features/home/data/datasources/home_remote_datasource.dart';
import 'package:mpd_client/features/home/data/repositories/home_repository.dart';
import 'package:mpd_client/features/user/data/datasources/user_remote_datasource.dart';
import 'package:mpd_client/features/yandex_doctor/data/repositories/yandex_doctor_repository.dart';

import '../features/user/data/repositories/user_repository.dart';
import '../features/yandex_doctor/data/datasources/yandex_doctor_remote_datasources.dart';

final locator = GetIt.I;

void setupLocator() {
  // Dio Setting Objects
  locator.registerFactory(DioSettings.new);

  locator.registerLazySingleton<Connectivity>(() => Connectivity());

  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource());
  locator.registerLazySingleton<ConnectionInfo>(
    () => ConnectionInfo(
      connectivity: locator<Connectivity>(),
      connectionChecker: InternetConnectionChecker.instance,
    ),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      remoteDataSource: locator<AuthRemoteDataSource>(),
      connectionInfo: locator<ConnectionInfo>(),
    ),
  );
  locator.registerSingletonAsync<YandexDoctorRepository>(
    () async => YandexDoctorRepository(
      remoteDataSource:
          YandexDoctorRemoteDataSource(locator<DioSettings>().dio),
      connectionInfo: locator<ConnectionInfo>(),
    ),
  );
  locator.registerLazySingleton<HomeRepository>(
    () => HomeRepository(
      remoteDataSource: HomeRemoteDataSource(locator<DioSettings>().dio),
      connectionInfo: locator<ConnectionInfo>(),
    ),
  );

  locator.registerSingletonAsync<UserRepository>(
    () async => UserRepository(
      connectionInfo: locator<ConnectionInfo>(),
      mainRemoteDataSource: UserRemoteDataSource(locator<DioSettings>().dio),
    ),
  );
  locator.registerLazySingleton<DoctorProfileRepository>(
    () => DoctorProfileRepository(
      remoteDataSource:
          DoctorProfileRemoteDataSource(locator<DioSettings>().dio),
      connectionInfo: locator<ConnectionInfo>(),
    ),
  );

  locator.registerLazySingleton<AppoinmentRepository>(
    () => AppoinmentRepository(
      appoinmentRemoteDataSource:
          AppoinmentRemoteDataSource(locator<DioSettings>().dio),
      connectionInfo: locator<ConnectionInfo>(),
    ),
  );
  locator.registerSingleton(RefreshtokenBloc(locator<AuthRepository>()));
  // // Chat Objects
  _chatRegister();
}

void _chatRegister() {
  // Service
  locator.registerSingleton<ChatService>(ChatService.create());
  //Repo
  locator.registerSingleton<ChatRepository>(
      ChatRepositoryImpl(remote: locator<ChatService>()));
  // Bloc
  // locator.registerFactory(() => ChatBloc(locator<ChatRepository>()));
  locator.registerFactory(() => ChatGroupBloc(locator<ChatRepository>()));
  locator.registerFactory(() => ChatMessageBloc(locator<ChatRepository>()));
}

Future resetLocator() async {
  await locator.reset();
  setupLocator();
}
