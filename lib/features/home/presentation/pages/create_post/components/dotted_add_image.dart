import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';

class DottedAddImage extends StatelessWidget {
  final VoidCallback onPressed;
  const DottedAddImage({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(20.r),
          strokeWidth: 2,
          color: Colors.grey,
          dashPattern: const [10, 10],
        ),
        child: InkWell(
          onTap: onPressed,
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          child: SizedBox(
            height: 171.h,
            width: 171.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.gallery,
                  colorFilter:
                      ColorFilter.mode(context.color.mainBlue, BlendMode.srcIn),
                  height: 43.h,
                  width: 43.h,
                ),
                ScreenUtil().setVerticalSpacing(8.h),
                Text(
                  context.l10n.lenth_image_add,
                  textAlign: TextAlign.center,
                  style: Styles.boldHeadline6.copyWith(
                      fontFamily: Styles.gilroyMedium,
                      color: context.color.mainBlue),
                )
              ],
            ),
          ),
        ));
  }
}
