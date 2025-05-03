import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/core/pagination/presentation/paginator_list.dart';
import 'package:mpd_client/features/chat/domain/models/chat_group.dart';
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
      body: Padding(
        padding: EdgeInsets.only(
          right: 8,
          left: 8,
          bottom: MediaQuery.viewInsetsOf(context).bottom > 0
              ? kBottomNavigationBarHeight
              : kBottomNavigationBarHeight + 32,
        ),
        child: BlocBuilder<ChatMessageBloc, ChatMessageState>(
          builder: (context, state) => switch (state.status) {
            FormzSubmissionStatus.inProgress => const Center(
                child: CupertinoActivityIndicator(),
              ),
            _ => Align(
                alignment: Alignment.bottomCenter,
                child: PaginatorList(
                  controller: $chatController.of(context).scrollController,
                  itemCount: state.messages.length,
                  reverse: true,
                  itemBuilder: (context, index) => WMessage(
                    message: state.messages[index],
                  ),
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
      bottomSheet: AnimatedContainer(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 8,
          bottom: MediaQuery.viewInsetsOf(context).bottom > 0 ? 8 : 32,
          left: 16,
          right: 16,
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
        duration: const Duration(milliseconds: 200),
        child: const WChatTextField(),
      ),
    );
  }
}
