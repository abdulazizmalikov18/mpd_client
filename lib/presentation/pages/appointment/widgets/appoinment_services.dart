import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/infrastructure/services/local_service.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/appoinment.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/cached_image_widget.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/utils.dart';
import 'package:mpd_client/presentation/styles/theme.dart';


class AppointmentService extends StatelessWidget {
  final VoidCallback? onPress;
  final DrCardInfo appointmentInfo;
  final List<LocalService> localProducts;

  const AppointmentService({
    super.key,
    required this.localProducts,
    required this.appointmentInfo,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 16.h, bottom: appointmentInfo != DrCardInfo.pending ? 0 : 4.h),
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                context.l10n.appointment_service,
                style: Styles.boldHeadline6.copyWith(
                  color: black,
                ),
              ),
            ),
            ScreenUtil().setVerticalSpacing(14.h),
            for (int i = 0; i < localProducts.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 12.h, left: 16.w, right: 16.w),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: localProducts[i].image == null || localProducts[i].image == ''
                          ? Image.asset(
                              AppImages.service,
                              height: 40.h,
                              width: 40.h,
                              fit: BoxFit.cover,
                            )
                          : CachedImageWidget(
                              url: localProducts[i].image ?? "https://dwed.fra1.digitaloceanspaces.com/SMMS/media/PostMedia/image/1b459e4f-2352-451f-9a8c-e66c59f0dce9.jpeg",
                              size: 40,
                            ),
                    ),
                    ScreenUtil().setHorizontalSpacing(16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localProducts[i].name,
                          style: Styles.descSubtitle.copyWith(height: null),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        ScreenUtil().setVerticalSpacing(2.h),
                        Text('${Utils.priceFormat(localProducts[i].price)} UZS', style: Styles.headline7Sp14.copyWith(fontFamily: Styles.gilroyMedium, color: mainBlue)),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      'x ${localProducts[i].count}',
                      style: Styles.boldTopHint.copyWith(color: black, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            if (appointmentInfo != DrCardInfo.pending)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const Divider(
                  height: 1,
                  color: dividerColor,
                ),
              ),
            if (appointmentInfo != DrCardInfo.pending)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: onPress,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'View records',
                          style: Styles.headline7.copyWith(color: mainBlue, fontSize: 14),
                        ),
                        SvgPicture.asset(
                          AppIcons.forward,
                          colorFilter: ColorFilter.mode(mainBlue, BlendMode.srcIn),
                          height: 18.h,
                          width: 18.h,
                        )
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ));
  }
}

/*
 ListTile(
              
                dense: true,
                trailing: Text(
                  serviceTimes,
                  style: Styles.boldTopHint
                      .copyWith(color: black, fontSize: 16.sp),
                ),
                leading: Image.asset(
                  'assets/images/sevices.png',
                  height: 40.h,
                  width: 40.h,
                  fit: BoxFit.contain,
                ),
                title: Text(
                  serviceName,
                  style: Styles.descSubtitle,
                ),
                subtitle: Text(
                  servicePrice,
                  style: Styles.descSubtitle.copyWith(
                      fontWeight: FontWeight.w600, color: mainBlue),
                ),
              ),


 */