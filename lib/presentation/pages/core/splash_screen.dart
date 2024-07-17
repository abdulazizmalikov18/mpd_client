import 'package:flutter/material.dart';

import '../../styles/style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Style.white,
      body: Center(
        child: SizedBox(
          height: 10,
          width: 10,
        ),
        // Image.asset(
        //   'assets/splash.jpeg',
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height,
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
