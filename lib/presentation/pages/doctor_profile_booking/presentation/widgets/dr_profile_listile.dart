import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class DrProfileListile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconName;
  const DrProfileListile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -4),
      leading: Container(
        alignment: Alignment.center,
        height: 48,
        width: 48,
        decoration: BoxDecoration(shape: BoxShape.circle, color: mainBlue.withOpacity(0.1)),
        child: Image.asset(
          iconName,
          height: 24,
          width: 24,
        ),
      ),
      title: Text(
        title,
        style: Styles.boldTopHint.copyWith(fontSize: 16),
      ),
      subtitle: Text(
        subtitle,
        style: Styles.descSubtitle.copyWith(fontSize: 14, color: grey),
      ),
    );
  }
}
