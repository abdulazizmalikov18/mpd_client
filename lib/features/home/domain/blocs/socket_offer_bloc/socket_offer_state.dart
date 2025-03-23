part of 'socket_offer_bloc.dart';

class SocketOfferState extends Equatable {
  final bool isConnect;
  final String type;
  final SpecialistOrderModel? order;
  final List<OrdersStreamModel> orders;
  final List<SpecialistOffer>? offers;

  const SocketOfferState({
    this.isConnect = false,
    this.order,
    this.orders = const [],
    this.offers,
    this.type = '',
  });

  SocketOfferState copyWith({
    bool? isConnect,
    SpecialistOrderModel? order,
    List<OrdersStreamModel>? orders,
    List<SpecialistOffer>? offers,
    String? type,
  }) =>
      SocketOfferState(
        isConnect: isConnect ?? this.isConnect,
        offers: offers ?? this.offers,
        order: order ?? this.order,
        orders: orders ?? this.orders,
        type: type ?? this.type,
      );

  @override
  List<Object?> get props => [
        isConnect,
        order,orders,
        offers,
        type,
      ];
}
