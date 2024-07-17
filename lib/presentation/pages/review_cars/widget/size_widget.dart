import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
import 'package:orient_motors/presentation/pages/home/comp/review_cars_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/content_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/review_shimmer_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/stars_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/table_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) {
            final model = state.sizeSpaceModel;
            if (state.statusSizeSpace == FormzSubmissionStatus.inProgress ||
                state.statusSizeSpace == FormzSubmissionStatus.initial) {
              return const ReviewShimmerComp();
            }
            return ListView(
              children: [
                16.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: StarsComp(
                    starCount: model?.ratedByOrientMotors ?? 0,
                    title: "size".tr(),
                  ),
                ),
                16.verticalSpace,
                ContentComp(
                    title: "size".tr(),
                    subTitle: model?.dimensionsAndSpace ?? ""),
                _sizePart(colors, icons, model),
                _sizeWeightPart(colors, icons, model),
                const ReviewCarsComp(),
                const PolicyComp(),
                36.verticalSpace,
              ],
            );
          },
        );
      },
    );
  }

  Widget _sizeWeightPart(
      CustomColorSet colors, IconSet icons, ReviewSizeSpaceModel? model) {
    final dimension = model?.dimension;
    return ColoredBox(
      color: colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.verticalSpace,
            Text(
              'volume_weight'.tr(),
              style: Style.medium16(size: 18.sp),
            ),
            12.verticalSpace,
            TableComp(
              children: [
                ["length".tr(), "${dimension?.length?.toInt()}"],
                ["width".tr(), "${dimension?.width?.toInt()}"],
                ["height".tr(), "${dimension?.height?.toInt()}"],
                ["unloaded_weight".tr(), "${dimension?.weight?.toInt()}"],
                ["horse_power".tr(), "${dimension?.horsePower?.toInt()}"],
                ["engine_type".tr(), dimension?.engineType ?? ""],
                ["wheelbase".tr(), "${dimension?.volume?.toInt()}"],
                ["capacity".tr(), "${dimension?.fuelTankCapacity?.toInt()}"],
              ],
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _sizePart(
      CustomColorSet colors, IconSet icons, ReviewSizeSpaceModel? model) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 390.h,
        width: double.infinity,
        child: DecoratedBox(
          decoration: ShapeDecoration(
            color: colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.w, color: const Color(0xFFE6E6E6)),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: ListView.separated(
            itemCount: 2,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(16),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return index == 0
                  ? Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(width: 56),
                            CachedNetworkImage(
                              imageUrl: model?.heightWidthPhoto ?? "",
                              fit: BoxFit.contain,
                              height: 112.h,
                              width: 158.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 24.h,
                                  width: 1.w,
                                  color: colors.black,
                                ),
                                4.verticalSpace,
                                Text(
                                  'height2'.tr(),
                                  style: Style.medium14(size: 10.sp),
                                ),
                                4.verticalSpace,
                                Text(
                                  "${(model?.dimension?.height?.toInt() ?? 0)} mm",
                                  style: Style.medium14(size: 10.sp),
                                ),
                                4.verticalSpace,
                                Container(
                                  height: 24.h,
                                  width: 1.w,
                                  color: colors.black,
                                ),
                              ],
                            )
                          ],
                        ),
                        24.verticalSpace,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 1.w,
                                      width: 16.w,
                                      color: colors.black,
                                    ),
                                    8.horizontalSpace,
                                    Text(
                                      "width2".tr(),
                                      style: Style.medium14(size: 10.sp),
                                    ),
                                    4.horizontalSpace,
                                    Text(
                                      "${(model?.dimension?.width?.toInt() ?? 0)} mm",
                                      style: Style.medium14(size: 10.sp),
                                    ),
                                    8.horizontalSpace,
                                    Container(
                                      height: 1.w,
                                      width: 16.w,
                                      color: colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: model?.lengthPhoto ?? "",
                          width: 240.w,
                          height: 94.h,
                          fit: BoxFit.contain,
                        ),
                        24.verticalSpace,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 1.h,
                              width: 16.w,
                              color: colors.black,
                            ),
                            8.horizontalSpace,
                            Text(
                              "${"wheelbase2".tr()} ${model?.dimension?.weight?.toInt() ?? 0} mm",
                              style: Style.medium14(size: 10.sp),
                            ),
                            8.horizontalSpace,
                            Container(
                              height: 1.h,
                              width: 16.w,
                              color: colors.black,
                            ),
                          ],
                        ),
                        4.verticalSpace,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 1.h,
                              width: 50.w,
                              color: colors.black,
                            ),
                            8.horizontalSpace,
                            Text(
                              "${"length2".tr()} ${model?.dimension?.length?.toInt() ?? 0} mm",
                              style: Style.medium14(size: 10.sp),
                            ),
                            8.horizontalSpace,
                            Container(
                              height: 1.h,
                              width: 50.w,
                              color: colors.black,
                            ),
                          ],
                        ),
                      ],
                    );
            },
            separatorBuilder: (ctx, index) => 24.verticalSpace,
          ),
        ),
      ),
    );
  }
}
