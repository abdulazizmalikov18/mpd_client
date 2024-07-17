import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class IconAndNumberComp extends StatelessWidget {
  const IconAndNumberComp({
    super.key,
    required this.icon,
    required this.number,
  });

  final String icon;
  final String number;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Row(
        children: [
          SvgPicture.asset(
            icon,
            height: 20,
            width: 20,
            colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
          ),
          4.horizontalSpace,
          Text(
            number,
            textAlign: TextAlign.center,
            style: fonts.headline1,
          ),
          20.horizontalSpace,
        ],
      );
    });
  }
}
