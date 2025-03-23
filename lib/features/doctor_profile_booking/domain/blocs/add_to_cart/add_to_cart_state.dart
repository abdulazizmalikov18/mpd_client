part of 'add_to_cart_bloc.dart';

abstract class AddToCartState extends Equatable {
  final List<int> cartIDs;
   final List<Map<String, dynamic>> carts;
  const AddToCartState(this.cartIDs, this.carts);

  @override
  List<Object> get props => [cartIDs,carts];
}

class AddToCartInitial extends AddToCartState {
  const AddToCartInitial(super.cartIDs, super.carts);
}

class AddToCartLoading extends AddToCartState {
  const AddToCartLoading(super.cartIDs, super.carts);
}

class AddToCartSuccess extends AddToCartState {

  const AddToCartSuccess(super.cartIDs, super.carts);
}

class AddToCartFailure extends AddToCartState {
  final String failure;
  const AddToCartFailure(super.cartIDs, super.carts, {required this.failure});
}
