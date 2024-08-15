import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat_message/bloc/chat_message_bloc.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/views/in_app_chat.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class WChatTextField extends StatelessWidget {
  const WChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMessageBloc, ChatMessageState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextField(
                  controller: ChatVMController().messageController,
                  onEditingComplete: () => context.read<ChatMessageBloc>().add(
                        ChatSendMessageEvent(
                          text: ChatVMController().messageController.text,
                          groupSlug: InChatView.of(context)!.widget.group.slugName,
                        ),
                      ),
                  style: AppTheme.headlineSmall,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 14, left: 16),
                    filled: true,
                    fillColor: background,
                    prefixIcon: WButton(
                      width: 30,
                      color: Colors.transparent,
                      padding: EdgeInsets.zero,
                      border: const Border(),
                      onTap: () => ChatVMController().sendMedia(context, InChatView.of(context)!.widget.group.slugName),
                      child: const Icon(
                        CupertinoIcons.paperclip,
                        color: gray,
                      ),
                    ),
                    hintText: "Type....",
                    hintStyle: AppTheme.headlineSmall.copyWith(
                      color: gray,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: border),
                    ),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            WButton(
              onTap: () => context.read<ChatMessageBloc>().add(
                    ChatSendMessageEvent(
                      text: ChatVMController().messageController.text,
                      groupSlug: InChatView.of(context)!.widget.group.slugName,
                    ),
                  ),
              width: 48,
              height: 48,
              child: AppIcons.send.svg(color: white),
            ),
          ],
        );
      },
    );
  }
}
