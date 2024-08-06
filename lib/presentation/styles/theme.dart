import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

abstract class AppTheme {
  static ThemeData theme() => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Museo_Sans_Cyrl',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            // ios
            statusBarBrightness: Brightness.dark,
            // android
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          titleTextStyle: displaySmall.copyWith(fontWeight: FontWeight.w600),
          centerTitle: false,
          iconTheme: const IconThemeData(color: white),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        unselectedWidgetColor: Colors.black,
        dividerTheme: DividerThemeData(color: white.withOpacity(.2)),
        bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
        textTheme: const TextTheme(
          displayLarge: displayLarge,
          displayMedium: displayMedium,
          displaySmall: displaySmall,
          headlineMedium: headlineMedium,
          headlineSmall: headlineSmall,
          titleLarge: titleLarge,
          bodyLarge: bodyLarge,
          bodyMedium: bodyMedium,
          titleMedium: titleMedium,
          titleSmall: titleSmall,
          bodySmall: bodySmall,
          labelLarge: labelLarge,
          labelSmall: labelSmall,
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: blue,
          secondary: blue,
          error: red,
          surface: blue,
          onPrimary: blue,
          onSecondary: blue,
          onError: red,
          onSurface: blue,
        ),
        tabBarTheme: const TabBarTheme(
          dividerColor: Colors.transparent,
        ),
      );

  // Fonts
  static const displayLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: black,
  );
  static const displayMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: black,
  );
  static const displaySmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: black,
  );
  static const headlineMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: black,
  );
  static const headlineSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: black,
  );
  static const titleLarge = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: black,
  );
  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: black,
  );

  static const bodyMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: black,
  );

  static const titleMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: black,
  );

  static const titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: black,
  );

  static const bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: black,
  );

  static const labelLarge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: black,
    letterSpacing: -0.1,
  );

  static const labelSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: black,
    letterSpacing: -0.1,
  );
}





class Styles {
  Styles._();

  static const String gilroyLight = 'Gilroy Light';
  static const String gilroyRegular = 'Gilroy Regular';
  static const String gilroyMedium = 'Gilroy Medium';

  static TextStyle postTitle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: gilroyMedium,
  );
  static TextStyle postSubtitle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
    fontFamily: gilroyMedium,
  );
  static TextStyle expTitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    fontFamily: gilroyMedium,
    height: 1.3,
  );

  static TextStyle boldTitle = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    height: 1.4,
    fontFamily: gilroyMedium,
  );

  static TextStyle boldHeadline6 = TextStyle(
    fontFamily: gilroyMedium,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
  );

  static TextStyle descSubtitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: gilroyMedium,
    height: 1.3,
  );
  static TextStyle boldTopHint = TextStyle(
    fontFamily: gilroyMedium,
    fontWeight: FontWeight.w500,
    fontSize: 15.sp,
  );

  static TextStyle headline7 = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    fontFamily: gilroyMedium,
  );

  static TextStyle headline7Bold = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    fontFamily: gilroyMedium,
  );

  static TextStyle title = TextStyle(
    fontSize: 23.sp,
    fontWeight: FontWeight.w700,
    fontFamily: gilroyMedium,
  );

  static TextStyle headline6 = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    fontFamily: gilroyMedium,
  );

  static TextStyle headline5 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    fontFamily: gilroyMedium,
  );

  static TextStyle headline8 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w300,
    fontFamily: gilroyMedium,
  );

  static TextStyle semiboldTitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: gilroyMedium,
  );

  static TextStyle emptyboldTitle = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    fontFamily: gilroyMedium,
  );

  static TextStyle headline4 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    fontFamily: gilroyMedium,
    // color: context.color.black,
  );

  static TextStyle headline7Sp14 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    fontFamily: gilroyMedium,
    // color: context.color.mainBlue,
  );
  static TextStyle bottomLabel = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: gilroyMedium,
  );
  static TextStyle cardReview = TextStyle(
    fontSize: 8.sp,
    fontWeight: FontWeight.w300,
    fontFamily: gilroyMedium,
  );
}
