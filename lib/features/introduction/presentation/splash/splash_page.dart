import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 1600), () async {
      if (StorageRepository.getString(StorageKeys.REFRESH).isNotEmpty &&
          StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutes.mainPage, (route) => false);
      } else {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutes.splashLanguage, (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: context.color.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 470.h,
              child: Image.asset(AppImages.logo, width: 250.w, height: 55.h),
            ),
            Positioned(
              bottom: 24.h,
              child: Text(
                '© All rights reserved',
                style: TextStyle(
                  color: context.color.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Positioned(
              bottom: 110,
              child: SpinKitCircle(size: 52, color: context.color.mainBlue),
            ),
          ],
        ),
      ),
    );
  }
}
