import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/appoinment.dart';
import 'package:mpd_client/src/widgets/cached_image_widget.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';

import '../../../../../../src/themes/styles.dart';

class AppointmentItem extends StatelessWidget {
  final SpecialistInfoModel specialist;
  final AppoinmentInfo appoinmentInfo;
  final Widget bottomInfo;

  const AppointmentItem({
    super.key,
    required this.specialist,
    required this.appoinmentInfo,
    required this.bottomInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
      width: double.infinity,
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
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 16.h, right: 16.w),
            child: Row(
              children: [
                _buildDrImage(specialist.avatar),
                ScreenUtil().setHorizontalSpacing(16.w),
                Expanded(child: _buildDrInfo(specialist, context)),
              ],
            ),
          ),
          ScreenUtil().setVerticalSpacing(16.h),
          Divider(
            height: 1.h,
            color: context.color.dividerColor,
          ),
          ScreenUtil().setVerticalSpacing(12.h),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: bottomInfo,
          ),
          ScreenUtil().setVerticalSpacing(16.h),
        ],
      ),
    );
  }

//doctor image method
  ClipRRect _buildDrImage(String? image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36.r),
      child: image != null
          ? CachedImageWidget(url: image, size: 72)
          : const DefaultAvatar(containerSize: 72, imageSize: 60),
    );
  }

  //doctor info method
  Column _buildDrInfo(SpecialistInfoModel specialist, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                specialist.fullname ?? '-',
                style: Styles.expTitle.copyWith(color: context.color.black),
              ),
            ),
            const SizedBox(width: 8),
            if (appoinmentInfo.drCardInfo != DrCardInfo.following)
              _buildStatusBar()
          ],
        ),
        ScreenUtil().setVerticalSpacing(2.h),
        Container(
          constraints: BoxConstraints(maxWidth: 140.w),
          child: Text(
            specialist.job ?? "__",
            style: Styles.headline7
                .copyWith(fontSize: 14, color: context.color.mainBlue),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        ScreenUtil().setVerticalSpacing(3.h),
        if (appoinmentInfo.drCardInfo != DrCardInfo.following)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 220),
            child: Text(
              specialist.appointmentName ?? "--",
              style: Styles.cardReview
                  .copyWith(color: context.color.red, fontSize: 12),
            ),
          ),
        if (appoinmentInfo.drCardInfo == DrCardInfo.following)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIcons.location.svg(color: context.color.mainBlue),
              ScreenUtil().setHorizontalSpacing(8.w),
              Text(
                specialist.workingTime.toString(),
                style: Styles.descSubtitle
                    .copyWith(fontSize: 14.sp, color: context.color.grey),
              ),
            ],
          ),
        ScreenUtil().setVerticalSpacing(12.h),
      ],
    );
  }

// method statusbar
  Widget _buildStatusBar() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: appoinmentInfo.color!.withValues(alpha: 0.1)),
      child: Row(
        children: [
          SvgPicture.asset(
            appoinmentInfo.statusIcon!,
            colorFilter:
                ColorFilter.mode(appoinmentInfo.color!, BlendMode.srcIn),
            height: 12.h,
            width: 12.h,
          ),
          ScreenUtil().setHorizontalSpacing(2.w),
          Text(
            appoinmentInfo.status!,
            style: Styles.headline7.copyWith(
              color: appoinmentInfo.color,
              fontSize: 10.sp,
            ),
          )
        ],
      ),
    );
  }
}
