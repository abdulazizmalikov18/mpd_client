import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/pages/initial/widgets/language_button.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_bottom_sheet_clipper.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

Map<String, dynamic> languages = {'Uzbek': 'assets/images/uz.png', 'Russian': 'assets/images/ru.png', 'English': 'assets/images/en.png'};
List<Locale> locales = [
  const Locale("uz"),
  const Locale("ru"),
  const Locale("en"),
];

class LanguageSheet extends StatelessWidget {
  const LanguageSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
      children: [
        ScreenUtil().setVerticalSpacing(32.h),
        Center(
          child: Text(
            context.l10n.profile_language,
            style: Styles.boldTitle.copyWith(color: black, fontSize: 24.sp, fontFamily: Styles.gilroyMedium),
          ),
        ),
        ScreenUtil().setVerticalSpacing(12.h),
        Center(
          child: Text(
            context.l10n.profile_choose_language,
            style: Styles.headline7.copyWith(color: grey),
          ),
        ),
        ScreenUtil().setVerticalSpacing(32.h),
        ...List.generate(
            languages.length,
            (index) => Padding(
                  padding: EdgeInsets.only(bottom: index == 2 ? 32.h : 10.h),
                  child: LaguageButton(
                      imagePath: languages.values.elementAt(index),
                      language: languages.keys.elementAt(index),
                      onPressed: () {
                        Future.delayed(const Duration(milliseconds: 300)).then((value) => Navigator.of(context).pop());
                      }),
                ))
      ],
    );
  }
}
