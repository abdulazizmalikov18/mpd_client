import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/widgets/icon_gradient_button.dart';

import '../../../../../../app/app_colors.dart';
import '../../../../../../app/app_icons.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../src/themes/styles.dart';

class AppointmentBottomInfo extends StatelessWidget {
  final String meetDate;
  final double price;
  final VoidCallback onLocationPressed, onDetailPressed;
  final bool isPending;
  const AppointmentBottomInfo({
    super.key,
    this.isPending = false,
    this.price = 0,
    required this.meetDate,
    required this.onDetailPressed,
    required this.onLocationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isPending ? _buildTime(context) : _buildPrice(context),
        const Spacer(),
        IconGradientButton(
          height: 34,
          width: 34,
          icon: AppIcons.unfilledLocation,
          onPressed: onLocationPressed,
        ),
        ScreenUtil().setHorizontalSpacing(16.w),
        Container(
          height: 34.h,
          decoration: BoxDecoration(
            color: context.color.mainBlue,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: ElevatedButton(
            onPressed: onDetailPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              context.l10n.appointment_detail,
              style: Styles.boldHeadline6.copyWith(
                color: context.color.white,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _buildTime(BuildContext context) {
    return Container(
      height: 34.h,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: context.color.mainBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppIcons.clockTransparent,
            height: 18.h,
            width: 18.h,
            colorFilter: ColorFilter.mode(
              context.color.mainBlue,
              BlendMode.srcIn,
            ),
          ),
          ScreenUtil().setHorizontalSpacing(4.w),
          Text(
            meetDate.isEmpty
                ? "--"
                : Utils.appointMentDateFormat(meetDate, context),
            style: Styles.descSubtitle.copyWith(
              color: context.color.mainBlue,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  //method price
  RichText _buildPrice(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${Utils.priceFormat(price)} UZS\n',
            style: Styles.descSubtitle.copyWith(
              color: context.color.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: meetDate.isEmpty
                ? "--"
                : Utils.appointMentDateFormat(meetDate, context),
            style: Styles.cardReview.copyWith(
              color: context.color.grey,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
