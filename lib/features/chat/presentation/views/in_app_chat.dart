import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/core/pagination/presentation/paginator_list.dart';
import 'package:mpd_client/features/chat/domain/models/chat_group.dart';
import 'package:mpd_client/features/chat/domain/models/message.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat_message/bloc/chat_message_bloc.dart';
import 'package:mpd_client/features/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/features/chat/presentation/widgets/message_widgets/w_message.dart';
import 'package:mpd_client/features/chat/presentation/widgets/report_message_dialog.dart';
import 'package:mpd_client/features/chat/presentation/widgets/block_user_dialog.dart';
import 'package:mpd_client/features/chat/presentation/widgets/w_chat_textfield.dart';
import 'package:mpd_client/features/user/domain/blocs/user_info/user_info_bloc.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/extension/context_ext.dart';

class InChatView extends StatefulWidget {
  final ChatGroupModel group;

  const InChatView({super.key, required this.group});

  @override
  State<InChatView> createState() => _InChatViewState();

  // ignore: library_private_types_in_public_api
  static _InChatViewState? of(BuildContext context) =>
      context.findAncestorStateOfType<_InChatViewState>();
}

class _InChatViewState extends State<InChatView> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<ChatMessageBloc>().add(ChatGetMessages(widget.group));
    context.read<ChatMessageBloc>().add(
      ChatReadAllMessage(widget.group.slugName),
    );

    // Initialize message listener only if channel is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chatController = ChatVMController();
      if (chatController.channel != null) {
        context.read<ChatMessageBloc>().onComingMessage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.background,
      appBar: AppBar(
        titleSpacing: 0,
        title: BlocBuilder<ChatMessageBloc, ChatMessageState>(
          builder: (context, state) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SizedBox(
                height: 40,
                width: 40,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: mainBlue.withValues(alpha: 0.1),
                      backgroundImage: CachedNetworkImageProvider(
                        AppImages.networkAvatar,
                      ),
                      foregroundImage: CachedNetworkImageProvider(
                        widget.group.avatar,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor:
                            widget.group.isOnline && (widget.group.isUserToUser)
                            ? context.color.green
                            : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              title: Text(
                widget.group.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: black,
                ),
              ),
              subtitle: Text(
                "Unknown period",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: context.color.grey,
                ),
              ),
            );
          },
        ),
        actions: widget.group.isUserToUser
            ? [
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: black),
                  onSelected: (value) {
                    if (value == 'block') {
                      final blockedUsers = StorageRepository.getString(
                        StorageKeys.BLOCKED_USERS,
                      );
                      final isBlocked = blockedUsers
                          .split(',')
                          .contains(widget.group.slugName);
                      BlockUserDialog.show(
                        context,
                        username: widget.group.slugName,
                        userName: widget.group.name,
                        isBlocked: isBlocked,
                        onBlocked: () {
                          // Refresh chat list or navigate back
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<String>(
                      value: 'block',
                      child: Row(
                        children: [
                          Icon(Icons.block, color: context.color.red, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            context.l10n.block_user,
                            style: TextStyle(color: context.color.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]
            : null,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BlocBuilder<ChatMessageBloc, ChatMessageState>(
                builder: (context, state) => switch (state.status) {
                  FormzSubmissionStatus.inProgress => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  _ => Align(
                    alignment: Alignment.bottomCenter,
                    child: PaginatorList(
                      controller: $chatController.of(context).scrollController,
                      itemCount: state.messages.length,
                      reverse: true,
                      itemBuilder: (context, index) => GestureDetector(
                        onLongPress: () => _showMessageOptions(
                          context,
                          index,
                          state.messages[index],
                          (state.messages[index].sender ==
                              context
                                  .read<UserInfoBloc>()
                                  .state
                                  .userInfo
                                  ?.username),
                        ),
                        child: WMessage(message: state.messages[index]),
                      ),
                      padding: EdgeInsets.only(top: 16),
                      paginatorStatus: state.status,
                      fetchMoreFunction: () {
                        context.read<ChatMessageBloc>().add(
                          ChatGetMoreMessages(widget.group),
                        );
                      },
                      hasMoreToFetch: (state.count) > state.messages.length,
                    ),
                  ),
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: context.color.white,
              boxShadow: [
                BoxShadow(
                  color: context.color.black.withValues(alpha: .15),
                  offset: const Offset(0, -4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: SafeArea(child: const WChatTextField()),
          ),
        ],
      ),
    );
  }

  void _showMessageOptions(
    BuildContext context,
    int index,
    MessageModel? message,
    bool isUserToUser,
  ) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: grey,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                children: [
                  if (message?.text != null && (message?.text ?? "").isNotEmpty)
                    CupertinoListTile(
                      leading: AppIcons.copy.svg(),
                      title: const Text('Copy'),
                      backgroundColor: white,
                      onTap: () async {
                        Navigator.pop(context);
                        await Clipboard.setData(
                          ClipboardData(text: message?.text ?? ''),
                        );
                      },
                    ),
                  if (message?.file != null)
                    CupertinoListTile(
                      leading: AppIcons.download.svg(),
                      title: const Text('Download'),
                      backgroundColor: white,
                      onTap: () {
                        Navigator.pop(context);
                        ChatVMController().downloadAndSaveFile(
                          message?.file ?? "",
                          context,
                        );
                      },
                    ),
                  if (isUserToUser)
                    CupertinoListTile(
                      leading: AppIcons.pencil.svg(),
                      title: const Text('Edit'),
                      backgroundColor: white,
                      onTap: () {
                        Navigator.pop(context);
                        // _startEditing(index);
                      },
                    ),
                  if (!isUserToUser)
                    CupertinoListTile(
                      leading: AppIcons.messageCircleWarning.svg(color: red),
                      title: const Text('Report', style: TextStyle(color: red)),
                      backgroundColor: white,
                      onTap: () {
                        Navigator.pop(context);
                        _showReportDialog(context, message);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showReportDialog(
  BuildContext context,
  MessageModel? message,
) async {
  await ReportMessageDialog.show(
    context,
    onReportSubmitted: (reason) async {
      // Here you can handle the report submission
      // For example, you can call an API to report the message
      // await context.read<ChatMessageBloc>().add(ReportMessage(
      //   messageId: message?.id ?? '',
      //   reason: reason,
      // ));

      // Show confirmation dialog

      await ReportConfirmationDialog.show(context);
    },
  );
}
