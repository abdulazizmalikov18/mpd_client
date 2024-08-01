import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/infrastructure/reopsitories/appoinment_repository.dart';
import 'package:mpd_client/utils/utils.dart';

part 'cancel_appointment_event.dart';
part 'cancel_appointment_state.dart';

class CancelAppointmentBloc extends Bloc<CancelAppointmentEvent, CancelAppointmentState> {
  CancelAppointmentBloc(this._appoinmentRepository) : super(CancelAppointmentInitial()) {
    on<CancelPressedEvent>(_onCancelPressed);
  }

  final AppoinmentRepository _appoinmentRepository;

  Future<void> _onCancelPressed(CancelPressedEvent event, Emitter<CancelAppointmentState> emit) async {
    emit(CancelAppointmentLoading());

    final result = await _appoinmentRepository.cancelAppoinment(cancelInfo: event.cancelInfo, productid: event.productid);

    if (result.isLeft) {
      emit(CancelAppointmentFailure(Utils.errorFormat(result.left.errorMessage)));
    } else {
      emit(CancelAppointmentSuccess());
    }
  }
}
