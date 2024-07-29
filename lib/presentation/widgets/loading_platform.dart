import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class LoadingPlatform extends StatelessWidget {
  const LoadingPlatform({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoActivityIndicator()
        : Transform.scale(
            scale: 0.8,
            child:  const CircularProgressIndicator(
              color: mainBlue,
              strokeWidth: 2,
            ),
          );
  }
}
