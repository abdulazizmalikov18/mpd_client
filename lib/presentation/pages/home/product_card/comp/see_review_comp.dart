import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/car_detail_bloc/car_detail_bloc.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/pages/review_cars/controller/review_controller.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SeeReviewComp extends StatelessWidget {
  const SeeReviewComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<CarDetailBloc, CarDetailState>(
          builder: (context, state) {
        final CarModel? data = state.carDetailRes;

        return ColoredBox(
            color: colors.white,
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'need_review_this_car'.tr(),
                      style: Style.semiBold16(size: 18.sp),
                    ),
                    4.verticalSpace,
                    data == null
                        ? const ShimmerView(
                            child: ShimmerContainer(width: 300, height: 20))
                        : Text(
                            "${data.brand?.name ?? ''} ${data.carModel?.name ?? ''}",
                            style: Style.medium16(
                                color: colors.text.withOpacity(0.7)),
                          ),
                    24.verticalSpace,
                    BlocBuilder<ReviewBloc, ReviewState>(
                      builder: (context, stateReview) {
                        return CustomButton(
                          onPressed: () {
                            if (stateReview.idEither?.carReviewId != null) {
                              Navigator.push(
                                context,
                                AppRoutes.getReviewCarDetail(
                                  context,
                                  ReviewListModel((b) => b
                                    ..id = data?.id
                                    ..carModel.brand = data?.brand?.toBuilder()
                                    ..carModel = data?.carModel?.toBuilder()),
                                  ReviewController(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                AppRoutes.getVoteGeneration(
                                  model: ReviewFilterReq(
                                    (b) => b
                                      ..mark = state.carDetailRes?.brand?.id
                                      ..model = state.carDetailRes?.carModel?.id
                                      ..generation =
                                          state.carDetailRes?.generation?.id,
                                  ),
                                  context: context,
                                ),
                              );
                            }
                          },
                          title: "see_review".tr(),
                          backgroundColor: colors.white,
                          titleColor: colors.primary,
                          verticalPadding: 4.h,
                        );
                      },
                    ),
                    8.verticalSpace,
                  ],
                )));
      });
    });
  }
}
