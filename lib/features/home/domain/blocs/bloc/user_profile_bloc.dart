import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/features/home/data/models/user_account_model.dart';
import 'package:mpd_client/features/home/data/repositories/home_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final HomeRepository _homeRepository;
  UserProfileBloc(this._homeRepository) : super(const UserProfileState()) {
    on<GetUserEvent>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final resault = await _homeRepository.getUser(username: event.username);
      if (resault.isRight) {
        emit(
          state.copyWith(
            userAccount: resault.right,
            status: FormzSubmissionStatus.success,
          ),
        );
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });
  }
}
