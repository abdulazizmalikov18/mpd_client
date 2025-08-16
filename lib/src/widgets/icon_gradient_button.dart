import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';

class IconGradientButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;
  final double height, width;

  const IconGradientButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.height = 50,
    this.width = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 6),
            color: context.color.mainBlue.withValues(alpha: 0.1),
          ),
        ],
        color: context.color.mainBlue,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.zero,
          foregroundColor: Colors.white30,
          backgroundColor: Colors.transparent,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.w),
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(context.color.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
