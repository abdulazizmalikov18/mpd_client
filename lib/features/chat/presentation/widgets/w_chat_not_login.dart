import 'package:flutter/material.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/features/chat/presentation/widgets/message_widgets/w_button.dart';


class WChatNotLogin extends StatelessWidget {
  const WChatNotLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppIcons.home.svg(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
          child: Text(
            "Sign in Order",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black,
            ),
          ),
        ),
        WButton(
          onTap: () {
            // context.goNamed(AppRouteNames.login);
          },
          text: "Enter",
          margin: const EdgeInsets.symmetric(horizontal: 36),
        ),
      ],
    );
  }
}
