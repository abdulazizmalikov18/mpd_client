// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/chat/domain/models/chat_user_state.dart';
import 'package:mpd_client/features/chat/domain/models/message.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat_message/bloc/chat_message_bloc.dart';
import 'package:mpd_client/main.dart';
import 'package:mpd_client/src/widgets/custom_snackbar.dart';
import 'package:mpd_client/src/widgets/top_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:permission_handler/permission_handler.dart';

typedef $chatController = ChatVMController;

class ChatVMController {
  WebSocketChannel? channel;
  Stream? _broadcastStream;
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
            isProfanity: () {
              TopSnackbar.show(context, "Profanity detected");
            },
          ),
        );
      }
    }
  }

  void sendImage(BuildContext context, String slugName) async {
    final ImagePicker picker = ImagePicker();
    final result = await picker.pickMedia();
    if (result?.path != null) {
      File file = File(result!.path);
      if (context.mounted) {
        context.read<ChatMessageBloc>().add(
          ChatSendMessageEvent(
            groupSlug: slugName,
            file: file,
            text: messageController.text,
            isProfanity: () {
              TopSnackbar.show(context, "Profanity detected");
            },
          ),
        );
      }
    }
  }

  void showFileOptions(BuildContext context, String slugName) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Images'),
              onTap: () {
                Navigator.pop(context);
                sendImage(context, slugName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_copy),
              title: const Text('Files'),
              onTap: () {
                Navigator.pop(context);
                sendMedia(context, slugName);
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.delete, color: Colors.red),
            //   title: const Text('Delete'),
            //   onTap: () {
            //     Navigator.pop(context);
            //     // _deleteMessage(index);
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  static ChatVMController of(BuildContext context) => ChatVMController();
  Future<void> connectSocket({
    required void Function(String errorMessage) onError,
  }) async {
    try {
      final wsUrl = Uri.parse(
        "${$baseUrlSocket}/SMMS/ws/chat/?token=${StorageRepository.getString(StorageKeys.TOKEN)}",
      );
      channel = WebSocketChannel.connect(wsUrl);
      await channel!.ready;
      // Create broadcast stream to allow multiple listeners
      _broadcastStream = channel!.stream.asBroadcastStream();
      Log.i("Socket connected successfully");
    } catch (e, s) {
      Log.e("ChatSocket Error ------------------------ $e  Stack: $s");
      onError(e.toString());
    }
  }

  Stream get getStream => _broadcastStream ?? channel!.stream;

  void onComingNewMessage(void Function(MessageModel message) onMessage) {
    try {
      if (channel == null || _broadcastStream == null) {
        Log.e("Channel or broadcast stream is null, cannot listen to messages");
        return;
      }
      _broadcastStream!.listen((event) {
        Log.i("New Chat Message $event \nType${event.runtimeType}");
        try {
          final eventData = (jsonDecode(event));
          if (eventData is Map<String, dynamic> &&
              eventData.containsValue("notify_about_message")) {
            Log.i("Message  Keldi");
            onMessage(MessageModel.fromSocket(eventData));
          }
        } catch (e, s) {
          Log.e("Error parsing socket message: $e Stack: $s");
        }
      });
    } catch (e, s) {
      Log.e("error $e Stack $s");
      // Don't throw exception, just log the error
      // throw Exception("Modelga o'tkasa olmadi Message");
    }
  }

  void onOnlineOrOffline(void Function(ChatUserState state) onMessage) {
    try {
      channel!.stream.listen((event) {
        Log.i("New Chat Message $event \nType${event.runtimeType}");
        final eventData = (jsonDecode(event));
        if (eventData is Map<String, dynamic> &&
            eventData.containsValue("type") &&
            event['type'] == "online_status") {
          Log.i("Message  Keldi");
          onMessage(ChatUserState.fromJson(eventData));
        }
      });
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

  Future<void> downloadAndSaveFile(String fileUrl, BuildContext context) async {
    try {
      // Ruxsatlar so‘rash
      if (Platform.isAndroid) {
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          Log.i('❌ Storage ruxsat berilmadi');
          return;
        }
      } else if (Platform.isIOS) {
        var status = await Permission.photos.request(); // iOS uchun
        if (!status.isGranted) {
          Log.i('❌ iOS uchun ruxsat berilmadi');
          return;
        }
      }

      // Platformaga qarab saqlash joyini aniqlash
      Directory directory;
      if (Platform.isAndroid) {
        if (await Permission.manageExternalStorage.isGranted) {
          directory = Directory("/storage/emulated/0/Download");
        } else {
          directory =
              await getExternalStorageDirectory() ??
              await getApplicationDocumentsDirectory();
        }
      } else {
        directory = await getApplicationDocumentsDirectory(); // iOS
      }

      String fullPath = "${directory.path}/${fileUrl.split('/').last}";
      Log.i("📥 Yuklanmoqda: $fullPath");

      // Faylni yuklab olish
      Dio dio = Dio();
      await dio.download(fileUrl, fullPath);

      if (context.mounted) {
        CustomSnackbar.show(context, "✅ Fayl saqlandi");
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackbar.show(context, "❌ Xatolik yuz berdi: $e");
      }
    }
  }
}
