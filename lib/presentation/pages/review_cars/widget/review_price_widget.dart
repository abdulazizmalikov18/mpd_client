import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
import 'package:orient_motors/presentation/pages/home/comp/review_cars_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/review_shimmer_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/stars_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ReviewPriceWidget extends StatelessWidget {
  const ReviewPriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) {
            final model = state.priceModel;
            if (state.statusPrice == FormzSubmissionStatus.inProgress ||
                state.statusPrice == FormzSubmissionStatus.initial) {
              return const ReviewShimmerComp();
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                StarsComp(
                  starCount: model?.ratedByOrientMotors ?? 0,
                  title: "price".tr(),
                ),
                16.verticalSpace,
                Text(
                  model?.text ?? "",
                  style: Style.medium14(size: 12),
                ),
                16.verticalSpace,
                Row(
                  children: [
                    SizedBox(
                      height: 110.h,
                      width: 2,
                      child: ColoredBox(color: colors.grey88),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(5)),
                              color: colors.grey88,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                "new_car_price_from_to".tr(
                                  namedArgs: {
                                    "from": (model?.newCarFrom).toString(),
                                    "to": (model?.newCarTo).toString(),
                                  },
                                ),
                                style:
                                    Style.bold16(color: colors.white, size: 12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(5)),
                              color: colors.customRed,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                "used_price_from_to".tr(
                                  namedArgs: {
                                    "from": (model?.usedCarFrom).toString(),
                                    "to": (model?.usedCarTo).toString(),
                                  },
                                ),
                                style:
                                    Style.bold16(color: colors.white, size: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const ReviewCarsComp(),
                const PolicyComp(),
                20.verticalSpace,
              ],
            );
          },
        );
      },
    );
  }
}
