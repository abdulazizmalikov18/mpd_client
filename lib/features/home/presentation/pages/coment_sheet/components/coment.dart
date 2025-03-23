import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';

class ComentWidget extends StatelessWidget {
  final int? comentCount;
  final VoidCallback? onPressed;
  const ComentWidget({super.key, required this.comentCount, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          SvgPicture.asset(
            AppIcons.coment,
            colorFilter:  ColorFilter.mode(context.color.grey, BlendMode.srcIn),
            height: 22.h,
          ),
          ScreenUtil().setHorizontalSpacing(8.w),
          Text(
            '$comentCount ${context.l10n.lenth_comment.toLowerCase()}',
            style: Styles.postTitle.copyWith(color: context.color.grey, fontFamily: Styles.gilroyRegular),
          ),
        ],
      ),
    );
  }
}
