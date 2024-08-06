import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/domain/models/doctor_booking/cart_local_model.dart';
import 'package:mpd_client/infrastructure/reopsitories/doctor_profile_repository.dart';
import 'package:mpd_client/infrastructure/services/local_service.dart';

part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  AddToCartBloc(this._profileRepository) : super(const AddToCartInitial([], [])) {
    on<AddToCart>(_onAddToCart);
  }

  final DoctorProfileRepository _profileRepository;

  Future<void> _onAddToCart(AddToCart event, Emitter<AddToCartState> emit) async {
    emit(AddToCartLoading(state.cartIDs, state.carts));

    final List<Map<String, dynamic>> carts = [];

    for (var service in event.localServices) {
      carts.add(CartLocalModel(product: service.id, responsible: event.responsible, qty: service.count, meetDate: event.meetDate).toJson());
    }

    final result = await _profileRepository.addToCart(carts);
    if (result.isRight) {
      var cartIDs = <int>[];
      for (var cart in result.right) {
        cartIDs.add(cart.id!);
      }
      emit(AddToCartSuccess(cartIDs, carts));
    } else {
      emit(AddToCartFailure(state.cartIDs, carts, failure: result.left.errorMessage));
    }
  }
}
