import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/application/car_detail_bloc/car_detail_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';

import '../../../../../utils/extensions.dart';

class RecordBookComp extends StatefulWidget {
  const RecordBookComp({super.key});

  @override
  State<RecordBookComp> createState() => _RecordBookCompState();
}

class _RecordBookCompState extends State<RecordBookComp> {
  @override
  Widget build(BuildContext context) {
    List<NamedModel> changedPartsQualityList =
        context.read<DBService>().changedPartsQualityList;
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<CarDetailBloc, CarDetailState>(
          builder: (context, state) {
        return ColoredBox(
            color: colors.white,
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'car_condition_record_book'.tr(),
                      style: fonts.subtitle2,
                    ),
                    8.verticalSpace,
                    Text("the_content_of_this_performance_review_entry".tr(),
                        style: fonts.subtitle1
                            .copyWith(color: colors.text.withOpacity(0.7))),
                    16.verticalSpace,
                    Center(
                      child: SizedBox(
                        width: 350.w * 0.8,
                        height: 478.w * 0.8,
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: [
                            Positioned.fill(
                              child: SvgPicture.asset(
                                icons.mFrontUnSelected,
                                width: 350.w * 0.8,
                                height: 478.w * 0.8,
                              ),
                            ),
                            for (int i = 0;
                                i < coordinatesAutoImage.length;
                                i++)
                              Positioned(
                                  top: coordinatesAutoImage[i].height * 0.8,
                                  left: coordinatesAutoImage[i].width * 0.8,
                                  child: _buildButton(
                                    changed: state.carDetailRes?.changedPart
                                            ?.toList() ??
                                        [],
                                    partIndex: i,
                                    onPressed: () {},
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
                            changedPartsQualityList.length,
                            (index) => _buildWrapItem(
                                title:
                                    changedPartsQualityList[index].name ?? "",
                                color: colorValue(changedPartsQualityList[index]
                                    .code))).toList(),
                      ),
                    ),
                  ],
                )));
      });
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
                  .copyWith(fontSize: 10.sp, color: colors.white),
            ),
          ),
        ),
        4.horizontalSpace,
        Text(title, style: fonts.subtitle1.copyWith(fontSize: 11.sp)),
      ]);
    });
  }
}

Widget _buildButton({
  required VoidCallback onPressed,
  required List<ChangedPart> changed,
  required int partIndex,
}) {
  return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
    int lastIndex = changed
        .lastIndexWhere((element) => partIndex + 1 == element.changedPart?.id);
    ChangedPart? changedPart = lastIndex != -1 ? changed[lastIndex] : null;
    return InkWell(
        onTap: () {
          if (changedPart?.description?.isNotEmpty ?? false) {
            showDialog(
                context: context,
                builder: (ctx) => _DialogChangedPart(changedPart!));
          }
        },
        child: Container(
          height: 20.w,
          width: 20.w,
          decoration: BoxDecoration(
            color: //
                changedPart != null
                    ? //
                    colorValue(changedPart.changedPartQuality?.code)
                    : colors.confirmed,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Center(
            child: changedPart != null
                ? Text(
                    changedPart.changedPartQuality?.name
                            ?.substring(0, 1)
                            .toUpperCase() ??
                        "",
                    textAlign: TextAlign.center,
                    style: fonts.subtitle2
                        .copyWith(fontSize: 10.sp, color: colors.white),
                  )
                : Padding(
                    padding: EdgeInsets.all(4.r),
                    child: icons.check.svg(
                      color: colors.white,
                      height: 12,
                    ),
                  ),
          ),
        ));
  });
}

class _DialogChangedPart extends StatelessWidget {
  final ChangedPart changedPart;

  const _DialogChangedPart(this.changedPart);

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Dialog(
        backgroundColor: colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                changedPart.changedPart?.name ?? "",
                style: fonts.headline1,
              ),
              8.verticalSpace,
              Text(
                "${changedPart.changedPartQuality?.name ?? ""}: ${changedPart.description ?? ""}",
                style: fonts.bodyText1,
              ),
              16.verticalSpace,
              CustomButton(
                  verticalPadding: 8,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  title: "close".tr())
            ],
          ),
        ),
      );
    });
  }
}
