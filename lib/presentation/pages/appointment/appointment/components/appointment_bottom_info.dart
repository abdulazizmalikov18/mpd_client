import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/w_icon_gradient_button.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';
import 'package:mpd_client/utils/utils.dart';

class AppointmentBottomInfo extends StatelessWidget {
  final String meetDate;
  final double price;
  final VoidCallback onLocationPressed, onDetailPressed;
  final bool isPending;
  const AppointmentBottomInfo(
      {super.key,
      this.isPending = false,
      this.price = 0,
      required this.meetDate,
      required this.onDetailPressed,
      required this.onLocationPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 16,
          child: isPending
              ? Container(
                  height: 40,
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                      color: mainBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      AppIcons.clockTransparent.svg(
                        height: 18,
                        width: 18,
                        color: mainBlue,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          meetDate.isEmpty
                              ? "--"
                              : Utils.appointMentDateFormat(meetDate, context),
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.headlineSmall!.copyWith(
                            color: mainBlue,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: '${Utils.priceFormat(price)} UZS\n',
                          style: Styles.descSubtitle.copyWith(
                              color: black, fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: meetDate.isEmpty
                              ? "--"
                              : Utils.appointMentDateFormat(meetDate, context),
                          style: Styles.cardReview
                              .copyWith(color: grey, fontSize: 10.sp)),
                    ],
                  ),
                ),
        ),
        const Spacer(
          flex: 4,
        ),
        IconGradientButton(
          height: 40,
          width: 40,
          icon: AppIcons.unfilledLocation,
          onPressed: onLocationPressed,
        ),
        const Spacer(),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: mainBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ElevatedButton(
            onPressed: onDetailPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
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
}
