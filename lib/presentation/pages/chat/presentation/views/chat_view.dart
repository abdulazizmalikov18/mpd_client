import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat_group/chat_group_bloc.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/widgets/w_user_chat_button.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';
import 'package:mpd_client/presentation/widgets/w_paginator.dart';
import 'package:mpd_client/presentation/widgets/w_shimmer.dart';
import 'package:mpd_client/presentation/widgets/w_text_field.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    ChatVMController().connectSocket(
      onError: (errorMessage) {},
    );
    context.read<ChatGroupBloc>().add(const ChatGetGroupEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const WAppBar(
        back: false,
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: WTextField(
              onChanged: (searchText) {
                context.read<ChatGroupBloc>().add(ChatGroupSearchEvent(search: searchText));
              },
              fillColor: background,
              borderColor: Colors.transparent,
              prefixIcon: AppIcons.search.svg(
                color: gray,
              ),
              hintText: 'Search',
              style: AppTheme.bodyLarge.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: black,
              ),
              hintStyle: AppTheme.bodyLarge.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: gray,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ChatGroupBloc, ChatGroupState>(
              builder: (context, state) {
                if (state.status.isInProgress) {
                  return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return const WShimmer(
                        width: double.infinity,
                        height: 60,
                        radius: 0,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 2);
                    },
                    itemCount: 100,
                  );
                }
                if (state.groups.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(),
                        Image.asset(
                          AppImages.chatNotFound,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Chat Not Found',
                          style: AppTheme.bodyLarge.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'The page you are looking\nfor doesn’t exits',
                          textAlign: TextAlign.center,
                          style: AppTheme.bodyLarge.copyWith(fontSize: 18, fontWeight: FontWeight.w400, color: gray),
                        ),
                        const Spacer(),
                      ],
                    ),
                  );
                }
                return RefreshIndicator.adaptive(
                  onRefresh: () async {
                    context.read<ChatGroupBloc>().add(const ChatGetGroupEvent());
                  },
                  child: PaginatorList(
                    paginatorStatus: state.status,
                    itemBuilder: (context, index) => WUserChatButton(
                      onTap: () {
                        context.pushNamed(
                          AppRouteNames.inChats,
                          extra: {"group": state.groups[index]},
                        );
                      },
                      group: state.groups[index],
                    ),
                    itemCount: state.groups.length,
                    fetchMoreFunction: () {},
                    hasMoreToFetch: false,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
