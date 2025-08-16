import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/yandex_doctor/data/models/top_specialists_model.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/appoinment.dart';
import 'package:mpd_client/src/themes/styles.dart';

import '../../../../../src/widgets/gradient_icon.dart';

class DoctorCard extends StatelessWidget {
  final VoidCallback onPress;
  final Color? statusColor;
  final String status;
  final DrCardInfo drCardInfo;
  final String buttonName;
  final String statusIcon;
  final Specialist? specialist;

  const DoctorCard({
    required this.onPress,
    this.specialist,
    this.drCardInfo = DrCardInfo.following,
    super.key,
    this.buttonName = '',
    this.statusColor,
    this.status = '',
    this.statusIcon = '',
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: context.color.white,
            boxShadow: [
              BoxShadow(
                color: context.color.cardShadow,
                blurRadius: 20,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 16.h, right: 16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDrImage(specialist?.job?.image),
                    ScreenUtil().setHorizontalSpacing(16.w),
                    Expanded(child: _buildDrInfo(specialist, context)),
                  ],
                ),
              ),
              Divider(height: 1.h, color: context.color.dividerColor),
              ScreenUtil().setVerticalSpacing(12.h),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (drCardInfo == DrCardInfo.following)
                      _buildDrPrice(specialist, context),
                    if (drCardInfo == DrCardInfo.pending)
                      _buildBookTime(context),
                    if (drCardInfo == DrCardInfo.completed ||
                        drCardInfo == DrCardInfo.cancelled)
                      _buildPrice(context),
                  ],
                ),
              ),
              ScreenUtil().setVerticalSpacing(16.h),
            ],
          ),
        ),
        if (drCardInfo == DrCardInfo.following) _buildFollowButton(context),
        if (drCardInfo != DrCardInfo.following) _buildStatusBar(context),
      ],
    );
  }

  //method doctor price
  RichText _buildDrPrice(Specialist? specialist, BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Service starts from\n',
            style: Styles.cardReview.copyWith(
              color: context.color.grey,
              fontSize: 10.sp,
            ),
          ),
          TextSpan(
            text: specialist != null
                ? specialist.minPrice != null
                      ? '${specialist.minPrice} ${specialist.currencyCode!.toUpperCase()}'
                      : 'Free'
                : 'Free',
            style: Styles.descSubtitle.copyWith(
              color: context.color.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  //method book date
  Container _buildBookTime(BuildContext context) {
    return Container(
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
            '26 Oct 2022 at 17:00',
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
            text: drCardInfo == DrCardInfo.completed
                ? '50 000 UZS\n'
                : '0 UZS\n',
            style: Styles.descSubtitle.copyWith(
              color: context.color.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: '5 Dec 2022 at 13:00',
            style: Styles.cardReview.copyWith(
              color: context.color.grey,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  //method follow button
  Positioned _buildFollowButton(BuildContext context) {
    return Positioned(
      right: 20.w,
      top: 3.h,
      child: Material(
        color: context.color.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: const SizedBox(),
      ),
    );
  }

  // method statusbar
  Positioned _buildStatusBar(BuildContext context) {
    return Positioned(
      right: 28.w,
      top: 12.h,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: (statusColor ?? context.color.white).withValues(alpha: 0.1),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              statusIcon,
              colorFilter: ColorFilter.mode(
                (statusColor ?? context.color.white),
                BlendMode.srcIn,
              ),
              height: 12.h,
              width: 12.h,
            ),
            ScreenUtil().setHorizontalSpacing(2.w),
            Text(
              status,
              style: Styles.headline7.copyWith(
                color: statusColor,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //doctor info method
  Column _buildDrInfo(Specialist? specialist, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              specialist != null
                  ? '${specialist.name!} ${specialist.lastname!}'
                  : 'Dr. Watamaniuk',
              style: Styles.expTitle.copyWith(color: context.color.black),
            ),
          ],
        ),
        ScreenUtil().setVerticalSpacing(2.h),
        Row(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 140.w),
              child: Text(
                specialist != null ? specialist.job!.name! : 'Dentist',
                style: Styles.headline7.copyWith(
                  fontSize: 14,
                  color: context.color.mainBlue,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            ScreenUtil().setHorizontalSpacing(6.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: context.color.background,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.star,
                    height: 12.h,
                    width: 12.h,
                    colorFilter: ColorFilter.mode(
                      context.color.yellow,
                      BlendMode.srcIn,
                    ),
                  ),
                  ScreenUtil().setHorizontalSpacing(2.w),
                  Text(
                    '4.7',
                    style: Styles.boldTopHint.copyWith(
                      color: context.color.black,
                      fontSize: 10,
                    ),
                  ),
                  ScreenUtil().setHorizontalSpacing(2.w),
                  Text('(50 reviews)', style: Styles.cardReview),
                ],
              ),
            ),
          ],
        ),
        ScreenUtil().setVerticalSpacing(3.h),
        Row(
          children: [
            Text(
              '9 year experience',
              style: Styles.cardReview.copyWith(
                color: context.color.grey,
                fontSize: 12,
              ),
            ),
            ScreenUtil().setHorizontalSpacing(6.w),
            Container(
              height: 4.h,
              width: 4.h,
              decoration: BoxDecoration(
                color: context.color.red,
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
            ScreenUtil().setHorizontalSpacing(6.w),
            Text(
              specialist != null
                  ? specialist.currentWorkplace!.isNotEmpty
                        ? '${specialist.currentWorkplace!.first.value}'
                        : 'Medion family hospital'
                  : 'Medion family hospital',
              style: Styles.cardReview.copyWith(
                color: context.color.grey,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        ScreenUtil().setVerticalSpacing(6.h),
        if (drCardInfo == DrCardInfo.following)
          _buildDrLocation(specialist, context),
        ScreenUtil().setVerticalSpacing(12.h),
      ],
    );
  }

  //doctor location method
  Row _buildDrLocation(Specialist? specialist, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const GradientIcon(iconName: AppIcons.clock),
        ScreenUtil().setHorizontalSpacing(6.w),
        Text(
          specialist != null
              ? 'Every day ${specialist.todayTimetable!.startTime != null ? specialist.todayTimetable!.startTime!.substring(0, 5) : ''} - ${specialist.todayTimetable!.endTime != null ? specialist.todayTimetable!.endTime!.substring(0, 5) : ''}'
              : 'Every day 08:00 - 15:00',
          style: Styles.cardReview.copyWith(
            color: context.color.grey,
            fontSize: 12,
          ),
        ),
        ScreenUtil().setHorizontalSpacing(28.w),
        const GradientIcon(iconName: AppIcons.location),
        ScreenUtil().setHorizontalSpacing(6.w),
        Text(
          '800m',
          style: Styles.cardReview.copyWith(
            color: context.color.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  //doctor image method
  ClipRRect _buildDrImage(String? image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36.r),
      child: image != null
          ? Image.asset(
              'assets/images/cardImage.png',
              fit: BoxFit.fill,
              height: 72.h,
              width: 72.h,
            )
          : Image.asset(
              'assets/images/cardImage.png',
              fit: BoxFit.fill,
              height: 72.h,
              width: 72.h,
            ),
    );
  }
}
