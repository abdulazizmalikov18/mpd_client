import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/user/data/models/user_records_model.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/cached_image_widget.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';

class RecordDoctorCard extends StatelessWidget {
  final VoidCallback onPress;
  final String buttonName;
  final RecordModel record;

  const RecordDoctorCard({
    super.key,
    required this.buttonName,
    required this.record,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: context.color.white,
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
                _buildDrImage(),
                ScreenUtil().setHorizontalSpacing(16.w),
                Expanded(child: _buildDrInfo(context)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(height: 1.h, color: context.color.dividerColor),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 0),
            child: record.writer != null
                ? _buildViewDrProfile(context)
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  //method viewdrprofile
  Row _buildViewDrProfile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          onPressed: onPress,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                buttonName,
                style: Styles.headline7.copyWith(
                  color: context.color.mainBlue,
                  fontSize: 14.sp,
                ),
              ),
              SvgPicture.asset(
                AppIcons.forward,
                colorFilter: ColorFilter.mode(
                  context.color.mainBlue,
                  BlendMode.srcIn,
                ),
                height: 18.h,
                width: 18.h,
              ),
            ],
          ),
        ),
      ],
    );
  }

  //doctor info method
  Column _buildDrInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${record.writer?.name ?? "--"} ${record.writer?.lastname ?? "--"}',
              style: Styles.expTitle.copyWith(color: context.color.black),
            ),
          ],
        ),
        ScreenUtil().setVerticalSpacing(2.h),
        Text(
          record.writer?.job ?? "--",
          style: Styles.headline7.copyWith(
            fontSize: 14,
            color: context.color.mainBlue,
          ),
        ),
        ScreenUtil().setVerticalSpacing(3.h),
        Text(
          record.product ?? '--',
          style: Styles.cardReview.copyWith(
            color: context.color.grey,
            fontSize: 12,
          ),
        ),
        ScreenUtil().setVerticalSpacing(18.h),
      ],
    );
  }

  //doctor image method
  ClipRRect _buildDrImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.r),
      child: record.writer?.avatar != null
          ? CachedImageWidget(size: 72, url: record.writer!.avatar!)
          : const DefaultAvatar(containerSize: 72, imageSize: 54),
    );
  }
}
