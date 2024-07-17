import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_dialog_component.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';
import 'package:orient_motors/utils/extensions.dart';

import '../../../../utils/constants.dart';

class ReplacedPartsWidget extends StatelessWidget {
  const ReplacedPartsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const double scale = 0.9;
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return BlocBuilder<AddCarBloc, AddCarState>(builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'select_your_car_s_replacement_parts'.tr(),
                style: fonts.subtitle1
                    .copyWith(color: colors.text.withOpacity(0.5)),
              ),
              16.verticalSpace,

              ///
              Center(
                child: SizedBox(
                  width: 350.w * scale,
                  height: 478.w * scale,
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Positioned.fill(
                        child: SvgPicture.asset(
                          icons.mFrontUnSelected,
                          width: 350.w * scale,
                          height: 478.w * scale,
                        ),
                      ),
                      for (int i = 0; i < coordinatesAutoImage.length; i++)
                        Positioned(
                            top: coordinatesAutoImage[i].height * scale,
                            left: coordinatesAutoImage[i].width * scale,
                            child: _buildButton(
                              state: state,
                              partIndex: i,
                              onPressed: () {
                                ChangedPartReq? change;
                                int lastIndex = state.createCarReq?.changedPart
                                        ?.toList()
                                        .lastIndexWhere((element) =>
                                            element.partId ==
                                            state.changedPartsList?[i].id) ??
                                    -1;
                                if (lastIndex != -1) {
                                  change = state
                                      .createCarReq?.changedPart?[lastIndex];
                                }
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return BlocProvider.value(
                                        value: context.read<AddCarBloc>(),
                                        child: ChangedPartDialog(
                                          indexPart: i,
                                          selectedId: change?.qualityId,
                                          description: change?.description,
                                        ),
                                      );
                                    });
                              },
                            )),
                    ],
                  ),
                ),
              ),
              16.verticalSpace,
              SizedBox(
                width: 1.sw - 32.w,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 4.h,
                  spacing: 6.w,
                  direction: Axis.horizontal,
                  children: List.generate(
                      state.changedPartsQualityList?.length ?? 0,
                      (index) => _buildWrapItem(
                          title:
                              state.changedPartsQualityList?[index].name ?? "",
                          color: colorValue(state
                              .changedPartsQualityList?[index].code))).toList(),
                ),
              ),
              24.verticalSpace,
              CustomButton(
                onPressed: () {
                  context.read<AddCarBloc>().add(AddCarEvent.setFilterValue(
                      createCarReq: state.createCarReq ?? CreateCarReq(),
                      filterType: FilterType.price));
                },
                backgroundColor: colors.primary,
                title: "continue".tr(),
              ),
              40.verticalSpace,
            ],
          ),
        );
      });
    });
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required AddCarState state,
    required int partIndex,
  }) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return InkWell(
          onTap: onPressed,
          child: Container(
            height: 24.w,
            width: 24.w,
            decoration: BoxDecoration(
              color: //
                  (state.createCarReq?.changedPart?.any((p0) =>
                              p0.partId ==
                              state.changedPartsList?[partIndex].id) ??
                          false)
                      ? //

                      colorValue(state
                          .changedPartsQualityList?[(state
                                      .createCarReq?.changedPart
                                      ?.firstWhere(
                                          (p) =>
                                              p.partId ==
                                              state.changedPartsList?[partIndex]
                                                  .id,
                                          orElse: () => ChangedPartReq())
                                      .qualityId ??
                                  1) -
                              1]
                          .code)
                      //
                      : colors.confirmed,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Center(
              child: (state.createCarReq?.changedPart?.any((p0) =>
                          p0.partId == state.changedPartsList?[partIndex].id) ??
                      false)
                  ? Text(
                      state
                              .changedPartsQualityList?[(state
                                          .createCarReq?.changedPart
                                          ?.firstWhere(
                                              (p) =>
                                                  p.partId ==
                                                  state
                                                      .changedPartsList?[
                                                          partIndex]
                                                      .id,
                                              orElse: () => ChangedPartReq())
                                          .qualityId ??
                                      1) -
                                  1]
                              .name
                              ?.substring(0, 1)
                              .toUpperCase() ??
                          "",
                      textAlign: TextAlign.center,
                      style: fonts.subtitle2
                          .copyWith(fontSize: 12.sp, color: colors.white),
                    )
                  : icons.plus.svg(color: colors.white, height: 18),
            ),
          ));
    });
  }

  Widget _buildWrapItem({required String title, required Color color}) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
          height: 20.w,
          width: 20.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Center(
            child: Text(
              title.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: fonts.subtitle2
                  .copyWith(fontSize: 12.sp, color: colors.white),
            ),
          ),
        ),
        4.horizontalSpace,
        Text(title, style: fonts.subtitle1.copyWith(fontSize: 11.sp)),
      ]);
    });
  }
}
