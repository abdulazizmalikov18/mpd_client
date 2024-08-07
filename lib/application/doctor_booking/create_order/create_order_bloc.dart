import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/infrastructure/reopsitories/doctor_profile_repository.dart';

part 'create_order_event.dart';

part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  CreateOrderBloc(this._profileRepository) : super(CreateOrderInitial()) {
    on<CreateOrderProcess>(_onCreateOrder);
  }

  final DoctorProfileRepository _profileRepository;

  Future<void> _onCreateOrder(CreateOrderProcess event, Emitter<CreateOrderState> emit) async {
    emit(CreateOrderLoading());
    final result = await _profileRepository.createOrder(
      action: event.action,
      carts: event.carts,
      payment: event.payment,
    );
    if (result.isRight) {

      emit(CreateOrderSuccess(result.right));
    } else {
      emit(CreateOrderFailure(result.left.errorMessage));
    }
  }
}
