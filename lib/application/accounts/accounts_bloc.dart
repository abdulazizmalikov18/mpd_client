import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/application/accounts/region_and_profession_container.dart';
import 'package:mpd_client/application/accounts/user_container.dart';
import 'package:mpd_client/domain/abstract_repo/account_repository.dart';
import 'package:mpd_client/domain/entity/account/popular_category_filter.dart';
import 'package:mpd_client/domain/models/auth/user.dart';
import 'package:mpd_client/infrastructure/apis/account_service.dart';
import 'package:mpd_client/infrastructure/reopsitories/account_repository_impl.dart';
import 'package:mpd_client/infrastructure/reopsitories/auth_repository.dart';
import 'package:mpd_client/infrastructure/services/service_locator.dart';

part 'accounts_event.dart';

part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final AuthRepository _repo = const AuthRepository();
  final AccountRepository _accountRepo = AccountRepositoryImpl(serviceLocator<AccountService>());

  AccountsBloc() : super(const AccountsState()) {
    on<GetRegion>(_getRegion);
    on<GetProfession>(_getProfession);
    on<GetAccountUserEvent>(_getUser);
    on<UpdateUserEvent>(_updateUser);
  }

  void _getRegion(GetRegion event, Emitter emit) async {
    if (state.regionAndProfessionContainer.regions.isEmpty || event.index != 0 || event.search != null) {
      emit(state.copyWith(regionAndProfessionContainer: state.regionAndProfessionContainer.copyWith(statusd: FormzSubmissionStatus.inProgress)));
      final param = Filter(
        parent: (event.search != null) ? null : event.id,
        search: event.search,
      );
      final result = await _accountRepo.getRegion(param);
      if (result.isRight) {
        if (event.index == 1) {
          emit(state.copyWith(regionAndProfessionContainer: state.regionAndProfessionContainer.copyWith(regions1: result.right.results)));
        } else if (event.index == 2) {
          emit(state.copyWith(regionAndProfessionContainer: state.regionAndProfessionContainer.copyWith(regions2: result.right.results)));
        } else {
          emit(state.copyWith(regionAndProfessionContainer: state.regionAndProfessionContainer.copyWith(regions: result.right.results)));
        }
        emit(state.copyWith(regionAndProfessionContainer: state.regionAndProfessionContainer.copyWith(statusd: FormzSubmissionStatus.success)));
      } else {
        emit(state.copyWith(regionAndProfessionContainer: state.regionAndProfessionContainer.copyWith(statusd: FormzSubmissionStatus.failure)));
      }
    }
  }

  void _getProfession(GetProfession event, Emitter emit) async {
    if (state.regionAndProfessionContainer.profession.isEmpty || event.index != 0 || event.search != null) {
      emit(state.copyWith(regionAndProfessionContainer: state.regionAndProfessionContainer.copyWith(statusd: FormzSubmissionStatus.inProgress)));

      final param = Filter(
        parent: (event.search != null) ? null : event.id,
        search: event.search,
      );
      final result = await _accountRepo.getProfession(param);
      if (result.isRight) {
        if (event.index == 1) {
          emit(state.copyWith(regionAndProfessionContainer: state.regionAndProfessionContainer.copyWith(profession2: result.right.results)));
        } else {
          emit(state.copyWith(regionAndProfessionContainer: state.regionAndProfessionContainer.copyWith(profession: result.right.results)));
        }
        emit(state.copyWith(regionAndProfessionContainer: state.regionAndProfessionContainer.copyWith(statusd: FormzSubmissionStatus.success)));
      } else {
        emit(state.copyWith(regionAndProfessionContainer: state.regionAndProfessionContainer.copyWith(statusd: FormzSubmissionStatus.failure)));
      }
    }
  }

  void _getUser(GetAccountUserEvent event, Emitter emit) async {
    emit(state.copyWith(userContainer: state.userContainer.copyWith(status: FormzSubmissionStatus.inProgress)));
    final user = await _repo.getUser();
    if (user.isRight) {
      emit(state.copyWith(
        userContainer: state.userContainer.copyWith(
          status: FormzSubmissionStatus.success,
          user: user.right,
        ),
      ));
      event.onSuccess?.call();
      return;
    }
    event.onError?.call("Iltimos qayta urinib ko'ring !");
    emit(state.copyWith(userContainer: state.userContainer.copyWith(status: FormzSubmissionStatus.failure)));
  }

  void _updateUser(UpdateUserEvent event, Emitter emit) async {
    emit(state.copyWith(userContainer: state.userContainer.copyWith(status: FormzSubmissionStatus.inProgress)));
    final user = await _repo.updateUser(event.user, event.avatar);
    if (user.isRight) {
      emit(state.copyWith(
        userContainer: state.userContainer.copyWith(
          status: FormzSubmissionStatus.success,
        ),
      ));
      event.onSuccess.call();
      return;
    }
    event.onError.call("Iltimos qayta urinib ko'ring !");
    emit(state.copyWith(userContainer: state.userContainer.copyWith(status: FormzSubmissionStatus.failure)));
  }
}