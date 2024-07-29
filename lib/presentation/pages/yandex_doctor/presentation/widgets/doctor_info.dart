import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/domain/models/yandex/searched_specialist_model.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/cached_image_widget.dart';
import 'package:mpd_client/presentation/widgets/grandient_icon.dart';
import 'package:mpd_client/presentation/widgets/icon_button_circle.dart';
import 'package:mpd_client/presentation/widgets/w_filled_gradient_button.dart';
import 'package:mpd_client/presentation/widgets/widget_defaul_avatar.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/utils.dart';

import '../../../../application/yandex/yandex_doctor/yandex_doctor_bloc.dart';

class DoctorInfo extends StatelessWidget {
  final bool showDoctorInfo;
  final MapSpecialist? specialist;
  final String job;
  const DoctorInfo({super.key, required this.showDoctorInfo, required this.specialist, required this.job});

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
                  context.read<YandexDoctorBloc>().add(const ShowDoctorInfo(false));
                },
                icon: AppIcons.arrowLeft),
          ),
          ScreenUtil().setVerticalSpacing(13.h),
          MapDoctorCard(
            onPressed: () {
              // FIXME : Navigate to =>
              // Navigator.pushNamed(
              //   context,
              //   AppRoutes.drProfilebyid,
              //   arguments: SpecialistInfoModel(
              //     avatar: specialist!.avatar,
              //     fullname: '${specialist!.name} ${specialist!.lastname!}',
              //     username: specialist!.user,
              //     id: specialist?.id ?? 0,
              //     job: specialist?.job?.name ?? "-- --",
              //   ),
              // );
            },
            job: job,
            specialist: specialist,
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
  const MapDoctorCard({super.key, required this.specialist, required this.onPressed, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: white),
      child: Column(
        children: [
          Row(
            children: [
              ScreenUtil().setHorizontalSpacing(16.w),
              specialist != null && specialist!.avatar != null ? CachedImageWidget(url: specialist!.avatar!, size: 56) : const DefaultAvatar(containerSize: 56, imageSize: 38),
              ScreenUtil().setHorizontalSpacing(12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    specialist != null ? '${specialist!.name!} ${specialist!.lastname!}' : '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      // fontFamily: gilroyMedium,
                      color: black,
                      height: 1.3,
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(4.h),
                  Text(
                    specialist != null ? specialist?.job?.name ?? "--" : job,
                    style: AppTheme.headlineSmall.copyWith(
                      fontSize: 14,
                      color: mainBlue,
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(8.h),
                  Row(
                    children: [
                      const GradientIcon(iconName: AppIcons.location),
                      ScreenUtil().setHorizontalSpacing(4.w),
                      Text(
                        specialist != null ? specialist?.locationDesc ?? "--" : 'Tashkent, Amir Temur Avenue',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: grey,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          ScreenUtil().setVerticalSpacing(12.h),
          Divider(color: dividerColor, height: 1.h),
          ScreenUtil().setVerticalSpacing(12.h),
          Row(
            children: [
              ScreenUtil().setHorizontalSpacing(16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.search_doctor_service_price_start,
                    style: AppTheme.bodyLarge.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: grey,
                    ),
                  ),
                  specialist != null
                      ? Text(
                          '${specialist!.minPrice != null ? Utils.priceFormat(specialist!.minPrice!) : 'Free'} ${specialist!.currencyCode != null ? specialist!.currencyCode!.toUpperCase() : ''}',
                          style: AppTheme.bodyLarge.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: black,
                          ),
                        )
                      : const Text(''),
                ],
              ),
              const Spacer(),
              FilledGradientButton(
                onPressed: onPressed,
                text: Text(
                  context.l10n.search_doctor_service_book_now,
                  style: AppTheme.headlineSmall.copyWith(
                    fontSize: 14,
                  ),
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
