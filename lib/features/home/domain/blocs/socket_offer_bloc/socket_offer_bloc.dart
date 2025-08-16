import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/home/data/models/order_stream_model.dart';
import 'package:mpd_client/features/home/data/models/specialist_offer_model.dart';
import 'package:mpd_client/features/home/data/models/specialist_order_model.dart';
import 'package:web_socket_channel/io.dart';

part 'socket_offer_event.dart';
part 'socket_offer_state.dart';

class SocketOfferBloc extends Bloc<SocketOfferEvent, SocketOfferState> {
  IOWebSocketChannel? socketChannel;
  SocketOfferBloc() : super(const SocketOfferState()) {
    on<SocketDataEvent>((event, emit) {
      List<OrdersStreamModel> orders = List.from(state.orders);
      orders.insert(0, event.order);
      emit(
        state.copyWith(
          order: event.order.message,
          orders: orders,
          offers: event.offers,
          type: event.type,
        ),
      );
    });
    on<ConnectSocketEvent>((event, emit) {
      final socketURl = Uri.parse(
        "wss://sharq-api.sharqdarmon.uz/OMS/ws/work/?specialist_id=942&org_slug=mpd&lang=ru",
      );
      socketChannel = IOWebSocketChannel.connect(socketURl);
      emit(state.copyWith(isConnect: true, type: "null"));
      final stream = socketChannel!.stream.asBroadcastStream();
      stream.listen(
        (event) {
          Log.e("Connection Socket ");

          final data = jsonDecode(event);
          switch (data['type']) {
            case 'order-create':
              {
                OrdersStreamModel order = OrdersStreamModel.fromJson(data);
                add(
                  SocketDataEvent(
                    type: 'order-create',
                    offers: state.offers,
                    order: order,
                  ),
                );
                break;
              }
            case 'order-update':
              {
                OrdersStreamModel order = OrdersStreamModel.fromJson(data);
                add(
                  SocketDataEvent(
                    type: 'order-update',
                    offers: state.offers,
                    order: order,
                  ),
                );
                break;
              }
          }
        },
        onError: (e) {
          Log.e("Connection onError ");
          socketChannel = IOWebSocketChannel.connect(socketURl);
        },
        onDone: () {
          Log.e("Connection onDone ");
        },
      );
    });

    on<DisConnectSocketEvent>((event, emit) {
      socketChannel?.sink.close();
      emit(state.copyWith(isConnect: false, type: "null"));
    });
  }
}
