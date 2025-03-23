import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/provider/local_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../app/app_colors.dart';
import '../../../../../../src/themes/styles.dart';
import '../../../../../../src/widgets/bottom_sheet_widget.dart';
import '../../../../../../src/widgets/language_button.dart';

Map<String, dynamic> languages = {
  'Uzbek': 'assets/images/uz.png',
  'Russian': 'assets/images/ru.png',
  'English': 'assets/images/en.png'
};
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
            style: Styles.boldTitle.copyWith(
                color: context.color.black,
                fontSize: 24.sp,
                fontFamily: Styles.gilroyMedium),
          ),
        ),
        ScreenUtil().setVerticalSpacing(12.h),
        Center(
          child: Text(
            context.l10n.profile_choose_language,
            style: Styles.headline7.copyWith(color: context.color.grey),
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
                        final provider =
                            Provider.of<LocalProvider>(context, listen: false);
                        provider.setLocale(locales[index]);
                        Future.delayed(const Duration(milliseconds: 300))
                            .then((value) => Navigator.of(context).pop());
                      }),
                ))
      ],
    );
  }
}
