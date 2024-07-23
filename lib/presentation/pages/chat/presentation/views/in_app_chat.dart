import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/widgets/message_widgets/w_message.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/widgets/w_chat_textfield.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
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
    return SizedBox(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leadingWidth: 30,
          title: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return Row(
                children: [
                  WNetworkImage(
                    image: state.groupContainer.activeGroup?.avatar,
                    height: 56,
                    width: 56,
                    borderRadius: 12,
                    defaultWidget: Image.asset(
                      AppImages.userAvatar,
                      width: 56,
                      height: 56,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    state.groupContainer.activeGroup?.name ?? "-",
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.displayLarge.copyWith(
                      color: white,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(right: 8, left: 8, bottom: MediaQuery.of(context).size.height * 0.1),
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) => switch (state.dataStatus) {
              FormzSubmissionStatus.inProgress => Center(
                  child: Lottie.asset(
                    'assets/anim/loading_light.json',
                    height: 32,
                    width: 32,
                  ),
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: MediaQuery.sizeOf(context).width * 0.05),
          child: const WChatTextField(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
