import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/application/doctor_booking/doctor_profile/doctor_profile_bloc.dart';
import 'package:mpd_client/infrastructure/services/local_service.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/cached_image_widget.dart';
import 'package:mpd_client/presentation/widgets/widget_defaul_avatar.dart';

class ReviewCard extends StatelessWidget {
  final Color? statusColor;
  final String status;
  final List<LocalService> localProducts;
  final String buttonName;
  final String statusIcon;

  const ReviewCard({
    super.key,
    this.buttonName = '',
    this.statusColor,
    this.status = '',
    this.statusIcon = '',
    required this.localProducts,
  });

  @override
  Widget build(BuildContext context) {
    // statusColor ?? white
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDrImage(context),
              ScreenUtil().setHorizontalSpacing(16.w),
              Expanded(
                child: _buildDrInfo(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

//doctor info method
  Column _buildDrInfo(BuildContext context) {
    final doctor = context.select((DoctorProfileBloc bloc) => bloc.state.doctor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${doctor!.name} ${doctor.lastname}',
              style: Styles.expTitle.copyWith(color: black),
            ),
          ],
        ),
        ScreenUtil().setVerticalSpacing(2.h),
        ScreenUtil().setVerticalSpacing(2.h),
        Container(
          constraints: BoxConstraints(maxWidth: 140.w),
          child: Text(
            doctor.job.name,
            style: Styles.headline7.copyWith(fontSize: 14, color: mainBlue),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        ScreenUtil().setVerticalSpacing(3.h),
        Text(
          localProducts.first.name,
          style: Styles.cardReview.copyWith(
            color: grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

//doctor image method
  ClipRRect _buildDrImage(BuildContext context) {
    final doctor = context.select((DoctorProfileBloc bloc) => bloc.state.doctor);
    return ClipRRect(
      borderRadius: BorderRadius.circular(36.r),
      child: doctor!.avatar != null ? CachedImageWidget(url: doctor.avatar!, size: 72) : const DefaultAvatar(containerSize: 72, imageSize: 60),
    );
  }
}
