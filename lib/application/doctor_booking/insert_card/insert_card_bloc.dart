import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/domain/models/doctor_booking/card_local_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/card_remote_model.dart';
import 'package:mpd_client/infrastructure/reopsitories/doctor_profile_repository.dart';
import 'package:mpd_client/utils/utils.dart';
part 'insert_card_event.dart';
part 'insert_card_state.dart';

class InsertCardBloc extends Bloc<InsertCardEvent, InsertCardState> {
  InsertCardBloc(this._profileRepository, this._cardController, this._expiryController, this._nameController, this._formkey) : super(const InsertCardInitial(null)) {
    on<InsertCard>(_onInsertCard);
  }

  final TextEditingController _cardController;
  final TextEditingController _expiryController;
  final TextEditingController _nameController;
  final GlobalKey<FormState> _formkey;

  TextEditingController get cardController => _cardController;
  TextEditingController get expiryController => _expiryController;
  TextEditingController get nameController => _nameController;
  GlobalKey<FormState> get formkey => _formkey;

  final DoctorProfileRepository _profileRepository;

  Future<void> _onInsertCard(InsertCard event, Emitter<InsertCardState> emit) async {
    if (_formkey.currentState!.validate()) {
      emit(InsertCardLoading(state.card));
      final cardLocalModel = CardLocalModel(name: _nameController.text, cardNumber: _cardController.text.replaceAll(' ', ''), expire: _expiryController.text);

      final result = await _profileRepository.insertCard(cardLocalModel);
      if (result.isRight) {
        emit(InsertCardSuccess(result.right));
      } else {
        emit(InsertCardFailure(Utils.errorFormat(result.left.errorMessage), state.card));
      }
    }
  }
}
