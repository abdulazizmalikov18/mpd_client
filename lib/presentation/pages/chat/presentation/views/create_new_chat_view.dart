import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formz/formz.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';
import 'package:mpd_client/presentation/widgets/w_network_image.dart';
import 'package:mpd_client/presentation/widgets/w_paginator.dart';
import 'package:mpd_client/presentation/widgets/w_text_field.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class CreateNewChatView extends StatefulWidget {
  const CreateNewChatView({super.key});

  @override
  State<CreateNewChatView> createState() => _CreateNewChatViewState();
}

class _CreateNewChatViewState extends State<CreateNewChatView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const WAppBar(
          title: Text('Add'),
          action: SizedBox(),
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: WTextField(
                onChanged: (_) {},
                fillColor: white.withOpacity(0.1),
                borderColor: white.withOpacity(0.2),
                prefixIcon: AppIcons.search.svg(),
                hintStyle: AppTheme.bodyLarge,
                style: AppTheme.bodyLarge,
                hintText: "Search",
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return PaginatorList(
                    itemCount: state.usersContainer.users.length,
                    itemBuilder: (context, index) {
                      final user = state.usersContainer.users[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
                        child: GestureDetector(
                          onTap: () {
                            $chatController.of(context).createChatAndPush(context, user: user);
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  WNetworkImage(
                                    image: user.avatar,
                                    height: 56,
                                    width: 56,
                                    borderRadius: 16,
                                    defaultWidget: Image.asset(
                                      AppImages.userAvatar,
                                      height: 56,
                                      width: 56,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${user.name} ${user.lastname}",
                                        style: AppTheme.displayLarge,
                                      ),
                                      Text(
                                        user.job.isNotEmpty ? user.job : "No job",
                                        style: AppTheme.displayLarge.copyWith(fontSize: 10, color: white.withOpacity(0.5)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    paginatorStatus: FormzSubmissionStatus.initial,
                    fetchMoreFunction: () {},
                    hasMoreToFetch: false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
