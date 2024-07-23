import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/domain/models/chat/chat_user.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';
import 'dart:async';
import 'dart:io';

import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';


typedef $chatController = ChatVMController;

class ChatVMController extends InheritedWidget {
  static final ValueNotifier<String?> chatNotifier = ValueNotifier(null);

  // Fields
  final TextEditingController messageController;

  bool get isMobile => Platform.isAndroid || Platform.isIOS;
  final ScrollController scrollController;

  // Methods
  void createChatAndPush(BuildContext context, {required ChatUserModel user}) {
    // $loading.on(context);
    getBloc(context).add(CreateChatEvent(
      user: user,
      onSuccess: () {
        // $loading.off(context);
        context.pushNamed(AppRouteNames.inChats, extra: context);
      },
      onError: () {
        // $loading.off(context);
      },
    ));
  }

  void pushToGroup(BuildContext context) {
    if (isMobile) {
      getBloc(context).add(const PushToGroupEvent());
    }
    getBloc(context).add(const PushToGroupEvent());
  }

  void pushToGroupChat(BuildContext context) {
    if (isMobile) {
      context.pop();
    }
    getBloc(context).add(const PushToGroupEvent());
  }

  void pushToChat(BuildContext context, {required String? slugName}) {
    Log.i(slugName.toString());
    if (slugName == null) return;
    context.pushNamed(AppRouteNames.inChats, extra: context);
    getBloc(context).add(
      PushToChatEvent(
        slugName: slugName,
      ),
    );
  }

  void getGroups(BuildContext context) {
    context.read<ChatBloc>().add(const GetGroupChat());
  }

  void getMoreGroups() {}

  void sendMessage(BuildContext context) {
    if (messageController.text.trim().isEmpty) return;
    final chatBloc = getBloc(context);
    if (!chatBloc.state.dataStatus.isInProgress) {
      context.read<ChatBloc>().add(
            SendMessageEvent(
              slugName:
                  chatBloc.state.groupContainer.activeGroup?.slugName ?? "-",
              text: messageController.text,
            ),
          );
      messageController.clear();
    }
  }

  void sendMedia(BuildContext context) async {
    final chatBloc = getBloc(context);
    final result = await FilePicker.platform.pickFiles();
    if (result?.files[0].path != null) {
      File file = File(result!.files[0].path!);
      if (context.mounted &&
          chatBloc.state.groupContainer.activeGroup?.slugName != null) {
        chatBloc.add(
          SendMessageEvent(
            slugName: chatBloc.state.groupContainer.activeGroup!.slugName,
            file: file,
            text: messageController.text,
          ),
        );
      }
    }
  }

  void search(BuildContext context, {required String value}) {
    DebounceSearchChat.run(() {
      getBloc(context).add(GroupSearchEvent(search: value));
    });
  }

  ChatBloc getBloc(BuildContext context) => context.read<ChatBloc>();

  const ChatVMController({
    super.key,
    required super.child,
    required this.scrollController,
    required this.messageController,
  });

  static ChatVMController of(BuildContext context) {
    final ChatVMController? result =
        context.dependOnInheritedWidgetOfExactType<ChatVMController>();
    assert(result != null, 'No ChatVMController found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ChatVMController oldWidget) {
    return true;
  }
}

class DebounceSearchChat {
  DebounceSearchChat();

  static int milliseconds = 300;
  static Timer? _timer;

  static void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
