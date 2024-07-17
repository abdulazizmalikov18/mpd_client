import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class BenefitsComp extends StatelessWidget {
  const BenefitsComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: colors.white),
        child: Column(
          children: [
            8.verticalSpace,
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '3 преимущества гарантии\n',
                    style: fonts.headline1.copyWith(fontSize: 18.sp),
                  ),
                  TextSpan(
                    text: 'Orient Motors',
                    style: fonts.subtitle2
                        .copyWith(fontSize: 18.sp, color: colors.primary),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.0,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: ShapeDecoration(
                    color: colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.w, color: colors.customGreyC3),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
            ),
            24.verticalSpace,
          ],
        ),
      );
    });
  }
}
