import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/domain/extensions/extension.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/cached_image_component.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_dialog_component.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/ads/comp/ads_empty_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class DraftWidget extends StatefulWidget {
  const DraftWidget({super.key});

  @override
  State<DraftWidget> createState() => _DraftWidgetState();
}

class _DraftWidgetState extends State<DraftWidget> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) =>
            previous.deleteDraft != current.deleteDraft && current.deleteDraft,
        listener: (context, state) {
          if (state.deleteDraft) {
            context.read<ProfileBloc>().add(const ProfileEvent.getDrafts());
          }
        },
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          return //
              (state.draftList ?? []).isEmpty
                  ? AdsEmptyComp(title: 'you_don_thave_any_ads'.tr())
                  : _archiveList(
                      archiveList: state.draftList ?? [],
                      colors: colors,
                      icons: icons,
                      fonts: fonts);
        }),
      );
    });
  }

  Widget _archiveList({
    required CustomColorSet colors,
    required IconSet icons,
    required FontSet fonts,
    required List<CarModel> archiveList,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 180.h),
      itemCount: archiveList.length,
      itemBuilder: (BuildContext context, int index) {
        final car = archiveList[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: colors.white,
            border: Border.all(color: colors.borderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                /// image, model, price
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 3,
                        child: CachedImageComponent(
                          width: double.infinity,
                          height: 90.w,
                          borderRadius: 5.r,
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFE500),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text("draft".tr(),
                                    style: fonts.subtitle1
                                        .copyWith(fontSize: 10.sp)),
                              ),
                              4.verticalSpace,
                              Text(
                                "${car.brand?.name ?? ""} ${car.carModel?.name ?? ""}",
                                style: fonts.subtitle2.copyWith(),
                              ),
                              8.verticalSpace,
                              Text(
                                car.price?.toFormattedCurrency(
                                        dbService: context.read<DBService>(),
                                        currencyS: car.currency) ??
                                    "",
                                style:
                                    fonts.subtitle1.copyWith(fontSize: 14.sp),
                              ),
                            ])),
                  ],
                ),
                10.verticalSpace,
                Row(children: [
                  Expanded(
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                      return CustomButton(
                        onPressed: () {
                          if (state.profileParam?.username != null) {
                            Navigator.push(
                                    context,
                                    AppRoutes.getCreateCar(
                                        draftId: car.id,
                                        phoneNumber:
                                            state.profileParam!.username!,
                                        regionId: state.profileParam?.region))
                                .then((value) {
                              context.read<ProfileBloc>()
                                ..add(const ProfileEvent.getOwnActualCars(
                                    isActive: "1"))
                                ..add(const ProfileEvent.getDrafts());
                              context
                                  .read<BottomNavBarController>()
                                  .changeNavBar(false);
                            });
                          }
                        },
                        title: "activate".tr(),
                        backgroundColor: colors.white,
                        titleColor: colors.black,
                        borderColor: colors.text,
                        verticalPadding: 10.h,
                      );
                    }),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        if (car.id != null) {
                          showDialog(
                            context: context,
                            builder: (ctx) => CustomDialogComponent(
                              title: 'are_you_sure_you_want_delete_ad'.tr(),
                              leftButtonTitle: "cancel".tr(),
                              rightButtonTitle: "delete".tr(),
                              onRightButtonPressed: () {
                                Navigator.pop(ctx);
                                context
                                    .read<ProfileBloc>()
                                    .add(ProfileEvent.deleteDraft(id: car.id!));
                              },
                            ),
                          );
                        }
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
