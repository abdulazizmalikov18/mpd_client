import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/theme.dart';


class DrProfileDocument extends StatelessWidget {
  final String title;
  final String iconName;
  final VoidCallback onPressed;
  const DrProfileDocument({
    super.key,
    required this.onPressed,
    required this.title,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      horizontalTitleGap: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Image.asset(iconName, height: 48, width: 48),
      title: Text(title, style: Styles.boldHeadline6),
    );
  }
}
