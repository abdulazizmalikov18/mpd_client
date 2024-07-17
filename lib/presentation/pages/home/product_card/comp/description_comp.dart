import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/car_detail_bloc/car_detail_bloc.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/ask_the_seller_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class DescriptionComp extends StatefulWidget {
  const DescriptionComp({super.key});

  @override
  State<DescriptionComp> createState() => _DescriptionCompState();
}

class _DescriptionCompState extends State<DescriptionComp> {
  late bool isExpanded;
  final int limitLength = 250;

  @override
  void initState() {
    isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<CarDetailBloc, CarDetailState>(
          builder: (context, state) {
            final data = state.carDetailRes;
            return ColoredBox(
              color: colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'description2'.tr(),
                            style: Style.semiBold16(size: 20.sp),
                          ),
                          8.verticalSpace,
                          data == null
                              ? const ShimmerView(
                                  child:
                                      ShimmerContainer(width: 300, height: 20),
                                )
                              : Text(
                                  isExpanded
                                      ? '${data.description}'
                                      : (data.description?.length ?? 0) >
                                              limitLength
                                          ? data.description
                                                  ?.substring(0, limitLength) ??
                                              ""
                                          : data.description ?? "",
                                  maxLines: isExpanded ? null : 4,
                                  style: Style.medium16(
                                      color: colors.text.withOpacity(0.7)),
                                ),
                          4.verticalSpace,
                          if ((data?.description?.length ?? 0) > limitLength)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero),
                              child: Text(
                                isExpanded
                                    ? 'hide'.tr()
                                    : 'show_completely'.tr(),
                                style: const TextStyle(
                                  color: Color(0xFFC10505),
                                  fontSize: 16,
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    18.verticalSpace,
                    Divider(
                      color: colors.backgroundScaffold,
                      thickness: 8.h,
                      height: 0,
                    ),
                    const AskTheSellerComp(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
