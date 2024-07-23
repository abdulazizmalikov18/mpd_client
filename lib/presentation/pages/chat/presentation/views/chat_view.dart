import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/widgets/w_chat_not_login.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/widgets/w_user_chat_button.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ValueNotifier<bool> createChatHover = ValueNotifier(false);
  ValueNotifier<bool> createGroupHover = ValueNotifier(false);

  @override
  void initState() {
    context.read<ChatBloc>().add(const GetGroupChat());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: WAppBar(
          title: const Text('Chat'),
          action: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: WButton(
              height: 40,
              onTap: () {
                context.read<ChatBloc>().add(const GoCreateChatEvent());
                context.pushNamed(AppRouteNames.createChat);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    // AppIcons.add.svg(),
                    Text(
                      "New Chat",
                      style: AppTheme.headlineSmall.copyWith(
                        color: white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: StorageRepository.getBool(StorageKeys.ISLOGGED)
            ? BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: CustomScrollView(
                      slivers: [
                        CupertinoSliverRefreshControl(
                          onRefresh: () async {
                            $chatController.of(context).getGroups(context);
                            await Future.delayed(const Duration(seconds: 1));
                          },
                          refreshTriggerPullDistance: 50,
                          refreshIndicatorExtent: 30,
                        ),
                        state.groupContainer.groups.isEmpty
                            ? SliverToBoxAdapter(
                                child: SizedBox(
                                  height: MediaQuery.sizeOf(context).height * 0.7,
                                  // child: Center(
                                  //   child: Lottie.asset("assets/anim/anim_chat.json"),
                                  // ),
                                ),
                              )
                            : SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    var group = state.groupContainer.groups[index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: BlocBuilder<ChatBloc, ChatState>(
                                        builder: (context, state) {
                                          return WUserChatButton(
                                            onTap: () => $chatController.of(context).pushToChat(context, slugName: group.slugName),
                                            group: group,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  childCount: state.groupContainer.groups.length,
                                ),
                              ),
                      ],
                    ),
                  );
                },
              )
            : const WChatNotLogin(),
      ),
    );
  }
}
