import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class WChatTextField extends StatelessWidget {
  const WChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: TextField(
                controller: $chatController.of(context).messageController,
                onEditingComplete: () => $chatController.of(context).sendMessage(context),
                style: AppTheme.headlineSmall.copyWith(
                  color: white,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 14, left: 16),
                  filled: true,
                  fillColor: white.withOpacity(0.1),
                  prefixIcon: WButton(
                    width: 30,
                    color: Colors.transparent,
                    padding: EdgeInsets.zero,
                    border: const Border(),
                    onTap: () => $chatController.of(context).sendMedia(context),
                    child: AppIcons.back.svg(),
                  ),
                  hintText: "Type....",
                  hintStyle: AppTheme.headlineSmall.copyWith(
                    color: greyText,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: white.withOpacity(0.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: white.withOpacity(0.2)),
                  ),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            WButton(
              onTap: () => $chatController.of(context).sendMessage(context),
              width: 48,
              height: 48,
              child: AppIcons.send.svg(),
            ),
          ],
        );
      },
    );
  }
}
