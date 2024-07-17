import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/car_detail_bloc/car_detail_bloc.dart';
import 'package:orient_motors/domain/extensions/extension.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/extensions.dart';

class ShortInfoComp extends StatelessWidget {
  const ShortInfoComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<CarDetailBloc, CarDetailState>(
          builder: (context, state) {
        final data = state.carDetailRes;
        return data == null
            ? ShimmerView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          ShimmerContainer(width: 260, height: 20),
                          Spacer(),
                          ShimmerContainer(width: 60, height: 20),
                        ],
                      ),
                      8.verticalSpace,
                      Opacity(
                        opacity: 0.5,
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              const ShimmerContainer(width: 80, height: 16),
                              VerticalDivider(
                                  color: colors.text,
                                  indent: 5.h,
                                  endIndent: 5.h),
                              const ShimmerContainer(width: 80, height: 16),
                              VerticalDivider(
                                  color: colors.text,
                                  indent: 5.h,
                                  endIndent: 5.h),
                              const ShimmerContainer(width: 80, height: 16),
                            ],
                          ),
                        ),
                      ),
                      8.verticalSpace,
                      const Row(
                        children: [
                          ShimmerContainer(width: 120, height: 16),
                          Spacer(),
                          ShimmerContainer(width: 160, height: 16),
                        ],
                      ),
                      16.verticalSpace,
                    ],
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "${data.brand?.name ?? ''} ${data.carModel?.name ?? ''}",
                          style: fonts.headline1
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        trailing: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 8.w),
                          decoration: BoxDecoration(
                              color: data.usedCar ?? false
                                  ? colors.primary
                                  : colors.grey,
                              borderRadius: BorderRadius.circular(4.r)),
                          child: Text(
                            data.usedCar ?? false ? "used".tr() : "new".tr(),
                            style:
                                fonts.subtitle1.copyWith(color: colors.white),
                          ),
                        ),
                      ),
                      8.verticalSpace,
                      Opacity(
                        opacity: 0.5,
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Text(
                                // '2023г',
                                "${data.year.toString()}${"y".tr()}",
                                style: Style.medium14(size: 13.sp),
                              ),
                              VerticalDivider(
                                  color: colors.text,
                                  indent: 4.h,
                                  endIndent: 4.h),
                              Text(
                                // '0км',
                                "${data.mileage.toString()}${"km".tr()}",
                                style: Style.medium14(size: 13.sp),
                              ),
                              VerticalDivider(
                                  color: colors.text,
                                  indent: 4.h,
                                  endIndent: 4.h),
                              Text(
                                data.fuelType?.name ?? '',
                                style: Style.medium14(size: 13.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          Text(
                            "${data.price?.toFormattedCurrency(dbService: context.read<DBService>(), currencyS: data.currency) ?? 0}",
                            style: fonts.subtitle1
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Opacity(
                            opacity: 0.5,
                            child: Text(
                              "${data.region?.name}, ${dateFormatValue(data.postedAt)}",
                              style: Style.medium14(size: 10.sp),
                            ),
                          )
                        ],
                      ),
                      8.verticalSpace,
                    ],
                  ),
                ),
              );
      });
    });
  }
}
