import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

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
            style: AppTheme.bodyMedium.copyWith(fontSize: 20),
          ),
        ),
        WButton(
          onTap: () {
            context.goNamed(AppRouteNames.login);
          },
          text: "Enter",
          margin: const EdgeInsets.symmetric(horizontal: 36),
        ),
      ],
    );
  }
}
