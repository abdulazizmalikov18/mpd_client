import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/user/data/models/specialist_info_model.dart';
import 'package:mpd_client/features/user/domain/blocs/user_info/user_info_bloc.dart';
import 'package:mpd_client/features/yandex_doctor/data/models/searched_specialist_model.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/cached_image_widget.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';
import 'package:mpd_client/src/widgets/filled_gradient_button.dart';
import 'package:mpd_client/src/widgets/gradient_icon.dart';
import 'package:mpd_client/src/widgets/icon_circle_button.dart';

import '../../domain/blocs/yandex_doctor/yandex_doctor_bloc.dart';

class DoctorInfo extends StatelessWidget {
  final bool showDoctorInfo;
  final MapSpecialist? specialist;
  final String job;
  const DoctorInfo(
      {super.key,
      required this.showDoctorInfo,
      required this.specialist,
      required this.job});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      left: 0,
      right: 0,
      bottom: showDoctorInfo ? 16.h : -250.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 6.w),
            child: IconCircleButton(
                onPressed: () {
                  context
                      .read<YandexDoctorBloc>()
                      .add(const ShowDoctorInfo(false));
                },
                icon: AppIcons.arrowLeft),
          ),
          ScreenUtil().setVerticalSpacing(13.h),
          BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              return MapDoctorCard(
                onPressed: () {
                  // if (specialist?.user == state.userInfo?.username) {
                  //   Navigator.of(context).pushNamed(
                  //     AppRoutes.userInfo,
                  //     arguments: state.userInfo,
                  //   );
                  // } else {

                  // }

                  Navigator.pushNamed(
                    context,
                    AppRoutes.drProfilebyid,
                    arguments: SpecialistInfoModel(
                      avatar: specialist!.avatar,
                      fullname: '${specialist!.name} ${specialist!.lastname!}',
                      username: specialist!.user,
                      id: specialist?.id ?? 0,
                      job: specialist?.job?.name ?? "-- --",
                      phone: specialist?.phone ?? "",
                    ),
                  );
                },
                job: job,
                specialist: specialist,
              );
            },
          )
        ],
      ),
    );
  }
}

class MapDoctorCard extends StatelessWidget {
  final MapSpecialist? specialist;
  final VoidCallback onPressed;
  final String job;
  const MapDoctorCard(
      {super.key,
      required this.specialist,
      required this.onPressed,
      required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: context.color.white),
      child: Column(
        children: [
          Row(
            children: [
              ScreenUtil().setHorizontalSpacing(16.w),
              specialist != null && specialist!.avatar != null
                  ? CachedImageWidget(url: specialist!.avatar!, size: 56)
                  : const DefaultAvatar(containerSize: 56, imageSize: 38),
              ScreenUtil().setHorizontalSpacing(12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    specialist != null
                        ? '${specialist!.name!} ${specialist!.lastname!}'
                        : '',
                    style: Styles.expTitle.copyWith(color: context.color.black),
                  ),
                  ScreenUtil().setVerticalSpacing(4.h),
                  Text(
                    specialist != null ? specialist?.job?.name ?? "--" : job,
                    style: Styles.postTitle.copyWith(
                        fontFamily: Styles.gilroyMedium,
                        color: context.color.mainBlue),
                  ),
                  ScreenUtil().setVerticalSpacing(8.h),
                  Row(
                    children: [
                      const GradientIcon(iconName: AppIcons.location),
                      ScreenUtil().setHorizontalSpacing(4.w),
                      Text(
                        specialist != null
                            ? specialist?.locationDesc ?? "--"
                            : 'Tashkent, Amir Temur Avenue',
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
              ScreenUtil().setHorizontalSpacing(16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.search_doctor_service_price_start,
                    style: Styles.headline8.copyWith(color: context.color.grey),
                  ),
                  specialist != null
                      ? Text(
                          '${specialist!.minPrice != null ? Utils.priceFormat(specialist!.minPrice!) : 'Free'} ${specialist!.currencyCode != null ? specialist!.currencyCode!.toUpperCase() : ''}',
                          style: Styles.semiboldTitle
                              .copyWith(color: context.color.black),
                        )
                      : const Text(''),
                ],
              ),
              const Spacer(),
              FilledGradientButton(
                onPressed: onPressed,
                text: Text(
                  context.l10n.search_doctor_service_book_now,
                  style: Styles.boldHeadline6.copyWith(fontSize: 14.sp),
                ),
              ),
              ScreenUtil().setHorizontalSpacing(16.w),
            ],
          )
        ],
      ),
    );
  }
}
