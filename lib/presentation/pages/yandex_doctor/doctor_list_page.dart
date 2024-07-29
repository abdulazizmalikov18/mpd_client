import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/domain/models/yandex/searched_specialist_model.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/cached_image_widget.dart';
import 'package:mpd_client/presentation/widgets/grandient_icon.dart';
import 'package:mpd_client/presentation/widgets/w_filled_gradient_button.dart';
import 'package:mpd_client/presentation/widgets/widget_defaul_avatar.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/utils.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key, required this.specialists, required this.title});
  final List<MapSpecialist> specialists;
  final String title;

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        backgroundColor: white,
        elevation: 1,
        title: Text(
          widget.title,
          style: const TextStyle(color: black),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: white,
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
                      debugPrint("==========>>>> ${widget.specialists[index].avatar}");
                      return widget.specialists[index].avatar != null
                          ? CachedImageWidget(
                              url: widget.specialists[index].avatar ?? "https://dwed.fra1.digitaloceanspaces.com/SMMS/media/PostMedia/image/a651706c-f6a0-45fe-9d40-46e9fb37271b.jpeg",
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
                        '${widget.specialists[index].name!} ${widget.specialists[index].lastname!}',
                        style: AppTheme.headlineMedium.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: black,
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(4.h),
                      Text(
                        widget.specialists[index].job?.name ?? "--",
                        style: AppTheme.headlineMedium.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          // fontFamily: Styles.gilroyMedium,
                          color: mainBlue,
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(8.h),
                      Row(
                        children: [
                          const GradientIcon(iconName: AppIcons.location),
                          ScreenUtil().setHorizontalSpacing(4.w),
                          Text(
                            widget.specialists[index].locationDesc ?? "--",
                            style: AppTheme.headlineMedium.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              // fontFamily: Styles.gilroyMedium,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.search_doctor_service_price_start,
                        style: AppTheme.headlineMedium.copyWith(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w300,
                          color: grey,
                        ),
                      ),
                      Text(
                        '${widget.specialists[index].minPrice != null ? Utils.priceFormat(widget.specialists[index].minPrice!) : 'Free'} ${widget.specialists[index].currencyCode != null ? widget.specialists[index].currencyCode!.toUpperCase() : ''}',
                        style: AppTheme.headlineMedium.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: black,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  FilledGradientButton(
                    onPressed: () {
                      // TODO : Navigation
                      // Navigator.pushNamed(
                      //   context,
                      //   AppRoutes.drProfilebyid,
                      //   arguments: SpecialistInfoModel(
                      //     avatar: widget.specialists[index].avatar,
                      //     fullname: '${widget.specialists[index].name} ${widget.specialists[index].lastname!}',
                      //     username: widget.specialists[index].user,
                      //     id: widget.specialists[index].id ?? 0,
                      //     job: widget.specialists[index].job?.name ?? "-- --",
                      //   ),
                      // );
                    },
                    text: Text(
                      context.l10n.search_doctor_service_book_now,
                      style: AppTheme.titleLarge.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: widget.specialists.length,
      ),
    );
  }
}
