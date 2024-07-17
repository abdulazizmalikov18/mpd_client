import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/domain/extensions/extension.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/cached_image_component.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_dialog_component.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/ads/comp/ads_empty_comp.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/ads/comp/icon_and_number_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/extensions.dart';

class ArchiveWidget extends StatefulWidget {
  const ArchiveWidget({super.key});

  @override
  State<ArchiveWidget> createState() => _ArchiveWidgetState();
}

class _ArchiveWidgetState extends State<ArchiveWidget> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocConsumer<ProfileBloc, ProfileState>(
          listenWhen: (previous, current) =>
              previous.deletePost != current.deletePost && current.deletePost,
          listener: (context, state) {
            if (state.deletePost) {
              context
                  .read<ProfileBloc>()
                  .add(const ProfileEvent.getOwnActualCars(isActive: "0"));
            }
          },
          builder: (context, state) {
            return //
                (state.ownCarsArchiveList ?? []).isEmpty
                    ? AdsEmptyComp(title: 'you_don_thave_any_archive_ads'.tr())
                    : _adsList(
                        actualList: state.ownCarsArchiveList ?? [],
                        colors: colors,
                        icons: icons,
                        fonts: fonts);
          });
    });
  }

  Widget _adsList({
    required CustomColorSet colors,
    required IconSet icons,
    required FontSet fonts,
    required List<CarModel> actualList,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 8.h, bottom: 180.h),
      itemCount: actualList.length,
      // itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        final car = actualList[index];
        return AnimationButtonEffect(
          onTap: () {
            Navigator.push(
                context,
                AppRoutes.getProductCard(
                  model: car,
                )).then((value) {
              context.read<BottomNavBarController>().changeNavBar(false);
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: colors.white,
              border: Border.all(color: colors.borderColor),
            ),
            child: Column(
              children: [
                /// image, model, price
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 3,
                        child: CachedImageComponent(
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 90.h,
                          borderRadius: 5.r,
                          // imageUrl: "",
                          imageUrl: (car.photos?.isEmpty ?? false)
                              ? ""
                              : car.photos?.first.url ?? "",
                        )),
                    12.horizontalSpace,
                    Expanded(
                        flex: 4,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                car.carModel?.name?.toUpperCase() ?? "",
                                // "car name",
                                style: fonts.subtitle2,
                              ),
                              4.verticalSpace,
                              Text(
                                car.price?.toFormattedCurrency(
                                        dbService: context.read<DBService>(),
                                        currencyS: car.currency) ??
                                    "",
                                style:
                                    fonts.headline2.copyWith(fontSize: 14.sp),
                              ),
                              4.verticalSpace,
                              Opacity(
                                opacity: 0.50,
                                child: Text(
                                  car.region?.name ?? "",
                                  style:
                                      fonts.subtitle1.copyWith(fontSize: 12.sp),
                                ),
                              ),
                              Opacity(
                                opacity: 0.50,
                                child: Text(
                                  dateFormatValue(car.postedAt),
                                  // "time",
                                  style:
                                      fonts.subtitle1.copyWith(fontSize: 12.sp),
                                ),
                              ),
                            ])),
                  ],
                ),
                10.verticalSpace,

                /// icon and number
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    4.horizontalSpace,
                    IconAndNumberComp(
                      icon: icons.eye,
                      number: car.totalViews.toString(),
                    ),
                    IconAndNumberComp(
                      icon: icons.favRedOut,
                      number: car.totalLikes.toString(),
                    ),
                    IconAndNumberComp(
                      icon: icons.chatRed,
                      number: "58",
                    ),
                    const Spacer(),
                    const SizedBox()
                  ],
                ),
                10.verticalSpace,
                Row(children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        context
                            .read<ProfileBloc>()
                            .add(ProfileEvent.putArchive(id: car.id ?? 0));
                      },
                      title: "activate".tr(),
                      backgroundColor: colors.white,
                      titleColor: colors.black,
                      borderColor: colors.text,
                      verticalPadding: 10.h,
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => CustomDialogComponent(
                            title: 'are_you_sure_you_want_delete_ad'.tr(),
                            leftButtonTitle: "cancel".tr(),
                            rightButtonTitle: "delete".tr(),
                            onRightButtonPressed: () {
                              Navigator.pop(ctx);
                              context.read<ProfileBloc>().add(
                                  ProfileEvent.deletePost(id: car.id ?? 0));
                            },
                          ),
                        );
                      },
                      title: "delete".tr(),
                      backgroundColor: colors.white,
                      borderColor: colors.primary,
                      titleColor: colors.primary,
                      verticalPadding: 10.h,
                    ),
                  ),
                ]),
                8.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
