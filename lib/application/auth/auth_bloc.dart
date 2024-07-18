import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/domain/models/auth/user.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';
import 'package:mpd_client/infrastructure/reopsitories/auth_repository.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';
import 'package:mpd_client/utils/extensions/list_extention.dart';
import 'package:uuid/uuid.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo = const AuthRepository();

  AuthBloc() : super(const AuthState()) {
    on<LoginEvent>(login);
    on<Logout>(logOut);
    on<AuthStatusChanged>(authStatusChanged);
    on<GetUserAuthEvent>(getUser);
  }

  void login(LoginEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await _repo.login(login: event.login, password: event.password);
    if (result.isRight) {
      await StorageRepository.putBool(StorageKeys.ISLOGGED, true);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
      add(const AuthStatusChanged(AuthStatus.authenticated));
      event.onSuccess();
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      add(const AuthStatusChanged(AuthStatus.unauthenticated));
      event.onError((result.left as ServerFailure).errorMessage);
    }
  }

  void logOut(Logout event, Emitter emit) async {
    clearStorage();
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    add(const AuthStatusChanged(AuthStatus.unauthenticated));
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }

  void authStatusChanged(AuthStatusChanged event, Emitter emit) async {
    if (event.status == AuthStatus.authenticated) {
      final user = await _repo.getUser();
      if (user.isRight) {
        emit(state.copyWith(userModel: user.right));
        final specialist = await _repo.getSpecialists();
        if (specialist.isRight) {
          if (specialist.isRight && specialist.right.isNotEmpty) {
            final isHaveSPID = specialist.right.findIndex((value) => value.id == StorageRepository.getString(StorageKeys.SPID));
            await StorageRepository.putString(
              StorageKeys.SPID,
              isHaveSPID != null ? specialist.right[isHaveSPID].id : specialist.right.first.id,
            );
          }
          await StorageRepository.putString(
            StorageKeys.USERNAME,
            user.right.username,
          );
          emit(state.copyWith(authStatus: AuthStatus.authenticated, text: const Uuid().v4()));
        } else {
          emit(state.copyWith(authStatus: AuthStatus.unauthenticated, text: const Uuid().v4()));
        }
      } else {
        emit(state.copyWith(authStatus: AuthStatus.unauthenticated, text: const Uuid().v4()));
      }
    } else if (event.status == AuthStatus.unauthenticated) {
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated, text: const Uuid().v4()));
    }
  }

  void getUser(GetUserAuthEvent event, Emitter emit) async {
    final user = await _repo.getUser();
    if (user.isRight) {
      emit(state.copyWith(userModel: user.right));
    }
  }

  void clearStorage() async {
    await StorageRepository.putBool("isPassword", false);
    await StorageRepository.putString("password", "");
    await StorageRepository.putBool(StorageKeys.ISLOGGED, false);
    await StorageRepository.deleteString(StorageKeys.PASSWORD);
    await StorageRepository.deleteString(StorageKeys.USERNAME);
    await StorageRepository.deleteString(StorageKeys.TOKEN);
    await StorageRepository.deleteString(StorageKeys.REFRESH);
    await StorageRepository.deleteString(StorageKeys.SPID);
  }
}
