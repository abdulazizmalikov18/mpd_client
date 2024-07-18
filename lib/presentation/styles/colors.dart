import 'package:flutter/rendering.dart';

const green = _green;
const longGrey = _longGrey;
const white = _white;
const black = _black;
const red = _red;
const dark = _dark;
const darkText = _darkText;
const grey = _grey;
const iron = _iron;
const whiteSmoke = _whiteSmoke;
const greyText = _greyText;
const whiteGrey = _whiteGrey;
const blackGrey = _blackGrey;
const blue = _blue;
const lightBlue = _lightBlue;
const shuttleGrey = _shuttleGrey;
const bGrey = _bGrey;
const orang = _orang;
const iconGrey = _iconGrey;
const imageB = _imageB;
const backGroundColor = _backGroundColor;
const inputBlue = _inputBlue;
const scaffoldBackground = _scaffoldBackground;
const scaffoldSecondaryBackground = _scaffoldSecondaryBackground;
const buttonBackgroundColor = _buttonBackgroundColor;
const borderColor = _borderColor;
const secondaryBorderColor = _secondaryBorderColor;
const primary = _primary;
const gray = _gray;
const divider = _divider;
const secondary = _secondary;
const buttonBackgroundGray = _buttonBackgroundGray;
const error = _error;
const mainColor = _main;
const grayLight = _grayLight;
const closeButton = _closeButton;
const cardColor = _cardColor;
const gradientRedOpacity = _gradientRedOpacity;
const gradientBlue = _gradientBlue;
const gradientBlueOpacity = _gradientBlueOpacity;
const yellow = _yellow;
const shadow = _shadow;
const cardShadow = _cardShadow;
final baseColor = _baseColor;
final highlightColor = _highlightColor;
const fillColor = _fillColor;
const orangeLight = _orangeLight;
const transparentBorder = _transparentBorder;
const background = _background;
const yana = _yana;
const mainBlue = _mainBlue;
const border = _border;
const blueBackground = _blueBackground;
const trapezia = _trapezia;
const dividerColor = _dividerColor;
const gradientRed = _gradientRed;
const orange = _orange;

const _transparentBorder = Color(0xFFD5E5FB);
const _grey = Color(0xFF677294);
const _yana = Color(0xFF000000);
const _black = Color(0xFF222222);
const _red = Color(0xFFEA0000);
const _background = Color(0xFFF3F3F3);
const _mainBlue = Color(0xFF3E80FF);
const _white = Color(0xFFFFFFFF);
const _border = Color(0xFFE2E2E2);
const _blueBackground = Color(0xff3e80ff);
const _trapezia = Color(0xFFE6E6E6);
const _dividerColor = Color(0xffF0F0F0);
const _gradientRed = Color(0xFFF41F1F);
const _orange = Color(0xffF2994A);
const _green = Color(0xff27AE60);
const _gradientRedOpacity = Color(0xFFEB5757);
const _gradientBlue = Color(0xFF003CC5);
const _gradientBlueOpacity = Color(0xff00B5D9);
const _yellow = Color(0xFFF4B208);
const _shadow = Color.fromARGB(141, 201, 201, 201);
const _cardShadow = Color(0xff14000000);
final _baseColor = const Color(0xFF3E80FF).withOpacity(0.15);
final _highlightColor = const Color(0xFF3E80FF).withOpacity(0.25);
const _fillColor = Color(0xFFF2F2F2);
const _orangeLight = Color(0xFFFD9644);

const _dark = Color(0xff0C161D);
const _darkText = Color(0xFF262626);
const _greyText = Color(0xFF7F92A0);
const _iron = Color(0xffCCCECF);
const _whiteSmoke = Color(0xffF7F8FC);
const _whiteGrey = Color(0xffF2F2F2);
const _blackGrey = Color(0xff555555);
const _iconGrey = Color(0xff828282);
const _blue = Color(0xff1A79FF);
const _bGrey = Color(0xffEFF0F8);
const _orang = Color(0xFFFD9644);
const _shuttleGrey = Color(0xff606469);
const _imageB = Color(0xffd9d9d9);
const _lightBlue = Color(0xFF706FD3);
const _backGroundColor = Color(0xFFFFFFFF);
const _longGrey = Color(0xffDFE0EB);
const _inputBlue = Color(0xFFD5E5FB);
const _scaffoldBackground = Color(0xFFFFFFFF);
const _scaffoldSecondaryBackground = Color(0xFFFAFAFA);
const _buttonBackgroundColor = Color(0xFFDDFF8F);
const contColor = Color(0xFF142338);
const contBlue = Color.fromRGBO(26, 121, 255, 0.20);
const contGrey = Color(0xFF2C394C);
const _borderColor = Color.fromRGBO(255, 255, 255, 0.2);
const _secondaryBorderColor = Color(0xFFE8EAEC);
const _primary = Color(0xFF1A79FF);
const _gray = Color(0xFF7F92A0);
const _divider = Color(0xFFD8DADC);
const _secondary = Color(0xFF00C1C1);
const _buttonBackgroundGray = Color(0xFFF0F0F0);
const _error = Color(0xFFE74C3C);
const _main = Color(0xFF222222);
const _grayLight = Color(0xFFF3F5F9);
const _closeButton = Color(0xFF16498F);
const _cardColor = Color(0xFF2B394C);

List<BoxShadow> wboxShadow = [
  BoxShadow(
    offset: const Offset(0, 0),
    blurRadius: 22,
    color: blue.withOpacity(.9),
  ),
];

List<BoxShadow> wboxShadowRed = [
  BoxShadow(
    offset: const Offset(0, 0),
    blurRadius: 8,
    spreadRadius: 3,
    color: const Color(0xFFFA193E).withOpacity(.5),
  ),
];
LinearGradient wgradient = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF00B5D9),
    Color(0xFF003CC5),
  ],
);
LinearGradient wgradientRed = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFFA193E),
    Color(0xFF940F25),
  ],
);

RadialGradient radialGradient = RadialGradient(
  transform: const GradientRotation(0.15),
  stops: const [0.1, 5],
  center: Alignment.centerRight,
  radius: 1.5,
  colors: [
    blue.withOpacity(.5),
    backGroundColor.withOpacity(.5),
  ],
);

BoxDecoration wdecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  color: contColor,
);
