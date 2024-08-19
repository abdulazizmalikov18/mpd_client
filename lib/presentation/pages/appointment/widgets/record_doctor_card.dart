import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/domain/models/appointment/record_model.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/cached_image_widget.dart';
import 'package:mpd_client/presentation/widgets/widget_defaul_avatar.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

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
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDrImage(),
                ScreenUtil().setHorizontalSpacing(16),
                Expanded(
                  child: _buildDrInfo(context),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 1.h,
              color: dividerColor,
            ),
          ),
          Padding(padding: const EdgeInsets.only(left: 16, right: 0), child: _buildViewDrProfile(context)),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                buttonName,
                style: Styles.headline7.copyWith(color: mainBlue, fontSize: 14),
              ),
              AppIcons.forward.svg(height: 18, width: 18, color: mainBlue),
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
              style: Styles.expTitle.copyWith(color: black),
            ),
          ],
        ),
        ScreenUtil().setVerticalSpacing(2.h),
        Text(
          record.writer?.job ?? "--",
          style: Styles.headline7.copyWith(fontSize: 14, color: mainBlue),
        ),
        ScreenUtil().setVerticalSpacing(3.h),
        Text(
          record.product ?? '--',
          style: Styles.cardReview.copyWith(color: grey, fontSize: 12),
        ),
        ScreenUtil().setVerticalSpacing(18.h),
      ],
    );
  }

//doctor image method
  ClipRRect _buildDrImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: record.writer?.avatar != null ? CachedImageWidget(size: 40, url: record.writer!.avatar!) : const DefaultAvatar(containerSize: 40, imageSize: 30),
    );
  }
}
