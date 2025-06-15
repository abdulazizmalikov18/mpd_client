import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/core/pagination/presentation/paginator_list.dart';
import 'package:mpd_client/features/chat/domain/models/chat_group.dart';
import 'package:mpd_client/features/chat/domain/models/message.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat_message/bloc/chat_message_bloc.dart';
import 'package:mpd_client/features/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/features/chat/presentation/widgets/message_widgets/w_message.dart';
import 'package:mpd_client/features/chat/presentation/widgets/w_chat_textfield.dart';

class InChatView extends StatefulWidget {
  final ChatGroupModel group;

  const InChatView({
    super.key,
    required this.group,
  });

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
    context
        .read<ChatMessageBloc>()
        .add(ChatReadAllMessage(widget.group.slugName));

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
                    )
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
                        controller:
                            $chatController.of(context).scrollController,
                        itemCount: state.messages.length,
                        reverse: true,
                        itemBuilder: (context, index) => GestureDetector(
                          onLongPress: () => _showMessageOptions(
                            context,
                            index,
                            state.messages[index],
                          ),
                          child: WMessage(
                            message: state.messages[index],
                          ),
                        ),
                        padding: EdgeInsets.only(top: 16),
                        paginatorStatus: state.status,
                        fetchMoreFunction: () {
                          context
                              .read<ChatMessageBloc>()
                              .add(ChatGetMoreMessages(widget.group));
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
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: context.color.white,
              boxShadow: [
                BoxShadow(
                  color: context.color.black.withValues(alpha: .15),
                  offset: const Offset(0, -4),
                  blurRadius: 12,
                )
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
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            if (message?.text != null && (message?.text ?? "").isNotEmpty)
              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('Copy'),
                onTap: () async {
                  Navigator.pop(context);
                  await Clipboard.setData(
                    ClipboardData(text: message?.text ?? ''),
                  );
                },
              ),
            if (message?.file != null)
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text('Download'),
                onTap: () {
                  Navigator.pop(context);
                  ChatVMController().downloadAndSaveFile(
                    message?.file ?? "",
                    context,
                  );
                },
              ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                // _startEditing(index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                // _deleteMessage(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
