import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/infrastructure/core/scope.dart';
import 'package:mpd_client/presentation/pages/initial/widgets/language_button.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_bottom_sheet_clipper.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

Map<String, dynamic> languages = {
  'Uzbek': 'assets/images/uz.png',
  'Russian': 'assets/images/ru.png',
  'English': 'assets/images/en.png',
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
        const SizedBox(height: 32),
        Center(
          child: Text(
            context.l10n.profile_language,
            style: Styles.boldTitle.copyWith(
                color: black, fontSize: 24.sp, fontFamily: Styles.gilroyMedium),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            context.l10n.profile_choose_language,
            style: Styles.headline7.copyWith(color: grey),
          ),
        ),
        const SizedBox(height: 32),
        ...List.generate(
          languages.length,
          (index) => Padding(
            padding: EdgeInsets.only(
                bottom: index == 2 ? 32 : 10, left: 16, right: 16),
            child: LaguageButton(
              imagePath: languages.values.elementAt(index),
              language: languages.keys.elementAt(index),
              onPressed: () async {
                await AppScope.update(
                  context,
                  AppScope(locale: locales[index]),
                );
                Future.delayed(const Duration(milliseconds: 300)).then((value) {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
