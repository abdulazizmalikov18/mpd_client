part of 'theme.dart';

class FontSet {
  final TextStyle headline3;
  final TextStyle headline1;
  final TextStyle headline2;
  final TextStyle subtitle1;
  final TextStyle subtitle2;
  final TextStyle bodyText1;
  final TextStyle bodyText2;
  final TextStyle caption;

  FontSet._({
    required this.headline3,
    required this.headline1,
    required this.headline2,
    required this.subtitle1,
    required this.subtitle2,
    required this.bodyText1,
    required this.bodyText2,
    required this.caption,
  });

  static FontSet createOrUpdate(CustomColorSet colors) {
    return FontSet._(
      headline1: Style.medium16(size: 16.sp, color: colors.text),
      headline2: Style.bold16(size: 16.sp, color: colors.text),
      headline3: Style.medium20(size: 20.sp, color: colors.text),
      subtitle1: Style.medium14(size: 14.sp, color: colors.text),
      subtitle2: Style.semiBold16(size: 16.sp),
      bodyText1: Style.regular14(size: 14.sp, color: colors.text),
      bodyText2: Style.regular16(size: 16.sp, color: colors.text),
      caption: Style.regular12(size: 12.sp),
    );
  }
}
