import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/presentation/pages/initial/widgets/language_button.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  void goNext(BuildContext context, String lang) {
    context.goNamed(AppRouteNames.onBoarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ScreenUtil().setVerticalSpacing(100.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.w),
              child: Image.asset(AppImages.logo),
            ),
            ScreenUtil().setVerticalSpacing(56.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Text(
                context.l10n.presentation_select_language,
                textAlign: TextAlign.center,
                style: AppTheme.headlineSmall.copyWith(
                  fontSize: 24,
                ),
              ),
            ),
            ScreenUtil().setVerticalSpacing(12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: Text(
                context.l10n.presentation_description,
                textAlign: TextAlign.center,
                style: AppTheme.headlineSmall.copyWith(color: grey),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  LaguageButton(
                    imagePath: 'assets/images/uz.png',
                    language: context.l10n.presentation_language_uz,
                    onPressed: () => goNext(context, 'uz'),
                  ),
                  ScreenUtil().setVerticalSpacing(10.h),
                  LaguageButton(
                    imagePath: 'assets/images/ru.png',
                    language: context.l10n.presentation_language_ru,
                    onPressed: () => goNext(context, 'ru'),

                  ),
                  ScreenUtil().setVerticalSpacing(10.h),
                  LaguageButton(
                    imagePath: 'assets/images/en.png',
                    language: context.l10n.presentation_language_en,
                    onPressed: () => goNext(context, 'en'),

                  ),
                ],
              ),
            ),
            ScreenUtil().setVerticalSpacing(48.h)
          ],
        ),
      ),
    );
  }
}
