import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_custom_loading_indicator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 1600), () async {
      if (StorageRepository.getString(StorageKeys.REFRESH).isNotEmpty && StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) {
        context.goNamed(AppRouteNames.home);
      } else {
        context.goNamed(AppRouteNames.selectLang);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 470.h,
            child: Image.asset(
              AppImages.logo,
              width: 250.w,
              height: 55.h,
            ),
          ),
          Positioned(
            bottom: 24.h,
            child: Text(
              '© All rights reserved',
              style: TextStyle(
                color: black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Positioned(
            bottom: 110,
            child: CustomLoadingIndicator(),
          ),
        ],
      ),
    );
  }
}
