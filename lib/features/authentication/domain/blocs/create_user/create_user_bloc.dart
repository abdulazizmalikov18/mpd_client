import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/authentication/data/models/create_user_form_model.dart';
import 'package:mpd_client/features/authentication/data/repositories/auth_repository.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  CreateUserBloc(
    this._userNameController,
    this._firstNameController,
    this._lastNameController,
    this._birthController,
    this._repository,
    this._formKey,
  ) : super(const CreateUserState()) {
    on<SelectingGenderEvent>(_onSelectGender);
    on<SelectingBirthEvent>(_onSelectingDateTime);
    on<ForCreateUserEvent>(_onCreateUserButtonPressed);
  }

  final AuthRepository _repository;
  final GlobalKey<FormState> _formKey;

  final TextEditingController _userNameController;
  final TextEditingController _firstNameController;
  final TextEditingController _lastNameController;
  final TextEditingController _birthController;

  GlobalKey get formKey => _formKey;
  TextEditingController get userNameController => _userNameController;
  TextEditingController get firsNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get birthController => _birthController;

  void _onSelectGender(
    SelectingGenderEvent event,
    Emitter<CreateUserState> emit,
  ) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onSelectingDateTime(
    SelectingBirthEvent event,
    Emitter<CreateUserState> emit,
  ) {
    final dateString = Utils.formatDateTime(event.dateTime);
    _birthController.value = TextEditingValue(text: dateString);
  }

  Future<void> _onCreateUserButtonPressed(
    ForCreateUserEvent event,
    Emitter<CreateUserState> emit,
  ) async {
    emit(state.copyWith(error: '', gender: state.gender));
    if (_formKey.currentState!.validate()) {
      emit(state.copyWith(showLoading: true, gender: state.gender));

      final result = await _repository.createUser(
        CreateUserFormModel(
          // username: _userNameController.text,
          name: _firstNameController.text,
          lastname: _lastNameController.text,
          surname: _lastNameController.text,
          birthday: _birthController.text,
          gender: state.gender.name[0],
          mainCat: event.mainCategory,
          region: event.region,
          phone: event.phone,
          password: event.password,
        ),
      );

      if (result.isRight) {
        emit(
          state.copyWith(showLoading: false, error: 'No', gender: state.gender),
        );
      } else {
        emit(
          state.copyWith(
            error: result.left.message,
            showLoading: false,
            gender: state.gender,
          ),
        );
      }
    }
  }
}
