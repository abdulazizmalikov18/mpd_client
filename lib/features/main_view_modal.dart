import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/features/home/domain/blocs/socket_offer_bloc/socket_offer_bloc.dart';

class MainViewModal {
  Future<void> screenController(
    AppLifecycleState state,
    BuildContext context,
    username,
  ) async {
    switch (state) {
      case AppLifecycleState.paused: // screen off/navigate away
        {
          break;
        }
      case AppLifecycleState.resumed:
        {
          context.read<SocketOfferBloc>().add(ConnectSocketEvent());
          break;
        }
      case AppLifecycleState.inactive: // screen off/navigate away
        {
          break;
        }
      case AppLifecycleState.detached:
        {
          break;
        }
      case AppLifecycleState.hidden:
        {
          //context.read<SocketOfferBloc>().add(DisConnectSocketEvent());
          break;
        }
    }
  }

  void initState(BuildContext context) async {
    context.read<SocketOfferBloc>().add(ConnectSocketEvent());
  }
}
