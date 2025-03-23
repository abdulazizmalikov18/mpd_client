import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/cached_image_widget.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';
import 'package:mpd_client/src/widgets/filled_gradient_button.dart';

class DoctorCardIteam extends StatelessWidget {
  const DoctorCardIteam({
    super.key,
    required this.specialists,
  });

  final MapSpecialist specialists;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.color.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 20,
            color: Color.fromRGBO(0, 0, 0, 0.08),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Builder(
                builder: (context) {
                  debugPrint("==========>>>> ${specialists.avatar}");
                  return specialists.avatar != null
                      ? CachedImageWidget(
                          url: specialists.avatar ??
                              "https://dwed.fra1.digitaloceanspaces.com/SMMS/media/PostMedia/image/a651706c-f6a0-45fe-9d40-46e9fb37271b.jpeg",
                          size: 56,
                        )
                      : const DefaultAvatar(containerSize: 56, imageSize: 38);
                },
              ),
              ScreenUtil().setHorizontalSpacing(12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${specialists.name!} ${specialists.lastname!}',
                    style: Styles.expTitle.copyWith(color: context.color.black),
                  ),
                  ScreenUtil().setVerticalSpacing(4.h),
                  Text(
                    specialists.job?.name ?? "--",
                    style: Styles.postTitle.copyWith(
                        fontFamily: Styles.gilroyMedium,
                        color: context.color.mainBlue),
                  ),
                  ScreenUtil().setVerticalSpacing(8.h),
                  Row(
                    children: [
                      AppIcons.location.svg(
                        color: context.color.mainBlue,
                        width: 18,
                        height: 18,
                      ),
                      ScreenUtil().setHorizontalSpacing(4.w),
                      Text(
                        specialists.locationDesc ?? "--",
                        style: Styles.postSubtitle.copyWith(
                            fontFamily: Styles.gilroyMedium,
                            color: context.color.grey),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          ScreenUtil().setVerticalSpacing(12.h),
          Divider(color: context.color.dividerColor, height: 1.h),
          ScreenUtil().setVerticalSpacing(12.h),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.search_doctor_service_price_start,
                    style: Styles.headline8.copyWith(color: context.color.grey),
                  ),
                  Text(
                    '${specialists.minPrice != null ? Utils.priceFormat(specialists.minPrice!) : 'Free'} ${specialists.currencyCode != null ? specialists.currencyCode!.toUpperCase() : ''}',
                    style: Styles.semiboldTitle
                        .copyWith(color: context.color.black),
                  )
                ],
              ),
              const Spacer(),
              FilledGradientButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.drProfilebyid,
                    arguments: SpecialistInfoModel(
                      avatar: specialists.avatar,
                      fullname: '${specialists.name} ${specialists.lastname!}',
                      username: specialists.user,
                      phone: specialists.phone,
                      id: specialists.id ?? 0,
                      job: specialists.job?.name ?? "-- --",
                    ),
                  );
                },
                text: Text(
                  context.l10n.search_doctor_service_book_now,
                  style: Styles.boldHeadline6.copyWith(fontSize: 14.sp),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
