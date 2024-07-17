import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
import 'package:orient_motors/presentation/pages/home/comp/review_cars_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/review_shimmer_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/stars_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/table_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SpecificationWidget extends StatelessWidget {
  const SpecificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) {
            final model = state.specificationModel;
            final techModel = model?.parametres ?? Parametres();
            final rating =
                state.safetyConvenienceModel?.ratedByOrientMotors ?? 0;
            if (state.statusSafetyConvenience ==
                    FormzSubmissionStatus.inProgress ||
                state.statusSafetyConvenience ==
                    FormzSubmissionStatus.initial) {
              return const ReviewShimmerComp();
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                StarsComp(
                  starCount: rating,
                  title: "specification".tr(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _buildSpesification(
                                model: model?.advantages.toList() ?? [])),
                        Expanded(
                            child: _buildSpesification(
                                model: model?.disadvantages.toList() ?? [],
                                isGood: false)),
                      ],
                    ),
                  ),
                ),
                Text("technical_specification".tr(), style: Style.medium16()),
                TableComp(
                  children: [
                    ["length".tr(), "${techModel.length?.toInt()}"],
                    ["width".tr(), "${techModel.width?.toInt()}"],
                    ["height".tr(), "${techModel.height?.toInt()}"],
                    ["unloaded_weight".tr(), "${techModel.weight?.toInt()}"],
                    ["horse_power".tr(), "${techModel.horsePower?.toInt()}"],
                    ["engine_type".tr(), techModel.engineType ?? ""],
                    ["wheelbase".tr(), "${techModel.volume?.toInt()}"],
                    ["capacity".tr(), "${techModel.fuelTankCapacity?.toInt()}"],
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

  Widget _buildSpesification(
      {bool isGood = true, required List<Advantage> model}) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: ColoredBox(
              color: isGood ? colors.customRed : colors.black,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    isGood
                        ? icons.good.svg(height: 24)
                        : icons.bad.svg(height: 24),
                    10.verticalSpace,
                    Text(
                      isGood ? "advantages".tr() : "disadvantages".tr(),
                      style: Style.semiBold16(size: 12, color: colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ...(model
              .asMap()
              .entries
              .map(
                (item) => DecoratedBox(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colors.customGreyE1),
                      borderRadius: item.key == model.length - 1
                          ? BorderRadius.only(
                              bottomLeft: isGood
                                  ? const Radius.circular(15)
                                  : Radius.zero,
                              bottomRight: !isGood
                                  ? const Radius.circular(15)
                                  : Radius.zero,
                            )
                          : BorderRadius.zero,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.value.title ?? "",
                          style: Style.semiBold16(size: 12),
                        ),
                        Text(
                          item.value.text ?? "",
                          style: Style.regular12(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList()),
        ],
      );
    });
  }
}
