import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/domain/models/chat/chat_group.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat_message/bloc/chat_message_bloc.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/widgets/message_widgets/w_message.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/widgets/w_chat_textfield.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';
import 'package:mpd_client/presentation/widgets/w_network_image.dart';
import 'package:mpd_client/presentation/widgets/w_paginator.dart';

class InChatView extends StatefulWidget {
  final ChatGroupModel group;

  const InChatView({
    super.key,
    required this.group,
  });

  @override
  State<InChatView> createState() => _InChatViewState();

  // ignore: library_private_types_in_public_api
  static _InChatViewState? of(BuildContext context) => context.findAncestorStateOfType<_InChatViewState>();
}

class _InChatViewState extends State<InChatView> {
  bool isLoading = false;

  @override
  void initState() {
    context.read<ChatMessageBloc>().add(ChatGetMessages(widget.group));
    context.read<ChatMessageBloc>().add(ChatReadAllMessage(widget.group.slugName));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: WAppBar(
        back: true,
        title: BlocBuilder<ChatMessageBloc, ChatMessageState>(
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                WNetworkImage(
                  image: widget.group.avatar,
                  height: 40,
                  width: 40,
                  borderRadius: 12,
                  defaultWidget: Image.asset(
                    AppImages.userAvatar,
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.group.name,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.displayLarge,
                    ),
                    Text(
                      "1 min ago",
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.displayLarge.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: gray,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: 8,
          left: 8,
          bottom: MediaQuery.viewInsetsOf(context).bottom > 0 ? kBottomNavigationBarHeight : kBottomNavigationBarHeight + 24,
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
                itemBuilder: (BuildContext context, int index) {
                  return WMessage(
                    message: state.messages[index],
                  );
                },
                paginatorStatus: state.status,
                fetchMoreFunction: () {
                  context.read<ChatMessageBloc>().add(ChatGetMoreMessages(widget.group));
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
          color: white,
          boxShadow: [BoxShadow(color: black.withOpacity(.15), offset: const Offset(0, -4), blurRadius: 12)],
        ),
        duration: const Duration(milliseconds: 200),
        child: const WChatTextField(),
      ),
    );
  }
}
