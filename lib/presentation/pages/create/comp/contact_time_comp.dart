import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/component/custom_checkbox.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

import '../../../../utils/enum_filtr.dart';

class ContactTimeComp extends StatelessWidget {
  const ContactTimeComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return BlocBuilder<AddCarBloc, AddCarState>(builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'time_to_contact_you'.tr(),
              textAlign: TextAlign.center,
              style: fonts.subtitle2.copyWith(fontSize: 14.sp),
            ),
            8.verticalSpace,
            Container(
              height: 40.h,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: colors.customGreyC3),
                borderRadius: BorderRadius.circular(5.r),
              )),
              child: Row(
                children: [
                  Row(children: [
                    CustomCheckBoxComponent(
                      isCheck: state.createCarReq?.time24 ?? false,
                      onChanged: () {
                        CreateCarReq req =
                            (state.createCarReq ?? CreateCarReq())
                                .rebuild((p0) => p0
                                  ..time24 = true
                                  ..timeFrom = null
                                  ..timeTo = null);
                        context.read<AddCarBloc>().add(
                            AddCarEvent.setFilterValue(
                                createCarReq: req,
                                filterType: FilterType.none));
                      },
                    ),
                    Text(
                      'available_24_hours'.tr(),
                      style: fonts.subtitle1.copyWith(fontSize: 12.sp),
                    ),
                  ]),
                  8.horizontalSpace,
                  Row(children: [
                    CustomCheckBoxComponent(
                      isCheck: !(state.createCarReq?.time24 ?? false),
                      onChanged: () {
                        CreateCarReq req =
                            (state.createCarReq ?? CreateCarReq()).rebuild(
                                (p0) => p0
                                  ..time24 = false
                                  ..timeFrom = DateFormat("HH:mm")
                                      .format(DateTime(2024, 01, 01, 06))
                                  ..timeTo = DateFormat("HH:mm")
                                      .format(DateTime(2024, 01, 01, 22)));
                        context.read<AddCarBloc>().add(
                            AddCarEvent.setFilterValue(
                                createCarReq: req,
                                filterType: FilterType.none));
                      },
                    ),
                    Text(
                      'timing'.tr(),
                      textAlign: TextAlign.start,
                      style: fonts.subtitle1.copyWith(fontSize: 12.sp),
                    ),
                  ]),
                ],
              ),
            ),
            16.verticalSpace,
            if (!(state.createCarReq?.time24 ?? false))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'specify_time'.tr(),
                    textAlign: TextAlign.start,
                    style: fonts.subtitle2.copyWith(fontSize: 14.sp),
                  ),
                  4.verticalSpace,
                  Row(children: [
                    SizedBox(
                      width: 130.w,
                      child: OutlinedButton(
                          onPressed: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              if (value != null) {
                                DateTime date = DateFormat("HH:mm")
                                    .parse(value.format(context));
                                CreateCarReq req =
                                    (state.createCarReq ?? CreateCarReq())
                                        .rebuild((p0) => p0
                                          ..timeFrom =
                                              DateFormat("HH:mm").format(date));
                                context.read<AddCarBloc>().add(
                                    AddCarEvent.setFilterValue(
                                        createCarReq: req,
                                        filterType: FilterType.none));
                              }
                            });
                          },
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                width: 1.w,
                                color: colors.customGreyC3,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              )),
                          child: Text(
                            state.createCarReq?.timeFrom == null
                                ? "00:00"
                                : state.createCarReq?.timeFrom ?? "",
                            style: fonts.subtitle1,
                          )),
                    ),
                    8.horizontalSpace,
                    SizedBox(
                      width: 130.w,
                      child: OutlinedButton(
                          onPressed: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              if (value != null) {
                                CreateCarReq req =
                                    (state.createCarReq ?? CreateCarReq());
                                DateTime endDate = DateFormat("HH:mm")
                                    .parse(value.format(context));

                                req = req.rebuild((p0) => p0
                                  ..timeTo =
                                      DateFormat("HH:mm").format(endDate));
                                context.read<AddCarBloc>().add(
                                    AddCarEvent.setFilterValue(
                                        createCarReq: req,
                                        filterType: FilterType.none));
                              }
                            });
                          },
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                width: 1.w,
                                color: colors.customGreyC3,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  side: BorderSide(
                                      width: 1.w, color: colors.customGreyC3))),
                          child: Text(
                            state.createCarReq?.timeTo == null
                                ? "00:00"
                                : state.createCarReq?.timeTo ?? "",
                            style: fonts.subtitle1,
                          )),
                    ),
                  ]),
                  12.verticalSpace,
                ],
              ),
            Text(
              'display_contacts_on_the_vehicle_details'.tr(),
              style: fonts.subtitle1
                  .copyWith(fontSize: 10.sp, color: colors.customGreyC3),
            ),
            24.verticalSpace,
          ],
        );
      });
    });
  }
}
