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

const _white = Color(0xffFFFFFF);
const _black = Color(0xFF000000);
const _dark = Color(0xff0C161D);
const _darkText = Color(0xFF262626);
const _red = Color(0xffFA193E);
const _grey = Color(0xffE7E7E8);
const _greyText = Color(0xFF7F92A0);
const _iron = Color(0xffCCCECF);
const _green = Color(0xff2BCBBA);
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
    Color(0xFF4D97FF),
    Color(0xFF1A79FF),
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
