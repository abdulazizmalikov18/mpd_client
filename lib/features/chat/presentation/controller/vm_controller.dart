// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/extension/context_ext.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/chat/domain/models/chat_user_state.dart';
import 'package:mpd_client/features/chat/domain/models/message.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat_message/bloc/chat_message_bloc.dart';
import 'package:mpd_client/main.dart';
import 'package:mpd_client/src/widgets/custom_snackbar.dart';
import 'package:mpd_client/src/widgets/top_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

typedef $chatController = ChatVMController;

class ChatVMController {
  // ─────────────────────────── Singleton ───────────────────────────
  factory ChatVMController() => instance;
  static final instance = ChatVMController._();
  ChatVMController._()
    : messageController = TextEditingController(),
      scrollController = ScrollController();

  // ─────────────────────────── Socket ───────────────────────────
  WebSocketChannel? channel;
  Stream? _broadcastStream;

  // ─────────────────────────── Controllers ───────────────────────────
  final TextEditingController messageController;
  final ScrollController scrollController;

  // ─────────────────────────── State ───────────────────────────
  static final ValueNotifier<String?> chatNotifier = ValueNotifier(null);

  /// Tanlangan fayllar — UI ga reaktiv ko'rsatish uchun
  final ValueNotifier<List<File>> selectedFiles = ValueNotifier([]);

  /// Picker band ekanligini kuzatish
  Completer<void>? _pickerCompleter;
  bool get _isPickerBusy =>
      _pickerCompleter != null && !_pickerCompleter!.isCompleted;

  bool get isMobile => Platform.isAndroid || Platform.isIOS;

  // ─────────────────────────── Device ───────────────────────────

  Future<bool> _isPhysicalDevice() async {
    try {
      if (Platform.isIOS) {
        final info = await DeviceInfoPlugin().iosInfo;
        return info.isPhysicalDevice;
      }
      return true;
    } catch (_) {
      return true;
    }
  }

  // ─────────────────────────── Permission ───────────────────────────

  /// Simulatorda permission so'ramaymiz — conflict sababi shu edi
  Future<bool> _requestPermission(BuildContext context) async {
    final isPhysical = await _isPhysicalDevice();
    if (!isPhysical) return true;

    PermissionStatus status;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      status = androidInfo.version.sdkInt >= 33
          ? await Permission.photos.request()
          : await Permission.storage.request();
    } else {
      status = await Permission.photos.request();
    }

