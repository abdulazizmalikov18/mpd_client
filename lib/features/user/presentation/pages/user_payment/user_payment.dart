import 'package:flutter/material.dart';
import 'package:mpd_client/src/widgets/appbar_widget.dart';

class UserPayment extends StatelessWidget {
  const UserPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: 'Payment'),
    );
  }
}
