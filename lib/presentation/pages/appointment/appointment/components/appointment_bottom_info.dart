import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/w_icon_gradient_button.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/utils.dart';

class AppointmentBottomInfo extends StatelessWidget {
  final String meetDate;
  final double price;
  final VoidCallback onLocationPressed, onDetailPressed;
  final bool isPending;
  const AppointmentBottomInfo({super.key, this.isPending = false, this.price = 0, required this.meetDate, required this.onDetailPressed, required this.onLocationPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.45,
          child: isPending ? _buildTime(context) : _buildPrice(context),
        ),
        const Spacer(),
        IconGradientButton(
          height: 34,
          width: 34,
          icon: AppIcons.unfilledLocation,
          onPressed: onLocationPressed,
        ),
        const Spacer(),
        Container(
          height: 34.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                gradientBlueOpacity,
                gradientBlue,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ElevatedButton(
            onPressed: onDetailPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text(
              context.l10n.appointment_detail,
              style: Styles.boldHeadline6.copyWith(
                color: white,
                fontSize: 12.sp,
              ),
            ),
          ),
        )
      ],
    );
  }

  Container _buildTime(BuildContext context) {
    return Container(
      height: 34.h,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(color: mainBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        children: [
          SvgPicture.asset(
            AppIcons.clockTransparent,
            height: 18,
            width: 18,
            colorFilter: const ColorFilter.mode(mainBlue, BlendMode.srcIn),
          ),
          const SizedBox(width: 4),
          Text(
            meetDate.isEmpty ? "--" : Utils.appointMentDateFormat(meetDate, context),
            overflow: TextOverflow.ellipsis,
            style: Styles.descSubtitle.copyWith(
              color: mainBlue,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }

  //method price
  RichText _buildPrice(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(text: '${Utils.priceFormat(price)} UZS\n', style: Styles.descSubtitle.copyWith(color: black, fontWeight: FontWeight.w600)),
        TextSpan(text: meetDate.isEmpty ? "--" : Utils.appointMentDateFormat(meetDate, context), style: Styles.cardReview.copyWith(color: grey, fontSize: 10.sp)),
      ]),
    );
  }
}
