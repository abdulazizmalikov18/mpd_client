import 'package:flutter/material.dart';
import 'package:mpd_client/src/widgets/appbar_widget.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: 'Help center'),
    );
  }
}
