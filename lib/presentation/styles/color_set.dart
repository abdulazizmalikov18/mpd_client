part of 'theme.dart';

class CustomColorSet {
  final Color text;
  final Color circularAvatarBackground;
  final Color bottomNavSelectedColor;
  final Color bottomNavUnSelectedColor;
  final Color searchTextfieldColor;
  final Color customBlack;

  final Color bodyText;
  final Color redText;
  final Color customRed;
  final Color customGreen;
  final Color customOrange;
  final Color customGreyC3;
  final Color customGrey9A;
  final Color customGreyE1;

  final Color subText;

  final Color elevatedButton;

  final Color checkColor;
  final Color lightBlack;

  final Color primary;

  final Color white;
  final Color black;
  final Color blue;
  final Color icon;
  final Color dark;
  final Color grey;
  final Color grey1;
  final Color greySecondary;
  final Color grey88;
  final Color backgroundColor;

  final Color backgroundColorVariant;

  final Color secondary;

  final Color lightTextBody;

  final Color error;

  final Color transparent;

  final Color secondaryVariant;

  final Color calendarSelect;

  final Color firstColor;

  final Color yellowStar;

  final Color linkText;
  final Color borderColor;
  final Color iconSelect;
  final Color textV1;
  final Color textV2;
  final Color requestedColor;
  final Color confirmed;
  final Color input;
  final Color softColor;
  final Color dividerColor;
  final Color colorF5F5F5;
  final Color backgroundScaffold;

  CustomColorSet._({
    required this.searchTextfieldColor,
    required this.bottomNavUnSelectedColor,
    required this.bottomNavSelectedColor,
    required this.circularAvatarBackground,
    required this.elevatedButton,
    required this.calendarSelect,
    required this.redText,
    required this.firstColor,
    required this.blue,
    required this.grey1,
    required this.checkColor,
    required this.lightBlack,
    required this.yellowStar,
    required this.borderColor,
    required this.linkText,
    required this.dark,
    required this.secondaryVariant,
    required this.text,
    required this.iconSelect,
    required this.bodyText,
    required this.subText,
    required this.primary,
    required this.white,
    required this.black,
    required this.customRed,
    required this.customGreen,
    required this.customOrange,
    required this.customGreyC3,
    required this.customGrey9A,
    required this.customGreyE1,
    required this.icon,
    required this.grey,
    required this.backgroundColor,
    required this.backgroundColorVariant,
    required this.secondary,
    required this.lightTextBody,
    required this.error,
    required this.transparent,
    required this.textV1,
    required this.textV2,
    required this.confirmed,
    required this.requestedColor,
    required this.input,
    required this.softColor,
    required this.dividerColor,
    required this.colorF5F5F5,
    required this.backgroundScaffold,
    required this.customBlack,
    required this.grey88,
    required this.greySecondary,
  });

  factory CustomColorSet._create(CustomThemeMode mode) {
    final isLight = mode.isLight;

    const circularAvatarBackground = Color(0xffF1F4FA);
    const elevatedButton = Color(0xff4631D2);

    const bottomNavSelectedColor = Color(0xffFCA549);
    const bottomNavUnSelectedColor = Color(0xff64748B);

    final text = isLight ? Style.text : Style.white;

    final bodyText = isLight ? Style.bodyText : Style.white;

    final subText = isLight ? Style.subText : Style.lightTextBody;

    final primary = isLight ? Style.primary : Style.primary;

    const white = Style.white;
    const black = Style.black;
    const customRed = Style.customRed;
    const customGreen = Style.customGreen;
    const customOrange = Style.customOrange;
    const customGreyC3 = Style.customGreyC3;
    const customGrey9A = Style.customGrey9A;
    const customGreyE1 = Style.customGreyE1;
    const blue = Style.blue;

    const icon = Style.icon;

    final grey = isLight ? Style.grey : Style.lightGrey;

    final backgroundColor = isLight ? Style.colorF5F5F5 : Style.text;

    final backgroundColorVariant = isLight ? Style.white : Style.text;

    const secondary = Style.secondary;

    final lightTextBody = isLight ? Style.lightTextBody : Style.text;

    const error = Style.error;

    const transparent = Style.transparent;

    const secondaryVariant = Style.secondaryVariant;

    const linkText = Style.linkText;

    const calendarSelect = Style.secondary;

    const yellowStar = Style.yellowStar;

    const firstColor = Style.firstColor;
    const borderColor = Color(0xffD9D9D9);
    const iconSelect = Style.iconSelect;
    const checkColor = Style.checkColor;
    const redText = Style.redText;

    const grey1 = Style.grey1;
    const dark = Style.dark;
    const lightBlack = Style.lightBlack;
    const textV1 = Style.textV1;
    const textV2 = Style.textV2;
    const requestedColor = Style.requested;
    const confirmed = Style.confirmed;
    const input = Style.input;
    const softColor = Style.softColor;
    const dividerColor = Style.dividerColor;
    const colorF5F5F5 = Style.colorF5F5F5;
    const grey88 = Style.grey88;
    const backgroundScaffold = Style.backgroundScaffold;
    const searchTextfieldColor = Style.searchTextfieldColor;
    const customBlack = Style.customBlack;
    const greySecondary = Style.greySecondary;

    return CustomColorSet._(
      customBlack: customBlack,
      searchTextfieldColor: searchTextfieldColor,
      bottomNavSelectedColor: bottomNavSelectedColor,
      bottomNavUnSelectedColor: bottomNavUnSelectedColor,
      circularAvatarBackground: circularAvatarBackground,
      elevatedButton: elevatedButton,
      text: text,
      black: black,
      customRed: customRed,
      customGreen: customGreen,
      customOrange: customOrange,
      customGreyC3: customGreyC3,
      customGrey9A: customGrey9A,
      customGreyE1: customGreyE1,
      borderColor: borderColor,
      bodyText: bodyText,
      checkColor: checkColor,
      lightBlack: lightBlack,
      iconSelect: iconSelect,
      subText: subText,
      primary: primary,
      white: white,
      redText: redText,
      icon: icon,
      grey: grey,
      grey1: grey1,
      backgroundColor: backgroundColor,
      backgroundColorVariant: backgroundColorVariant,
      secondary: secondary,
      lightTextBody: lightTextBody,
      error: error,
      transparent: transparent,
      secondaryVariant: secondaryVariant,
      linkText: linkText,
      calendarSelect: calendarSelect,
      yellowStar: yellowStar,
      firstColor: firstColor,
      blue: blue,
      dark: dark,
      textV1: textV1,
      textV2: textV2,
      confirmed: confirmed,
      requestedColor: requestedColor,
      input: input,
      softColor: softColor,
      dividerColor: dividerColor,
      colorF5F5F5: colorF5F5F5,
      backgroundScaffold: backgroundScaffold,
      grey88: grey88,
      greySecondary: greySecondary,
    );
  }

  static CustomColorSet createOrUpdate(CustomThemeMode mode) {
    return CustomColorSet._create(mode);
  }
}
