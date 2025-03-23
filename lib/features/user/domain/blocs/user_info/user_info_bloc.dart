import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/authentication/domain/blocs/create_user/create_user_bloc.dart';
import 'package:mpd_client/features/user/data/models/spec_add_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_cat_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_category_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_position_model.dart';
import 'package:mpd_client/features/user/data/models/user_image_update_model.dart';
import 'package:mpd_client/features/user/data/models/user_info_model.dart';
import 'package:mpd_client/features/user/data/models/user_info_update_model.dart';
import 'package:mpd_client/features/user/data/repositories/user_repository.dart';

part 'user_info_event.dart';

part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc(this._userRepository) : super(const UserInfoState()) {
    on<GetUserInfoEvent>(_onGetUserInfo);
    on<UpdateUserInfoLocal>(_onUpdateUserLocalInfo);
    on<UpdateUserProfessionEvent>(_onSavedChangesButtonPressed);
    on<SelectedCategoryIdEvent>(_onSelectedCategoryId);
    on<SelectedRegionIdEvent>(_onSelectedRegionId);
    on<SelectUserImage>(_onSelectUserImage);
    on<SelectUserBackImage>(_onSelectUserBackImage);
    on<UpdateUserImage>(_onUpdateUserImage);
    on<UpdateUserBackImage>(_onUpdateUserBackImage);
    on<HasChangesEvent>(_onHasChanges);
    on<GetSpecialistPosition>(_onGetSpecialistPosition);
    on<GetSpecialistCat>(_onGetSpecialistCat);
    on<GetSpecCategory>(_onGetSpecCategory);
    on<GetSpecialistUser>(_onGetSpecialist);
    on<GetDocumentEvent>(_ongetDocmentEvent);
    on<PostSpecialist>(_onPostSpecialist);
    on<UpdateUserBirthEvent>((event, emit) {});
    on<IsAddedSpecialist>((event, emit) async {
      final response = await _userRepository.isAddedSpecialist();
      if (response.isRight) {
        event.onSucces(response.right);
      } else {
        event.onError();
      }
    });
  }

  final UserRepository _userRepository;

  void _onGetSpecialist(
      GetSpecialistUser event, Emitter<UserInfoState> emit) async {
    emit(state.copyWith(statusSpec: FormzSubmissionStatus.inProgress));
    final response = await _userRepository.getSpecialist();
    if (response.isRight) {
      if (response.right.isNotEmpty) {
        await StorageRepository.putString(StorageKeys.SPID,response.right.first.id);
        await StorageRepository.putString(StorageKeys.COMPID,response.right.first.org.slugName);
      }
      emit(state.copyWith(
        specailistModel: response.right,
        statusSpec: FormzSubmissionStatus.success,
      ));
    } else {
      emit(state.copyWith(statusSpec: FormzSubmissionStatus.failure));
    }
  }

  void _onPostSpecialist(
      PostSpecialist event, Emitter<UserInfoState> emit) async {
    emit(state.copyWith(statusCreate: FormzSubmissionStatus.inProgress));
    final model = SpecAddModel(
      position: event.idPos,
      specCat: event.idCat,
      job: event.idJob,
      file: event.file,
    );
    final response = await _userRepository.postSpecialist(model);
    if (response.isRight) {
      emit(state.copyWith(statusCreate: FormzSubmissionStatus.success));
      event.onSucces();
    } else {
      emit(state.copyWith(statusCreate: FormzSubmissionStatus.failure));
      event.onError();
    }
  }

  void _onGetSpecCategory(
      GetSpecCategory event, Emitter<UserInfoState> emit) async {
    emit(state.copyWith(statusJob: FormzSubmissionStatus.inProgress));
    final response = await _userRepository.getSpecialistCategory();
    if (response.isRight) {
      emit(state.copyWith(
        specialistCategory: response.right.results,
        statusJob: FormzSubmissionStatus.success,
      ));
    } else {
      emit(state.copyWith(statusJob: FormzSubmissionStatus.failure));
    }
  }

  void _onGetSpecialistCat(
      GetSpecialistCat event, Emitter<UserInfoState> emit) async {
    emit(state.copyWith(statusCat: FormzSubmissionStatus.inProgress));
    final response = await _userRepository.getSpecialistCat();
    if (response.isRight) {
      emit(state.copyWith(
        specialistCat: response.right.results,
        statusCat: FormzSubmissionStatus.success,
      ));
    } else {
      emit(state.copyWith(statusCat: FormzSubmissionStatus.failure));
    }
  }

  void _onGetSpecialistPosition(
      GetSpecialistPosition event, Emitter<UserInfoState> emit) async {
    emit(state.copyWith(statusPos: FormzSubmissionStatus.inProgress));
    final response = await _userRepository.getSpecialistPosition();
    if (response.isRight) {
      emit(state.copyWith(
        specialistPosition: response.right.results,
        statusPos: FormzSubmissionStatus.success,
      ));
    } else {
      emit(state.copyWith(statusPos: FormzSubmissionStatus.failure));
    }
  }

  void _onUpdateUserLocalInfo(
      UpdateUserInfoLocal event, Emitter<UserInfoState> emit) async {
    final userLocalInfo = await _userRepository.getUserInfo();
    if (userLocalInfo.isRight) {
      emit(state.copyWith(
        userInfo: userLocalInfo.right,
        status: FormzSubmissionStatus.initial,
      ));
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> _onGetUserInfo(
      GetUserInfoEvent event, Emitter<UserInfoState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await _userRepository.getUserInfo();
    Log.e(result.isRight);
    if (result.isRight) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        userInfo: result.right,
      ));
    } else {
      if (result.left is NetworkFailure) {
        emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            failure: const NetworkFailure(
                message: 'Please, check your internet connection!')));
      } else {
        emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            failure: const ServerFailure(
                message: 'Unkown failure', statusCode: 000)));
      }
    }
  }

  void _onHasChanges(HasChangesEvent event, Emitter<UserInfoState> emit) {
    emit(
      state.copyWith(
        mainCat: state.mainCat,
        showLoading: state.showLoading,
        isChanged: true,
      ),
    );
  }

  Future<void> _onUpdateUserImage(
      UpdateUserImage event, Emitter<UserInfoState> emit) async {
    if (state.userImage != null) {
      emit(state.copyWith(showLoading: true, userImage: state.userImage));

      final result = await _userRepository.updateUserImage(
        UserImageUpdate(
          main: true,
          businessAva: true,
          image: state.userImage!.path,
        ),
      );
      if (result.isRight) {
        add(GetUserInfoEvent());
        emit(state.copyWith(
          showLoading: false,
          error: 'No',
          userImage: state.userImage,
        ));
      } else {
        emit(state.copyWith(error: result.left.message, showLoading: false));
      }
    }
  }

  Future<void> _onUpdateUserBackImage(
      UpdateUserBackImage event, Emitter<UserInfoState> emit) async {
    if (state.userBackImage != null) {
      emit(state.copyWith(
          showLoading: true, userBackImage: state.userBackImage));
      final result = await _userRepository.updateUserBackImage(
        UserImageUpdate(
          main: true,
          image: state.userBackImage!.path,
        ),
      );
      if (result.isRight) {
        add(GetUserInfoEvent());
        emit(state.copyWith(
          showLoading: false,
          error: 'No',
          userBackImage: state.userBackImage,
        ));
      } else {
        emit(state.copyWith(error: result.left.message, showLoading: false));
      }
    }
  }

  Future<void> _onSelectUserImage(
      SelectUserImage event, Emitter<UserInfoState> emit) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      File? img = File(image.path);

      emit(state.copyWith(
          userImage: img,
          mainCat: state.mainCat,
          showLoading: state.showLoading,
          isChanged: true));
    } on PlatformException catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onSelectUserBackImage(
      SelectUserBackImage event, Emitter<UserInfoState> emit) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      File? img = File(image.path);

      emit(
        state.copyWith(
          userBackImage: img,
          isBackChanged: true,
        ),
      );
    } on PlatformException catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onSelectedCategoryId(
      SelectedCategoryIdEvent event, Emitter<UserInfoState> emit) {
    if (event.mainCat.name! != event.localCatName) {
      emit(
        state.copyWith(
          mainCat: event.mainCat,
          showLoading: state.showLoading,
          error: state.error,
          isChanged: true,
        ),
      );
      return;
    }
    emit(state.copyWith(showLoading: state.showLoading, isChanged: false));
  }

  void _onSelectedRegionId(
      SelectedRegionIdEvent event, Emitter<UserInfoState> emit) {
    if (event.region.name! != event.localRegion) {
      emit(
        state.copyWith(
          region: event.region,
          showLoading: state.showLoading,
          error: state.error,
          isChanged: true,
        ),
      );
      return;
    }
    emit(state.copyWith(showLoading: state.showLoading, isChanged: false));
  }

  Future<void> _onSavedChangesButtonPressed(
      UpdateUserProfessionEvent event, Emitter<UserInfoState> emit) async {
    emit(state.copyWith(showLoading: true));
    add(UpdateUserBackImage());
    final result = await _userRepository.updateUserInfo(
      UserInfoUpdateModel(
        lastname: event.lastname,
        name: event.name,
        birthday: event.birthday,
        gender: event.gender.name,
        region: state.region?.id,
        mainCat: state.mainCat?.id,
        bio: event.bio,
      ),
    );
    if (result.isRight) {
      emit(state.copyWith(
        showLoading: false,
        error: 'No',
      ));
    } else {
      emit(state.copyWith(error: result.left.message, showLoading: false));
    }
  }

  void _ongetDocmentEvent(GetDocumentEvent event, Emitter emit) async {}
}
