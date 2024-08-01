import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class AppointmentPaymentCard extends StatelessWidget {
  final String paymentMethod;
  final bool isCash;
  final String amount;
  final String discount;
  final String total;

  const AppointmentPaymentCard({
    super.key,
    this.isCash = false,
    required this.paymentMethod,
    required this.amount,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: white,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.l10n.appointment_payment,
                  style: Styles.boldHeadline6.copyWith(
                    color: black,
                  )),
              ScreenUtil().setVerticalSpacing(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.appointment_amount,
                    style: Styles.descSubtitle
                        .copyWith(fontSize: 14.sp, color: grey),
                  ),
                  Text(
                    amount,
                    style: Styles.boldHeadline6.copyWith(
                      color: black,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              ScreenUtil().setVerticalSpacing(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.appointment_discount_coupons,
                    style: Styles.descSubtitle
                        .copyWith(fontSize: 14.sp, color: grey),
                  ),
                  Text(
                    discount,
                    style: Styles.boldHeadline6.copyWith(
                      color: black,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              ScreenUtil().setVerticalSpacing(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.appointment_payment_method,
                    style: Styles.descSubtitle
                        .copyWith(fontSize: 14.sp, color: grey),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        paymentMethod,
                        height: 24.h,
                        fit: BoxFit.fill,
                      ),
                      if (isCash) ScreenUtil().setHorizontalSpacing(8.w),
                      if (isCash)
                        Text(
                          'Cash',
                          style: Styles.boldHeadline6.copyWith(
                            color: black,
                            fontSize: 14.sp,
                          ),
                        ),
                    ],
                  )
                ],
              ),
              ScreenUtil().setVerticalSpacing(12.h),
              Divider(
                height: 1.h,
                color: dividerColor,
              ),
              ScreenUtil().setVerticalSpacing(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.appointment_total,
                    style: Styles.boldHeadline6.copyWith(
                      color: black,
                    ),
                  ),
                  Text(
                    total,
                    style: Styles.boldHeadline6.copyWith(
                      color: black,
                    ),
                  ),
                ],
              ),
            ]));
  }
}
