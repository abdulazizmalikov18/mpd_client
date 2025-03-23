import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/features/authentication/domain/inherited/auth_notifier.dart';

class AuthUIWidget extends StatelessWidget {
  final Widget child;
  const AuthUIWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          controller: AuthInheritedNotifier.of(context).notifier!.controller,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(height: 352.h),
                  Image.asset('assets/images/topimage.png', height: 290.h, width: double.maxFinite, fit: BoxFit.fill),
                  Positioned(
                    top: 90.h,
                    left: 70.w,
                    right: 70.w,
                    child: Image.asset(
                      AppImages.logo,
                      height: 55.h,
                      width: 250.w,
                      color: context.color.white,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                      top: 177.h,
                      left: 108.w,
                      right: 108.w,
                      child: Image.asset(
                        AppImages.doctorEntry,
                        height: 175.h,
                        width: 175.w,
                      )),
                ],
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