    if (status.isPermanentlyDenied) {
      if (context.mounted) {
        CustomSnackbar.show(
          context,
          "Galereyaga ruxsat berilmagan. Sozlamalardan yoqing.",
        );
      }
      return false;
    }
    return status.isGranted || status.isLimited;
  }

  // ─────────────────────────── File list ───────────────────────────

  void _addFile(File file) {
    selectedFiles.value = [file];
  }

  void removeFile(File file) {
    final current = List<File>.from(selectedFiles.value);
    current.remove(file);
    selectedFiles.value = current;
  }

  void clearFiles() => selectedFiles.value = [];

  // ─────────────────────────── Rasm tanlash ───────────────────────────

  /// Rasm / Video — ko'p tanlash, barcha qurilmalarda ishlaydi
  void sendImage(BuildContext context, String slugName) async {
    if (_isPickerBusy) return;
    _pickerCompleter = Completer<void>();

    try {
      final hasPermission = await _requestPermission(context);
      if (!hasPermission) return;
      if (!context.mounted) return;

      // ✅ Faqat bitta rasm/video tanlash
      final XFile? result = await ImagePicker().pickMedia();

      if (result != null) {
        _addFile(File(result.path));
      }
    } on PlatformException catch (e) {
      if (e.code == 'multiple_request') {
        Log.w("ImagePicker busy: ignored.");
      } else {
        Log.e("ImagePicker Error: $e");
        if (context.mounted) {
          CustomSnackbar.show(context, "Rasm tanlashda xatolik: ${e.message}");
        }
      }
    } catch (e) {
      Log.e("ImagePicker unexpected: $e");
    } finally {
      _pickerCompleter?.complete();
    }
  }

  // ─────────────────────────── Fayl tanlash ───────────────────────────

  /// Fayl tanlash:
  /// - Simulatorda: ImagePicker (FilePicker simulatorda ishlamaydi)
  /// - Real qurilmada: FilePicker
  void sendMedia(BuildContext context, String slugName) async {
    if (_isPickerBusy) return;
    _pickerCompleter = Completer<void>();

    try {
      final isPhysical = await _isPhysicalDevice();
      final hasPermission = await _requestPermission(context);
      if (!hasPermission) return;
      if (!context.mounted) return;

      await Future.delayed(const Duration(milliseconds: 150));

      if (!isPhysical) {
        // ✅ SIMULYATOR: FilePicker ishlamaydi, ImagePicker ishlatamiz
        Log.w("Simulyator: FilePicker o'rniga ImagePicker ishlatilmoqda.");
        final XFile? result = await ImagePicker().pickMedia();
        if (result != null) {
          _addFile(File(result.path));
        }
      } else {
        // ✅ REAL QURILMA: FilePicker — faqat bitta fayl
        final result = await FilePicker.platform.pickFiles(
          type: FileType.any,
          allowMultiple: false,
        );
        if (result != null && result.files.isNotEmpty) {
          final path = result.files.first.path;
          if (path != null) _addFile(File(path));
        }
      }
    } on PlatformException catch (e) {
      if (e.code == 'multiple_request') {
        Log.w("Picker busy: multiple_request ignored.");
      } else {
        Log.e("Picker Error: $e");
        if (context.mounted) {
          CustomSnackbar.show(context, "Fayl tanlashda xatolik: ${e.message}");
        }
      }
    } catch (e) {
      Log.e("Picker unexpected: $e");
    } finally {
      _pickerCompleter?.complete();
    }
  }

  // ─────────────────────────── Yuborish ───────────────────────────

  /// Tanlangan barcha fayllar + text ni yuborish
  void sendAllFiles(BuildContext context, String slugName) {
    final files = selectedFiles.value;
    final text = messageController.text.trim();

    if (files.isEmpty && text.isEmpty) return;

    if (files.isEmpty) {
      // Faqat text
      context.read<ChatMessageBloc>().add(
        ChatSendMessageEvent(
          groupSlug: slugName,
          file: null,
          text: text,
          isProfanity: () => TopSnackbar.show(context, "Profanity detected"),
        ),
      );
    } else {
      // ✅ Har bir fayl alohida event — birinchisiga text, qolganlari bo'sh
      for (int i = 0; i < files.length; i++) {
        context.read<ChatMessageBloc>().add(
          ChatSendMessageEvent(
            groupSlug: slugName,
            file: files[i],
            text: i == 0 ? text : '', // Faqat birinchisiga text
            isProfanity: () => TopSnackbar.show(context, "Profanity detected"),
          ),
        );
      }
    }

    messageController.clear();
    clearFiles();
  }

  // ─────────────────────────── Bottom sheet ───────────────────────────

  void showFileOptions(BuildContext context, String slugName) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: Text(context.l10n.chat_images),
              onTap: () async {
                Navigator.pop(context);
                // ✅ Bottom sheet yopilish animatsiyasi tugaguncha kutamiz
                await Future.delayed(const Duration(milliseconds: 400));
                if (context.mounted) sendImage(context, slugName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_copy),
              title: Text(context.l10n.chat_files),
              onTap: () async {
                Navigator.pop(context);
                await Future.delayed(const Duration(milliseconds: 400));
                if (context.mounted) sendMedia(context, slugName);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────── Socket ───────────────────────────

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
      _broadcastStream = channel!.stream.asBroadcastStream();
      Log.i("Socket connected successfully");
    } catch (e, s) {
      Log.e("ChatSocket Error: $e Stack: $s");
      onError(e.toString());
    }
  }

  Stream get getStream => _broadcastStream ?? channel!.stream;

  void onComingNewMessage(void Function(MessageModel message) onMessage) {
    try {
      if (channel == null || _broadcastStream == null) {
        Log.e("Channel or broadcast stream is null");
        return;
      }
      _broadcastStream!.listen((event) {
        try {
          final eventData = jsonDecode(event);
          if (eventData is Map<String, dynamic> &&
              eventData.containsValue("notify_about_message")) {
            Log.i("Message keldi");
            onMessage(MessageModel.fromSocket(eventData));
          }
        } catch (e, s) {
          Log.e("Socket parse error: $e Stack: $s");
        }
      });
    } catch (e, s) {
      Log.e("onComingNewMessage error: $e Stack: $s");
    }
  }

  void onOnlineOrOffline(void Function(ChatUserState state) onMessage) {
    try {
      channel!.stream.listen((event) {
        final eventData = jsonDecode(event);
        if (eventData is Map<String, dynamic> &&
            eventData.containsKey("type") &&
            eventData['type'] == "online_status") {
          onMessage(ChatUserState.fromJson(eventData));
        }
      });
    } catch (e, s) {
      Log.e("onOnlineOrOffline error: $e Stack: $s");
    }
  }

  // ─────────────────────────── Download ───────────────────────────

  Future<void> downloadAndSaveFile(String fileUrl, BuildContext context) async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt < 33) {
          final status = await Permission.storage.request();
          if (!status.isGranted) {
            Log.i('Storage ruxsat berilmadi');
            return;
          }
        }
      } else if (Platform.isIOS) {
        final status = await Permission.photos.request();
        if (!status.isGranted) {
          Log.i('iOS ruxsat berilmadi');
          return;
        }
      }

      final Directory directory = Platform.isAndroid
          ? await getExternalStorageDirectory() ??
                await getApplicationDocumentsDirectory()
          : await getApplicationDocumentsDirectory();

      final fullPath = "${directory.path}/${fileUrl.split('/').last}";
      Log.i("Yuklanmoqda: $fullPath");

      await Dio().download(fileUrl, fullPath);

      if (context.mounted) {
        CustomSnackbar.show(context, "✅ Fayl saqlandi");
      }
    } catch (e) {
      Log.e("Download error: $e");
      if (context.mounted) {
        CustomSnackbar.show(context, "❌ Xatolik: $e");
      }
    }
  }
}
