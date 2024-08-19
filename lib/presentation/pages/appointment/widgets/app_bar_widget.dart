import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  final String title;
  final List<Widget>? actions;
  const AppBarWidget({super.key, required this.title, this.actions});

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      centerTitle: false,
      backgroundColor: white,
      titleSpacing: 0,
      elevation: 0,
      leading:const BackButton( color: black),
      title: Text(
        title,
        style: Styles.headline4.copyWith(color: black),
      ),
    );
  }
}
