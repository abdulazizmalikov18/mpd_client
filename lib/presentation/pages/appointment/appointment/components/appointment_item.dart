import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/domain/models/appointment/appointment_info_models.dart';
import 'package:mpd_client/domain/models/appointment/specialist_info_model.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/appoinment.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/cached_image_widget.dart';
import 'package:mpd_client/presentation/widgets/grandient_icon.dart';
import 'package:mpd_client/presentation/widgets/widget_defaul_avatar.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

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
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: white,
        boxShadow: const [
          BoxShadow(
            color: cardShadow,
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: specialist.avatar != null
                      ? CachedImageWidget(url: specialist.avatar!, size: 40)
                      : const DefaultAvatar(containerSize: 60, imageSize: 40),
                ),
                ScreenUtil().setHorizontalSpacing(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              specialist.fullname ?? '-',
                              style: AppTheme.headlineSmall.copyWith(
                                color: black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (appoinmentInfo.drCardInfo != DrCardInfo.following)
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  color: appoinmentInfo.color!
                                      .withValues(alpha: 0.1)),
                              child: Row(
                                children: [
                                  appoinmentInfo.statusIcon!.svg(
                                    height: 12.h,
                                    width: 12.h,
                                    color: appoinmentInfo.color!,
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
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        constraints: BoxConstraints(maxWidth: 140.w),
                        child: Text(
                          specialist.job ?? "__",
                          style: Styles.headline7
                              .copyWith(fontSize: 14, color: mainBlue),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (appoinmentInfo.drCardInfo != DrCardInfo.following)
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 220),
                          child: Text(
                            specialist.appointmentName ?? "--",
                            style: Styles.cardReview
                                .copyWith(color: red, fontSize: 12),
                        
                          ),
                        ),
                      if (appoinmentInfo.drCardInfo == DrCardInfo.following)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const GradientIcon(iconName: AppIcons.location),
                            ScreenUtil().setHorizontalSpacing(8.w),
                            Text(
                              specialist.workingTime.toString(),
                              style: Styles.descSubtitle
                                  .copyWith(fontSize: 14.sp, color: grey),
                            
                            ),
                          ],
                        ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Divider(
            height: 1.h,
            color: dividerColor,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: bottomInfo,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
