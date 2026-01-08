import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/main.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/provider/local_provider.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/language_button.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ScreenUtil().setVerticalSpacing(100.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.w),
              child: Image.asset($appType.logoImage),
            ),
            ScreenUtil().setVerticalSpacing(56.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Text(
                context.l10n.presentation_select_language,
                textAlign: TextAlign.center,
                style: Styles.title.copyWith(fontSize: 24),
              ),
            ),
            ScreenUtil().setVerticalSpacing(12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: Text(
                context.l10n.presentation_description,
                textAlign: TextAlign.center,
                style: Styles.descSubtitle.copyWith(color: context.color.grey),
              ),
            ),
            const Spacer(),
            LaguageButton(
              imagePath: 'assets/images/uz.png',
              language: context.l10n.presentation_language_uz,
              onPressed: () {
                final provider = Provider.of<LocalProvider>(
                  context,
                  listen: false,
                );
                provider.setLocale(const Locale("uz"));
                Navigator.of(context).pushNamed(AppRoutes.splashTutorial);
              },
            ),
            ScreenUtil().setVerticalSpacing(10.h),
            LaguageButton(
              imagePath: 'assets/images/ru.png',
              language: context.l10n.presentation_language_ru,
              onPressed: () {
                final provider = Provider.of<LocalProvider>(
                  context,
                  listen: false,
                );
                provider.setLocale(const Locale("ru"));

                Navigator.of(context).pushNamed(AppRoutes.splashTutorial);
              },
            ),
            ScreenUtil().setVerticalSpacing(10.h),
            LaguageButton(
              imagePath: 'assets/images/en.png',
              language: context.l10n.presentation_language_en,
              onPressed: () {
                final provider = Provider.of<LocalProvider>(
                  context,
                  listen: false,
                );
                provider.setLocale(const Locale("en"));
                Navigator.of(context).pushNamed(AppRoutes.splashTutorial);
              },
            ),
            ScreenUtil().setVerticalSpacing(48.h),
          ],
        ),
      ),
    );
  }
}
