import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/chat_bloc.dart';
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
  final BuildContext parentContext;

  const InChatView({super.key, required this.parentContext});

  @override
  State<InChatView> createState() => _InChatViewState();

  static _InChatViewState? of(BuildContext context) => context.findAncestorStateOfType<_InChatViewState>();
}

class _InChatViewState extends State<InChatView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: WAppBar(
        back: true,
        title: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                WNetworkImage(
                  image: state.groupContainer.activeGroup?.avatar,
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
                      state.groupContainer.activeGroup?.name ?? "-",
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
        padding: EdgeInsets.only(right: 8, left: 8, bottom: MediaQuery.viewInsetsOf(context).bottom > 0 ? 80 : 106),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) => switch (state.dataStatus) {
            FormzSubmissionStatus.inProgress => const Center(
                child: CupertinoActivityIndicator(),
              ),
            _ => Align(
                alignment: Alignment.bottomCenter,
                child: PaginatorList(
                  controller: $chatController.of(context).scrollController,
                  itemCount: state.chatContainer.chats.length,
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    return WMessage(
                      message: state.chatContainer.chats[index],
                    );
                  },
                  paginatorStatus: state.dataStatus,
                  fetchMoreFunction: () {
                    context.read<ChatBloc>().add(const GetMoreChatEvent());
                  },
                  hasMoreToFetch: (state.chatContainer.count ?? 0) > state.chatContainer.chats.length,
                ),
              ),
          },
        ),
      ),
      bottomSheet: AnimatedContainer(
        width: double.infinity,
        height: MediaQuery.viewInsetsOf(context).bottom > 0 ? 80 : 106,
        decoration: BoxDecoration(
          color: white,
          boxShadow: [BoxShadow(color: black.withOpacity(.15), offset: const Offset(0, -4), blurRadius: 12)],
        ),
        duration: const Duration(milliseconds: 400),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom > 0 ? 0 : MediaQuery.sizeOf(context).width * 0.05),
          child: const WChatTextField(),
        ),
      ),
    );
  }
}
