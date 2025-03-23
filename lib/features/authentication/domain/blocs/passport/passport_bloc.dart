import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpd_client/features/authentication/data/repositories/auth_repository.dart';

part 'passport_event.dart';
part 'passport_state.dart';

class PassportBloc extends Bloc<PassportEvent, PassportState> {
  PassportBloc(this._repository, this._formKey, this._stirController)
      : super(const PassportState()) {
    on<SelectPassportImage>(_onSelectPassportImage);
    on<UpdatePersonalDataEvent>(_onUpdateUser);
  }

  final AuthRepository _repository;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _stirController;

  GlobalKey get formKey => _formKey;
  TextEditingController get stirController => _stirController;

  Future<void> _onSelectPassportImage(
      SelectPassportImage event, Emitter<PassportState> emit) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      File? img = File(image.path);
      emit(state.copyWith(pasportImage: img));
    } on PlatformException catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onUpdateUser(
      UpdatePersonalDataEvent event, Emitter<PassportState> emit) async {
    if (_formKey.currentState!.validate()) {
      emit(state.copyWith(showLoading: true));
      final result = await _repository.updatePersonalData(
        passportSTIR: stirController.text,
        filePath: state.pasportImage?.path,
      );
      if (result.isRight) {
        emit(state.copyWith(showLoading: false, error: 'No'));
      } else {
        emit(state.copyWith(error: result.left.message, showLoading: false));
      }
    }
  }
}
