import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
import 'package:orient_motors/presentation/pages/home/comp/review_cars_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/content_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/dot_title_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/review_shimmer_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/share_button_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/stars_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SafetyWidget extends StatelessWidget {
  const SafetyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) {
            final model = state.safetyConvenienceModel;
            if (state.statusSafetyConvenience ==
                    FormzSubmissionStatus.inProgress ||
                state.statusSafetyConvenience ==
                    FormzSubmissionStatus.initial) {
              return const ReviewShimmerComp();
            }
            return ListView(
              children: [
                16.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: StarsComp(
                    starCount: model?.ratedByOrientMotors ?? 0,
                    title: "safety_and_convenience".tr().tr(),
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      12.verticalSpace,
                      Text(
                        'advantages'.tr(),
                        textAlign: TextAlign.center,
                        style: Style.medium14(color: colors.primary),
                      ),
                      4.verticalSpace,
                      Divider(color: colors.primary, thickness: 1),
                    ],
                  ),
                ),
                Column(
                  children: model?.advantages
                          ?.map(
                              (param) => DotTitleComp(title: param.title ?? ""))
                          .toList() ??
                      [],
                ),
                16.verticalSpace,
                ColoredBox(
                  color: colors.white,
                  child: const ShareButtonComp(),
                ),
                16.verticalSpace,
                ContentComp(
                    title: "safety_equipment".tr(),
                    subTitle: model?.safetyEquipment ?? ""),
                ContentComp(
                    title: "convenience_equipment".tr(),
                    subTitle: model?.convenienceEquipment ?? ""),
                // ContentComp(title: "comparison_of_safety_and_convenience".tr(), subTitle: "subTitle"),
                16.verticalSpace,
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
}
