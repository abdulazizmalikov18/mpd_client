// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/chat/domain/models/chat_user_state.dart';
import 'package:mpd_client/features/chat/domain/models/message.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat_message/bloc/chat_message_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


typedef $chatController = ChatVMController;

class ChatVMController {
  WebSocketChannel? channel;
  factory ChatVMController() => instance;
  static final instance = ChatVMController._();
  ChatVMController._()
      : messageController = TextEditingController(),
        scrollController = ScrollController();

  static final ValueNotifier<String?> chatNotifier = ValueNotifier(null);
  final TextEditingController messageController;
  bool get isMobile => Platform.isAndroid || Platform.isIOS;
  final ScrollController scrollController;

  void sendMedia(BuildContext context, String slugName) async {
    final result = await FilePicker.platform.pickFiles();
    if (result?.files[0].path != null) {
      File file = File(result!.files[0].path!);
      if (context.mounted) {
        context.read<ChatMessageBloc>().add(
              ChatSendMessageEvent(
                groupSlug: slugName,
                file: file,
                text: messageController.text,
              ),
            );
      }
    }
  }

  static ChatVMController of(BuildContext context) => ChatVMController();
  Future<void> connectSocket(
      {required void Function(String errorMessage) onError}) async {
    try {
      final wsUrl = Uri.parse(
          "ws://82.215.78.34:80/SMMS/ws/chat/?token=${StorageRepository.getString(StorageKeys.TOKEN)}");
      channel = WebSocketChannel.connect(wsUrl);
      await channel!.ready;
      channel!.stream.asBroadcastStream();
    } catch (e, s) {
      Log.e("ChatSocket Error ------------------------ $e  Stack: $s");
      onError(e.toString());
    }
  }

  Stream get getStream => channel!.stream;

  void onComingNewMessage(void Function(MessageModel message) onMessage) {
    try {
      channel!.stream.listen(
        (event) {
          Log.i("New Chat Message $event \nType${event.runtimeType}");
          final eventData = (jsonDecode(event));
          if (eventData is Map<String, dynamic> &&
              eventData.containsValue("notify_about_message")) {
            Log.i("Message  Keldi");
            onMessage(MessageModel.fromSocket(eventData));
          }
        },
      );
    } catch (e, s) {
      Log.e("error $e Stack $s");
      throw Exception("Modelga o'tkasa olmadi Message");
    }
  }

  void onOnlineOrOffline(void Function(ChatUserState state) onMessage) {
    try {
      channel!.stream.listen(
        (event) {
          Log.i("New Chat Message $event \nType${event.runtimeType}");
          final eventData = (jsonDecode(event));
          if (eventData is Map<String, dynamic> &&
              eventData.containsValue("type") &&
              event['type'] == "online_status") {
            Log.i("Message  Keldi");
            onMessage(ChatUserState.fromJson(eventData));
          }
        },
      );
    } catch (e, s) {
      Log.e("error $e Stack $s");
      throw Exception("Modelga o'tkasa olmadi Message");
    }
  }

  // void onComingNewGroup(void Function(ChatGroupModel grouponMessage) onGroup) {
  //   try {
  //     channel!.stream.listen(
  //       (event) {
  //         Log.i("New Chat Message $event \nType${event.runtimeType}");
  //         final eventData = (jsonDecode(event));
  //         if (eventData is Map<String, dynamic> && eventData.containsValue("notify_about_message")) {
  //           // onMessage(MessageModel.fromSocket(eventData));
  //         }
  //       },
  //     );
  //   } catch (e, s) {
  //     Log.e("error $e Stack $s");
  //     throw Exception("Modelga o'tkasa olmadi Message");
  //   }
  // }
}
