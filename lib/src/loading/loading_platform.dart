import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/core/platform/platform_check.dart';

class LoadingPlatform extends StatelessWidget {
  const LoadingPlatform({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformCheck.platform
        ? const CupertinoActivityIndicator()
        : Transform.scale(
            scale: 0.8,
            child:  CircularProgressIndicator(
              color: context.color.mainBlue,
              strokeWidth: 2,
            ),
          );
  }
}
