part of 'add_to_cart_bloc.dart';

abstract class AddToCartEvent extends Equatable {
  const AddToCartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends AddToCartEvent {
  final List<LocalService> localServices;
  final int responsible;
  final DateTime meetDate;

  const AddToCart(
      {required this.localServices,
      required this.responsible,
      required this.meetDate});
}
