import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/dot_title_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SpecialistComp extends StatelessWidget {
  const SpecialistComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return ColoredBox(
        color: colors.white,
        child: Column(children: [
          24.verticalSpace,
          Text(
            'diagnostic_specialists'.tr(),
            textAlign: TextAlign.center,
            style: Style.medium16(size: 18.sp),
          ),
          8.verticalSpace,
          SizedBox(
            height: 300.h,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Container(
                    width: 166.w,
                    margin: EdgeInsets.only(
                      left: index == 0 ? 16.0.w : 0.w,
                      right: 16.0.w,
                    ),
                    decoration: ShapeDecoration(
                      color: colors.white,
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(width: 1.w, color: colors.customGreyC3),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Image.asset(icons.specialist, fit: BoxFit.contain),
                        8.verticalSpace,
                        Text(
                          'Тимур Батрутдинов',
                          style: Style.semiBold14(),
                        ),
                        12.verticalSpace,
                        const DotTitleComp(
                            title: "12 лет опыта", hasDivider: false),
                        const DotTitleComp(
                            title: "Инженер по ремонту автомобилей",
                            hasDivider: false),
                      ]),
                    ),
                  );
                },
                itemCount: 4),
          ),
          24.verticalSpace,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     const Spacer(),
          //     AnimationButtonEffect(
          //       onTap: () {
          //         // _pageController.previousPage(
          //         //   duration: const Duration(milliseconds: 300),
          //         //   curve: Curves.easeIn,
          //         // );
          //       },
          //       child: Container(
          //         alignment: Alignment.center,
          //         height: 35.w,
          //         width: 35.w,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(5.r),
          //           ),
          //           color: colors.transparent.withOpacity(0.5),
          //         ),
          //         child: Icon(Icons.keyboard_arrow_left_outlined,
          //             color: colors.white),
          //       ),
          //     ),
          //     20.horizontalSpace,
          //     AnimationButtonEffect(
          //       onTap: () {
          //         // _pageController.nextPage(
          //         //   duration: const Duration(milliseconds: 300),
          //         //   curve: Curves.easeIn,
          //         // );
          //       },
          //       child: Container(
          //         alignment: Alignment.center,
          //         height: 35.w,
          //         width: 35.w,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(5.r),
          //           ),
          //           color: colors.transparent.withOpacity(0.5),
          //         ),
          //         child: Icon(Icons.keyboard_arrow_right_outlined,
          //             color: colors.white),
          //       ),
          //     ),
          //     const Spacer(),
          //   ],
          // )
        ]),
      );
    });
  }
}
