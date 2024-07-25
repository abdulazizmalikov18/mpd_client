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
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

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
        appBar: WAppBar(
          back: false,
          title: const Text('Chat'),
          action: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: WButton(
              color: Colors.transparent,
              height: 40,
              onTap: () {
                context.read<ChatBloc>().add(const GoCreateChatEvent());
                context.pushNamed(AppRouteNames.createChat);
              },
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: AppIcons.plusCircle.svg(color: black)),
            ),
          ),
        ),
        body: StorageRepository.getBool(StorageKeys.ISLOGGED)
            ? BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return CustomScrollView(
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
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
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
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  var group = state.groupContainer.groups[index];
                                  return WUserChatButton(
                                    onTap: () => $chatController.of(context).pushToChat(context, slugName: group.slugName),
                                    group: group,
                                  );
                                },
                                childCount: state.groupContainer.groups.length,
                              ),
                            ),
                    ],
                  );
                },
              )
            : const WChatNotLogin(),
      ),
    );
  }
}
