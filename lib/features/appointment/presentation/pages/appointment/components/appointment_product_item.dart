import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/appointment/data/models/appoinment_model.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/appoinment.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/cached_image_widget.dart';
import 'package:mpd_client/core/utils/utils.dart';

/// Bron ro‘yxatida shifokor (`responsible`) bo‘lmaganda — mahsulot / xizmat qatori.
class AppointmentProductItem extends StatelessWidget {
  final Appointment appointment;
  final AppoinmentInfo appoinmentInfo;
  final Widget bottomInfo;

  const AppointmentProductItem({
    super.key,
    required this.appointment,
    required this.appoinmentInfo,
    required this.bottomInfo,
  });

  String _title(BuildContext context) {
    final n = appointment.name?.trim();
    if (n != null && n.isNotEmpty) return n;
    if (appointment.product != null) return '#${appointment.product}';
    return context.l10n.error_no_data_available;
  }

  @override
  Widget build(BuildContext context) {
    final title = _title(context);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLeadImage(context),
                ScreenUtil().setHorizontalSpacing(16.w),
                Expanded(child: _buildInfo(context, title)),
              ],
            ),
          ),
          ScreenUtil().setVerticalSpacing(16.h),
          Divider(height: 1.h, color: context.color.dividerColor),
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

  Widget _buildLeadImage(BuildContext context) {
    final url = appointment.image?.trim();
    if (url != null && url.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(36.r),
        child: CachedImageWidget(url: url, size: 72),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(36.r),
      child: Container(
        width: 72,
        height: 72,
        color: context.color.mainBlue.withValues(alpha: 0.08),
        child: Icon(
          Icons.medical_information_outlined,
          size: 32,
          color: context.color.mainBlue,
        ),
      ),
    );
  }

  Column _buildInfo(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: Styles.expTitle.copyWith(color: context.color.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            if (appoinmentInfo.drCardInfo != DrCardInfo.following) ...[
              _buildStatusBar(),
            ],
          ],
        ),
        ScreenUtil().setVerticalSpacing(6.h),
        Text(
          '${Utils.priceFormat(appointment.cost ?? 0.0)} UZS',
          style: Styles.boldHeadline6.copyWith(
            fontSize: 14.sp,
            color: context.color.mainBlue,
          ),
        ),
        ScreenUtil().setVerticalSpacing(4.h),
        Text(
          '${context.l10n.appointment_amount}: ${appointment.qty ?? 0}',
          style: Styles.cardReview.copyWith(
            color: context.color.grey,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBar() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: appoinmentInfo.color!.withValues(alpha: 0.1),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            appoinmentInfo.statusIcon!,
            colorFilter: ColorFilter.mode(
              appoinmentInfo.color!,
              BlendMode.srcIn,
            ),
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
          ),
        ],
      ),
    );
  }
}
