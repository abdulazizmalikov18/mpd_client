import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/specifications/specifications.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/pages/create/comp/mileage_comp.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';
import 'package:orient_motors/utils/extensions.dart';

class BasicInformationWidget extends StatelessWidget {
  const BasicInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return BlocBuilder<AddCarBloc, AddCarState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "select_condition".tr(),
                          style: fonts.subtitle2.copyWith(fontSize: 14.sp),
                        ),
                        16.verticalSpace,
                        Row(
                          children: [
                            SizedBox(
                                height: 32.h,
                                child: CustomOutlinedButton(
                                    backgroundColor:
                                        !(state.createCarReq?.usedCar ?? false)
                                            ? colors.primary
                                            : colors.transparent,
                                    textColor:
                                        !(state.createCarReq?.usedCar ?? false)
                                            ? colors.white
                                            : colors.customGreyC3,
                                    borderColor:
                                        !(state.createCarReq?.usedCar ?? false)
                                            ? colors.primary
                                            : colors.customGreyC3,
                                    verticalPadding: 0,
                                    horizontalPadding: 0,
                                    onPressed: () {
                                      CreateCarReq req =
                                          (state.createCarReq ?? CreateCarReq())
                                              .rebuild((p0) => p0
                                                ..usedCar = false
                                                ..mileage = 0);
                                      context.read<AddCarBloc>().add(
                                          AddCarEvent.setFilterValue(
                                              createCarReq: req,
                                              filterType: FilterType.none));
                                    },
                                    title: "new".tr())),
                            16.horizontalSpace,
                            SizedBox(
                                height: 32.h,
                                child: CustomOutlinedButton(
                                    backgroundColor:
                                        (state.createCarReq?.usedCar ?? false)
                                            ? colors.primary
                                            : colors.transparent,
                                    textColor:
                                        (state.createCarReq?.usedCar ?? false)
                                            ? colors.white
                                            : colors.customGreyC3,
                                    borderColor:
                                        (state.createCarReq?.usedCar ?? false)
                                            ? colors.primary
                                            : colors.customGreyC3,
                                    verticalPadding: 0,
                                    horizontalPadding: 0,
                                    onPressed: () {
                                      CreateCarReq req = (state.createCarReq ??
                                              CreateCarReq())
                                          .rebuild((p0) => p0..usedCar = true);
                                      context.read<AddCarBloc>().add(
                                          AddCarEvent.setFilterValue(
                                              createCarReq: req,
                                              filterType: FilterType.none));
                                    },
                                    title: "used".tr())),
                          ],
                        )
                      ],
                    ),
                  ),
                  if (state.createCarReq?.usedCar ?? false)
                    Column(
                      children: [
                        _divider(colors),
                        MileageOneSliderComp(
                          division: 20,
                          title: 'mileage'.tr(),
                          unit: 'km'.tr(),
                          start: state.createCarReq!.mileage,
                          onSelect: (value) {
                            CreateCarReq req =
                                (state.createCarReq ?? CreateCarReq()).rebuild(
                                    (p0) => p0..mileage = value.toDouble());
                            context.read<AddCarBloc>().add(
                                AddCarEvent.setFilterValue(
                                    createCarReq: req,
                                    filterType: FilterType.none,
                                    isCheck: false));
                          },
                        ),
                      ],
                    ),
                  _divider(colors),

                  //Transmission
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'transmission'.tr(),
                          textAlign: TextAlign.center,
                          style: fonts.subtitle2.copyWith(fontSize: 14.sp),
                        ),
                        8.verticalSpace,
                        SizedBox(
                          height: 40.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return AnimationButtonEffect(
                                onTap: () {
                                  CreateCarReq req = (state.createCarReq ??
                                          CreateCarReq())
                                      .rebuild((p0) => p0
                                        ..transmission =
                                            state.transmissionList?[index].id);
                                  context.read<AddCarBloc>().add(
                                      AddCarEvent.setFilterValue(
                                          createCarReq: req,
                                          filterType: FilterType.none));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 8.h),
                                  decoration: ShapeDecoration(
                                      color: colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          side: BorderSide(
                                              color:
                                                  state.transmissionList?[index]
                                                              .id ==
                                                          state.createCarReq
                                                              ?.transmission
                                                      ? colors.primary
                                                      : colors.customGreyC3,
                                              width: 1.w))),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(icons.avtomat,
                                            colorFilter: ColorFilter.mode(
                                                state.transmissionList?[index]
                                                            .id ==
                                                        state.createCarReq
                                                            ?.transmission
                                                    ? colors.primary
                                                    : colors.customGreyC3,
                                                BlendMode.srcIn)),
                                        4.horizontalSpace,
                                        Text(
                                          state.transmissionList?[index].name ??
                                              "",
                                          textAlign: TextAlign.center,
                                          style: fonts.subtitle1.copyWith(
                                              fontSize: 12.sp,
                                              color:
                                                  state.transmissionList?[index]
                                                              .id ==
                                                          state.createCarReq
                                                              ?.transmission
                                                      ? colors.text
                                                      : colors.customGreyC3),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                16.horizontalSpace,
                            itemCount: state.transmissionList?.length ?? 0,
                          ),
                        ),
                        8.verticalSpace,
                      ],
                    ),
                  ),
                  _divider(colors),

                  //Fuel
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            'fuel_type'.tr(),
                            textAlign: TextAlign.center,
                            style: fonts.subtitle2.copyWith(fontSize: 14.sp),
                          ),
                        ),
                        8.verticalSpace,
                        SizedBox(
                          height: 40.h,
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return AnimationButtonEffect(
                                onTap: () {
                                  CreateCarReq req =
                                      (state.createCarReq ?? CreateCarReq())
                                          .rebuild((p0) => p0
                                            ..fuelType =
                                                state.fuelTypeList?[index].id);
                                  context.read<AddCarBloc>().add(
                                      AddCarEvent.setFilterValue(
                                          createCarReq: req,
                                          filterType: FilterType.none));
                                },
                                child: Container(
                                  height: 40.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 8.h),
                                  decoration: ShapeDecoration(
                                      color: colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          side: BorderSide(
                                              color: state.fuelTypeList?[index]
                                                          .id ==
                                                      state.createCarReq
                                                          ?.fuelType
                                                  ? colors.primary
                                                  : colors.customGreyC3,
                                              width: 1.w))),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(icons.avtomat,
                                            colorFilter: ColorFilter.mode(
                                                state.fuelTypeList?[index].id ==
                                                        state.createCarReq
                                                            ?.fuelType
                                                    ? colors.primary
                                                    : colors.customGreyC3,
                                                BlendMode.srcIn)),
                                        4.horizontalSpace,
                                        Text(
                                          // 'Автомат',
                                          state.fuelTypeList?[index].name ?? "",
                                          textAlign: TextAlign.center,
                                          style: fonts.subtitle1.copyWith(
                                              fontSize: 12.sp,
                                              color: state.fuelTypeList?[index]
                                                          .id ==
                                                      state.createCarReq
                                                          ?.fuelType
                                                  ? colors.text
                                                  : colors.customGreyC3),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                16.horizontalSpace,
                            itemCount: state.fuelTypeList?.length ?? 0,
                          ),
                        ),
                        8.verticalSpace,
                      ],
                    ),
                  ),
                  _divider(colors),
                  //Color
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            'color'.tr(),
                            textAlign: TextAlign.center,
                            style: fonts.subtitle2.copyWith(fontSize: 14.sp),
                          ),
                        ),
                        8.verticalSpace,
                        if ((state.paintConditionList?.length ?? 0) > 1)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: colors.customGreyC3)),
                            child: DropdownButton<int>(
                                value: state.createCarReq?.paintCondition,
                                isExpanded: true,
                                hint: Text(
                                  "color_status".tr(),
                                  style: fonts.subtitle1
                                      .copyWith(color: colors.customGreyC3),
                                ),
                                items: state.paintConditionList!
                                    .map((DriveUnitModel value) {
                                  return DropdownMenuItem<int>(
                                    value: value.id,
                                    child: Text(
                                      value.title ?? "",
                                      style: fonts.subtitle1,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (int? id) {
                                  CreateCarReq req = (state.createCarReq ??
                                          CreateCarReq())
                                      .rebuild((p0) => p0..paintCondition = id);
                                  context.read<AddCarBloc>().add(
                                      AddCarEvent.setFilterValue(
                                          createCarReq: req,
                                          filterType: FilterType.none));
                                },
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(8.r),
                                dropdownColor: colors.customGreyE1),
                          ),
                        16.verticalSpace,
                        GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Center(
                              child: AnimationButtonEffect(
                                onTap: () {
                                  CreateCarReq req = (state.createCarReq ??
                                          CreateCarReq())
                                      .rebuild((p0) => p0
                                        ..color = state.colorList?[index].id);
                                  context.read<AddCarBloc>().add(
                                      AddCarEvent.setFilterValue(
                                          createCarReq: req,
                                          filterType: FilterType.none));
                                },
                                child: _colorComp(
                                  color:
                                      colorValue(state.colorList?[index].code),
                                  title: state.colorList?[index].name ?? "",
                                  colorSelect: state.colorList?[index].id ==
                                          state.createCarReq?.color
                                      ? colors.primary
                                      : colors.text,
                                  colorSelectBorder: state
                                              .colorList?[index].id ==
                                          state.createCarReq?.color
                                      ? colors.primary
                                      : colorValue(state.colorList?[index].code)
                                                  .value ==
                                              0xffffffff
                                          ? colors.customGreyC3
                                          : colors.transparent,
                                ),
                              ),
                            );
                          },
                          itemCount: state.colorList?.length ?? 0,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  mainAxisSpacing: 8.w,
                                  crossAxisSpacing: 8.h,
                                  childAspectRatio: 0.9),
                        ),
                        16.verticalSpace,
                      ],
                    ),
                  ),
                  _divider(colors),
                  120.verticalSpace,
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomButton(
                onPressed: () {
                  context.read<AddCarBloc>().add(AddCarEvent.setFilterValue(
                        createCarReq: state.createCarReq ?? CreateCarReq(),
                        filterType: FilterType.replacedParts,
                      ));
                },
                backgroundColor: colors.primary,
                title: "continue".tr(),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _colorComp({
    required Color color,
    required String title,
    required Color colorSelect,
    required Color colorSelectBorder,
  }) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(1),
            decoration: ShapeDecoration(
              shape: CircleBorder(
                  side: BorderSide(
                color: colorSelectBorder,
              )),
            ),
            child: Container(
              height: 40.w,
              width: 40.w,
              decoration: ShapeDecoration(
                  color: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  )),
            ),
          ),
          4.verticalSpace,
          AutoSizeText(
            title,
            minFontSize: 8,
            textAlign: TextAlign.center,
            maxLines: 1,
            style:
                fonts.subtitle1.copyWith(fontSize: 12.sp, color: colorSelect),
          ),
        ],
      );
    });
  }

  Container _divider(CustomColorSet colors) {
    return Container(
      width: double.infinity,
      height: 12.h,
      color: colors.backgroundScaffold,
    );
  }
}
