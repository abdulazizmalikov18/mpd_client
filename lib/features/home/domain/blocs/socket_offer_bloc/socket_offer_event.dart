part of 'socket_offer_bloc.dart';

abstract class SocketOfferEvent {
  const SocketOfferEvent();
}

class ConnectSocketEvent extends SocketOfferEvent {
  ConnectSocketEvent();
}

class DisConnectSocketEvent extends SocketOfferEvent {
  DisConnectSocketEvent();
}

class SocketDataEvent extends SocketOfferEvent {
  final String type;
  final OrdersStreamModel order;
  final List<SpecialistOffer>? offers;

  SocketDataEvent({
    required this.type,
    required this.order,
    required this.offers,
  });
}
