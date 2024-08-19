import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/infrastructure/services/local_service.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/appoinment.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/cached_image_widget.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';
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
        padding: EdgeInsets.only(top: 16, bottom: appointmentInfo != DrCardInfo.pending ? 0 : 4.h),
        margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                context.l10n.appointment_service,
                style: Styles.boldHeadline6.copyWith(
                  color: black,
                ),
              ),
            ),
            ScreenUtil().setVerticalSpacing(14),
            for (int i = 0; i < localProducts.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 12, left: 16, right: 16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: localProducts[i].image == null || localProducts[i].image == ''
                          ? Image.asset(
                              AppImages.service,
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            )
                          : CachedImageWidget(
                              url: localProducts[i].image ?? "https://dwed.fra1.digitaloceanspaces.com/SMMS/media/PostMedia/image/1b459e4f-2352-451f-9a8c-e66c59f0dce9.jpeg",
                              size: 40,
                            ),
                    ),
                        const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localProducts[i].name,
                          style: Styles.descSubtitle.copyWith(height: null),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4),
                        Text('${Utils.priceFormat(localProducts[i].price)} UZS', style: Styles.headline7Sp14.copyWith(fontFamily: Styles.gilroyMedium, color: mainBlue)),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      'x ${localProducts[i].count}',
                      style: Styles.boldTopHint.copyWith(color: black, fontSize: 16),
                    ),
                  ],
                ),
              ),
            if (appointmentInfo != DrCardInfo.pending)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'View records',
                          style: Styles.headline7.copyWith(color: mainBlue, fontSize: 14),
                        ),
                        AppIcons.forward.svg(
                          height: 18,
                          width: 18,
                          color: mainBlue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ));
  }
}