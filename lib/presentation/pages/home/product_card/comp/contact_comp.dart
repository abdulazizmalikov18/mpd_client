import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/application/car_detail_bloc/car_detail_bloc.dart';
import 'package:orient_motors/presentation/component/custom_float_action_button.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactComp extends StatelessWidget {
  final Function function;
  const ContactComp({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<CarDetailBloc, CarDetailState>(
          builder: (context, state) {
        final data = state.carDetailRes;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomFloatActionButton(
                  function: function,
                  icon: icons.up.svg(
                    color: colors.black,
                  ),
                ),
                16.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: InkWell(
                        onTap: () async {
                          String url = data?.owner?.username ?? "";
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(
                              Uri.parse(url),
                            );
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Container(
                          height: 57.h,
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          decoration: ShapeDecoration(
                            color: colors.primary,
                            shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(width: 1.w, color: colors.primary),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          child: data?.timeFrom == null ||
                                  data?.timeTo == null ||
                                  (data?.time24 ?? true)
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'call'.tr(),
                                      style: fonts.subtitle2.copyWith(
                                          color: colors.white, fontSize: 18.sp),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'call'.tr(),
                                      style: fonts.subtitle2.copyWith(
                                          color: colors.white, fontSize: 18.sp),
                                    ),
                                    Text(
                                      "${data?.timeFrom ?? ""} - ${data?.timeTo ?? ""}",
                                      style: fonts.bodyText1
                                          .copyWith(color: colors.white),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 56.h,
                        padding: EdgeInsets.all(12.w),
                        decoration: ShapeDecoration(
                          color: colors.customBlack,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: SvgPicture.asset(
                          icons.chat,
                          height: 32.h,
                          colorFilter:
                              ColorFilter.mode(colors.white, BlendMode.srcIn),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
