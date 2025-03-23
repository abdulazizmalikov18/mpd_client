import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/core/platform/platform_check.dart';

class LoadingDialogWidget extends StatelessWidget {
  const LoadingDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 165.w),
        child: Container(
          height: 65.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
          child: Transform.scale(
            scale: 0.7,
            child: PlatformCheck.platform
                ? CupertinoActivityIndicator(
                    radius: 13.r,
                  )
                : const CircularProgressIndicator(),
          ),
        ));
  }
}
