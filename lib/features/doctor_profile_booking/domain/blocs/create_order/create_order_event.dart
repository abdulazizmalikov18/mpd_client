part of 'create_order_bloc.dart';

abstract class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();

  @override
  List<Object> get props => [];
}

class CreateOrderProcess extends CreateOrderEvent {
  final List<Map<String, dynamic>> carts;
  final int payment;
  final String action;

  const CreateOrderProcess(
      {required this.carts, required this.payment, required this.action});
}
