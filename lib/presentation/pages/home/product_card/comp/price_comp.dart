import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/application/car_detail_bloc/car_detail_bloc.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class PriceComp extends StatefulWidget {
  const PriceComp({super.key});

  @override
  State<PriceComp> createState() => _PriceCompState();
}

class _PriceCompState extends State<PriceComp> {
  int priceCar = 950000;
  int maxPrice = 1000000;

  int flex1 = 1;
  int flex2 = 1;
  int flex3 = 1;
  int flex4 = 1;

  @override
  void initState() {
    if (maxPrice > priceCar) {
      int difference = maxPrice ~/ 6.25;

      flex1 = priceCar;
      flex2 = maxPrice - priceCar;
      if (priceCar > maxPrice - difference / 2) {
        flex3 = difference - flex2;
        flex4 = flex2;
        flex2 = 1;
      } else if (priceCar < difference / 2) {
        flex4 = difference - flex1;
        flex3 = flex1;
        flex1 = 1;
      }
    } else {
      flex1 = 100;
      flex2 = 1;
      flex3 = 100;
      flex4 = 1;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<CarDetailBloc, CarDetailState>(
          builder: (context, state) {
        final data = state.carDetailRes;
        return ColoredBox(
            color: colors.white,
            child: Padding(
                padding: EdgeInsets.all(20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'good_price'.tr(),
                      style: Style.semiBold16(size: 20.sp),
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
                    15.verticalSpace,
                    Row(
                      children: [
                        Spacer(
                          flex: flex1,
                        ),
                        Column(
                          children: [
                            DecoratedBox(
                              decoration: ShapeDecoration(
                                color: colors.searchTextfieldColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.w, color: colors.customGreyC3),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              ),
                              child: SizedBox(
                                height: 27.h,
                                width: 57.w,
                                child: Center(
                                  child: SvgPicture.asset(
                                    icons.priceIconCar,
                                    height: 11.h,
                                    width: 37.w,
                                    fit: BoxFit.contain,
                                    colorFilter: ColorFilter.mode(
                                        priceCar / maxPrice < 0.67
                                            ? priceCar / maxPrice > 0.33
                                                ? colors.customOrange
                                                : colors.customGreen
                                            : colors.customRed,
                                        BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                              width: 59.w,
                              child: Row(
                                children: [
                                  Spacer(
                                    flex: flex3,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                    child: VerticalDivider(
                                      width: 1.sp,
                                      thickness: 1.sp,
                                      color: colors.customGreyC3,
                                    ),
                                  ),
                                  Spacer(
                                    flex: flex4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Spacer(
                          flex: flex2,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                                height: 4.sp,
                                thickness: 4.sp,
                                color: colors.customGreen),
                            21.verticalSpace,
                            Text(
                              'Низкая\nцена',
                              style: Style.semiBold16(
                                  color: const Color(0xFFC3C3C3), size: 14.sp),
                            )
                          ],
                        )),
                        0.5.horizontalSpace,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                                height: 4.sp,
                                thickness: 4.sp,
                                color: colors.customOrange),
                            21.verticalSpace,
                            Text(
                              'Хорошая\nцена',
                              style: Style.semiBold16(
                                  color: const Color(0xFFC3C3C3), size: 14.sp),
                            )
                          ],
                        )),
                        0.5.horizontalSpace,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                                height: 4.sp,
                                thickness: 4.sp,
                                color: colors.customRed),
                            21.verticalSpace,
                            Text(
                              'Высокая\nцена',
                              style: Style.semiBold16(
                                  color: const Color(0xFFC3C3C3), size: 14.sp),
                            )
                          ],
                        ))
                      ],
                    ),
                    16.verticalSpace,
                    Text(
                      'average_price_for'.tr(),
                      style: Style.semiBold14(),
                    ),
                    8.verticalSpace,
                  ],
                )));
      });
    });
  }
}
