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
import 'package:mpd_client/features/chat/presentation/widgets/w_chat_textfield.dart';
import 'package:mpd_client/features/user/domain/blocs/user_info/user_info_bloc.dart';

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
    context.read<ChatMessageBloc>().add(ChatGetMessages(widget.group));
    context.read<ChatMessageBloc>().add(
      ChatReadAllMessage(widget.group.slugName),
    );

    super.initState();
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
                  if (message?.sender != null)
                    CupertinoListTile(
                      leading: AppIcons.userMinus.svg(color: red),
                      title: const Text('Block User', style: TextStyle(color: red)),
                      backgroundColor: white,
                      onTap: () {
                        Navigator.pop(context);
                        _showBlockUserDialog(context, message!.sender!);
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
  if (message?.id == null) return;

  await ReportMessageDialog.show(
    context,
    onReportSubmitted: (reason) async {
      if (context.mounted) {
        try {
          context.read<ChatMessageBloc>().add(
            ChatReportMessageEvent(
              messageId: message!.id!,
              reason: reason,
              onSuccess: () {
                ReportConfirmationDialog.show(context);
              },
              onError: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $error')),
                );
              },
            ),
          );
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to report message')),
            );
          }
        }
      }
    },
  );
}

Future<void> _showBlockUserDialog(
  BuildContext context,
  String username,
) async {
  final shouldBlock = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Block User'),
      content: Text(
        'Are you sure you want to block $username? You will no longer see their messages or posts.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          style: TextButton.styleFrom(
            foregroundColor: red,
          ),
          child: const Text('Block'),
        ),
      ],
    ),
  );

  if (shouldBlock == true && context.mounted) {
    try {
      context.read<ChatMessageBloc>().add(
        ChatBlockUserEvent(
          username: username,
          onSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User blocked successfully')),
            );
          },
          onError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $error')),
            );
          },
        ),
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to block user')),
        );
      }
    }
  }
}
