import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/widgets/w_chat_not_login.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/widgets/w_user_chat_button.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';
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
    context.read<ChatBloc>().add(const GetGroupChat());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WAppBar(
        back: false,
        title: Text('Chat'),
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
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: WTextField(
                          onChanged: (searchText) {
                            context.read<ChatBloc>().add(GroupSearchEvent(search: searchText));
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
    );
  }
}
