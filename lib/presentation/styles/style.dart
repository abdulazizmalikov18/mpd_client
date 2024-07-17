import 'package:flutter/material.dart';

class Style {
  Style._();

  // colors.
  static const Color black = Color(0xff000000);
  static const Color customRed = Color(0xFFD80015);
  static const Color customGreen = Color(0xFF079944);
  static const Color customOrange = Color(0xFFF0801D);
  static const Color customGreyC3 = Color(0xffC3C3C3);
  static const Color customGrey9A = Color(0xFF9A9A9A);
  static const Color customGreyE1 = Color(0xFFE1E1E1);
  static const Color searchTextfieldColor = Color(0xffF5F5F5);
  static const Color customBlack = Color(0xff343435);

  static const Color icon = Color(0xff959189);

  static const Color iconSelect = Color(0xffC79B5E);

  static const Color primary = Color(0xffC10505);

  static const Color lightGrey = Color(0xffFFF7EB);

  static const Color borderColor = Color(0xffE2E6EE);

  static const Color secondary = Color(0xffB3532D);

  static const Color firstColor = Color(0xffF45E3A);

  static const Color secondaryVariant = Color(0xffFFEDE1);

  static const Color yellowStar = Color(0xffF9CD45);

  static const Color error = Color(0xffED2E5C);
  static const Color redText = Color(0xFFEC3A4D);

  static const Color white = Color(0xffffffff);

  static const Color checkColor = Color(0xff3FCB65);

  static const Color blue = Color(0xFF4631D2);

  static const Color text = Color(0xff343435);
  static const Color textV1 = Color(0xFF0A112D);
  static const Color textV2 = Color(0xFF122972);

  static const Color bodyText = Color(0xff8FA0B4);

  static const Color subText = Color(0xffC2C2C2);

  static const Color lightBlack = Color(0xffFAFCFF);

  static const Color linkText = Color(0xff0C5CD4);
  static const Color dark = Color(0xff1D1D1D);
  static const Color grey = Color(0xffF4F3F3);

  static const Color grey1 = Color(0xff9C9191);

  static const Color greySecondary = Color(0xffD7D7DF);

  static const Color lightTextBody = Color(0xffEDEDED);
  static const Color requested = Color(0xff5EC1C7);
  static const Color confirmed = Color(0xFF47AF2B);
  static const Color input = Color(0xffE5ECFC);
  static const Color softColor = Color(0xffFFEDE1);
  static const Color dividerColor = Color(0xffD0D7DE);
  static const Color colorF5F5F5 = Color(0xFFF5F5F5);
  static const Color grey88 = Color(0xFF888888);
  static const Color backgroundScaffold = Color(0xffEBEBEF);

  static const Color transparent = Colors.transparent;

  static const BoxShadow blueIconShadow = BoxShadow(
    color: Color(0x20696A6F),
    blurRadius: 12,
    spreadRadius: 2,
  );

  static const BoxShadow bottomShadow = BoxShadow(
    color: Color(0x20696A6F),
    blurRadius: 4,
    spreadRadius: 2,
    offset: Offset(0.0, 4.0),
  );

  static TextStyle regular24({double size = 24, Color color = text}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
      fontFamily: 'NunitoSans',
    );
  }

  static TextStyle regular16({double size = 16, Color color = text}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
      fontFamily: 'NunitoSans',
    );
  }

  static TextStyle regular14({double size = 14, Color color = text}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontFamily: 'NunitoSans',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle regular12({double size = 12, Color color = text}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
      fontFamily: 'NunitoSans',
    );
  }

  static TextStyle medium20({double size = 20, Color color = text}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
      fontFamily: 'NunitoSans',
    );
  }

  static TextStyle medium16({double size = 16, Color color = text}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
      fontFamily: 'NunitoSans',
    );
  }

  static TextStyle medium14({double size = 14, Color color = text}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
      fontFamily: 'NunitoSans',
    );
  }

  static TextStyle semiBold16({double size = 16, Color color = text}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w600,
      fontFamily: 'NunitoSans',
    );
  }

  static TextStyle semiBold14({double size = 14, Color color = text}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w600,
      fontFamily: 'NunitoSans',
    );
  }

  static TextStyle bold20({double size = 20, Color color = text}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w700,
      fontFamily: 'NunitoSans',
    );
  }

  static TextStyle bold16({double size = 16, Color color = text}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w700,
      fontFamily: 'NunitoSans',
    );
  }
}
