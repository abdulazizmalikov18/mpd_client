import 'package:flutter/material.dart';

extension BuildContextColor on BuildContext {
  AppColors get color => Theme.of(this).extension<AppColors>()!;
}

class AppColors extends ThemeExtension<AppColors> {
  // Basic colors
  Color transparentBorder;
  Color grey;
  Color yana;

  Color black;
  Color red;
  Color background;
  Color mainBlue;
  Color white;
  Color border;
  Color blueBackground;
  Color trapezia;
  Color dividerColor;

  // Extra Colors
  Color gradientRed;
  Color orange;
  Color green;
  Color gradientRedOpacity;
  Color gradientBlue;
  Color gradientBlueOpacity;
  Color yellow;
  Color shadow;
  Color cardShadow;

  // Shimmer Colors
  Color baseColor;
  Color highlightColor;

  // Input decoration color
  Color fillColor;
  Color orangeLight;

  AppColors({
    required this.transparentBorder,
    required this.grey,
    required this.yana,
    required this.black,
    required this.red,
    required this.background,
    required this.mainBlue,
    required this.white,
    required this.border,
    required this.blueBackground,
    required this.trapezia,
    required this.dividerColor,
    required this.gradientRed,
    required this.orange,
    required this.green,
    required this.gradientRedOpacity,
    required this.gradientBlue,
    required this.gradientBlueOpacity,
    required this.yellow,
    required this.shadow,
    required this.cardShadow,
    required this.baseColor,
    required this.highlightColor,
    required this.fillColor,
    required this.orangeLight,
  });

  static final AppColors dark = AppColors(
    transparentBorder: const Color(0xFFD5E5FB),
    grey: const Color(0xFF677294),
    yana: const Color(0xFF000000),
    black: const Color(0xFF222222),
    red: const Color(0xFFEA0000),
    background: const Color(0xFFF3F3F3),
    mainBlue: const Color(0xFF3E80FF),
    white: const Color(0xFFFFFFFF),
    border: const Color(0xFFE2E2E2),
    blueBackground: const Color(0xff3e80ff),
    trapezia: const Color(0xFFE6E6E6),
    dividerColor: const Color(0xffF0F0F0),
    gradientRed: const Color(0xFFF41F1F),
    orange: const Color(0xffF2994A),
    green: const Color(0xff27AE60),
    gradientRedOpacity: const Color(0xFFEB5757),
    gradientBlue: const Color(0xFF003CC5),
    gradientBlueOpacity: const Color(0xff00B5D9),
    yellow: const Color(0xFFF4B208),
    shadow: const Color.fromARGB(141, 201, 201, 201),
    cardShadow: const Color(0xff140000).withValues(alpha: .2),
    baseColor: const Color(0xFF3E80FF).withValues(alpha: 0.15),
    highlightColor: const Color(0xFF3E80FF).withValues(alpha: 0.25),
    fillColor: const Color(0xFFF2F2F2),
    orangeLight: const Color(0xFFFD9644),
  );
  static final AppColors light = AppColors(
    transparentBorder: const Color(0xFFD5E5FB),
    grey: const Color(0xFF677294),
    yana: const Color(0xFF000000),
    black: const Color(0xFF222222),
    red: const Color(0xFFEA0000),
    background: const Color(0xFFF3F3F3),
    mainBlue: const Color(0xFF3E80FF),
    white: const Color(0xFFFFFFFF),
    border: const Color(0xFFE2E2E2),
    blueBackground: const Color(0xff3e80ff),
    trapezia: const Color(0xFFE6E6E6),
    dividerColor: const Color(0xffF0F0F0),
    gradientRed: const Color(0xFFF41F1F),
    orange: const Color(0xffF2994A),
    green: const Color(0xff27AE60),
    gradientRedOpacity: const Color(0xFFEB5757),
    gradientBlue: const Color(0xFF003CC5),
    gradientBlueOpacity: const Color(0xff00B5D9),
    yellow: const Color(0xFFF4B208),
    shadow: const Color.fromARGB(141, 201, 201, 201),
    cardShadow: const Color(0xff140000).withValues(alpha: .1),
    baseColor: const Color(0xFF3E80FF).withValues(alpha: 0.15),
    highlightColor: const Color(0xFF3E80FF).withValues(alpha: 0.25),
    fillColor: const Color(0xFFF2F2F2),
    orangeLight: const Color(0xFFFD9644),
  );

  @override
  ThemeExtension<AppColors> copyWith({
    Color? transparentBorder,
    Color? grey,
    Color? yana,
    Color? black,
    Color? red,
    Color? background,
    Color? mainBlue,
    Color? white,
    Color? border,
    Color? blueBackground,
    Color? trapezia,
    Color? dividerColor,
    Color? gradientRed,
    Color? orange,
    Color? green,
    Color? gradientRedOpacity,
    Color? gradientBlue,
    Color? gradientBlueOpacity,
    Color? yellow,
    Color? shadow,
    Color? cardShadow,
    Color? baseColor,
    Color? highlightColor,
    Color? fillColor,
    Color? orangeLight,
  }) {
    return AppColors(
      transparentBorder: transparentBorder ?? this.transparentBorder,
      grey: grey ?? this.grey,
      yana: yana ?? this.yana,
      black: black ?? this.black,
      red: red ?? this.red,
      background: background ?? this.background,
      mainBlue: mainBlue ?? this.mainBlue,
      white: white ?? this.white,
      border: border ?? this.border,
      blueBackground: blueBackground ?? this.blueBackground,
      trapezia: trapezia ?? this.trapezia,
      dividerColor: dividerColor ?? this.dividerColor,
      gradientRed: gradientRed ?? this.gradientRed,
      orange: orange ?? this.orange,
      green: green ?? this.green,
      gradientRedOpacity: gradientRedOpacity ?? this.gradientRedOpacity,
      gradientBlue: gradientBlue ?? this.gradientBlue,
      gradientBlueOpacity: gradientBlueOpacity ?? this.gradientBlueOpacity,
      yellow: yellow ?? this.yellow,
      shadow: shadow ?? this.shadow,
      cardShadow: cardShadow ?? this.cardShadow,
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
      fillColor: fillColor ?? this.fillColor,
      orangeLight: orangeLight ?? this.orangeLight,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
      covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      transparentBorder:
          Color.lerp(transparentBorder, other.transparentBorder, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      yana: Color.lerp(yana, other.yana, t)!,
      black: Color.lerp(black, other.black, t)!,
      red: Color.lerp(red, other.red, t)!,
      background: Color.lerp(background, other.background, t)!,
      mainBlue: Color.lerp(mainBlue, other.mainBlue, t)!,
      white: Color.lerp(white, other.white, t)!,
      border: Color.lerp(border, other.border, t)!,
      blueBackground: Color.lerp(blueBackground, other.blueBackground, t)!,
      trapezia: Color.lerp(trapezia, other.trapezia, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      gradientRed: Color.lerp(gradientRed, other.gradientRed, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      green: Color.lerp(green, other.green, t)!,
      gradientRedOpacity:
          Color.lerp(gradientRedOpacity, other.gradientRedOpacity, t)!,
      gradientBlue: Color.lerp(gradientBlue, other.gradientBlue, t)!,
      gradientBlueOpacity:
          Color.lerp(gradientBlueOpacity, other.gradientBlueOpacity, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t)!,
      baseColor: Color.lerp(baseColor, other.baseColor, t)!,
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t)!,
      fillColor: Color.lerp(fillColor, other.fillColor, t)!,
      orangeLight: Color.lerp(orangeLight, other.orangeLight, t)!,
    );
  }
}
