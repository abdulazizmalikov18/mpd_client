import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class GradientIcon extends StatelessWidget {
  final String iconName;
  final double size;
  const GradientIcon({
    super.key,
    this.size = 18,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return  RadialGradient(
          center: Alignment.topLeft,
          radius: 2,
          colors: const [gradientBlueOpacity, gradientBlue],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: SvgPicture.asset(
        iconName,
        height: size.h,
        width: size.h,
        colorFilter:  const ColorFilter.mode(white, BlendMode.srcIn),
      ),
    );
  }
}
