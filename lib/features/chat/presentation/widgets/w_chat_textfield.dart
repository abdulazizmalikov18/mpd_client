import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat_message/bloc/chat_message_bloc.dart';
import 'package:mpd_client/features/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/features/chat/presentation/views/in_app_chat.dart';
import 'package:mpd_client/features/chat/presentation/widgets/message_widgets/w_button.dart';
import 'package:mpd_client/src/widgets/top_snackbar.dart';

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
                  // onEditingComplete: () => context.read<ChatMessageBloc>().add(
                  //       ChatSendMessageEvent(
                  //         text: ChatVMController().messageController.text,
                  //         groupSlug:
                  //             InChatView.of(context)!.widget.group.slugName,
                  //       ),
                  //     ),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  keyboardType: TextInputType.multiline,
                  // textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 14, left: 16),
                    filled: true,
                    fillColor: background,
                    prefixIcon: WButton(
                      width: 30,
                      color: Colors.transparent,
                      padding: EdgeInsets.zero,
                      border: const Border(),
                      onTap: () => ChatVMController().showFileOptions(
                        context,
                        InChatView.of(context)!.widget.group.slugName,
                      ),
                      child: const Icon(CupertinoIcons.paperclip, color: gray),
                    ),
                    hintText: "Type....",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
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
                  isProfanity: () {
                    TopSnackbar.show(context, "Profanity detected");
                  },
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
