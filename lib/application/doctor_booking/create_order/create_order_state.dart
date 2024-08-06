part of 'create_order_bloc.dart';

abstract class CreateOrderState extends Equatable {
  const CreateOrderState();

  @override
  List<Object> get props => [];
}

class CreateOrderInitial extends CreateOrderState {}

class CreateOrderLoading extends CreateOrderState {}

class CreateOrderSuccess extends CreateOrderState {
  final Map<String, dynamic> order;
  const CreateOrderSuccess(this.order);
}

class CreateOrderFailure extends CreateOrderState {
  final String failure;
  const CreateOrderFailure(this.failure);
}
