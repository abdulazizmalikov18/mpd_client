import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/my_cards/comp/card_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class TopupBottomsheetComp extends StatelessWidget {
  const TopupBottomsheetComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        decoration: ShapeDecoration(
          color: colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 0.w,
              leading: Text(
                'payment_methods'.tr(),
                textAlign: TextAlign.center,
                style: fonts.subtitle2.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              trailing: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:
                    icons.clear.svg(height: 30.sp, color: colors.customGreyC3),
              ),
            ),
            16.verticalSpace,
            CardComp(onTap: () {}, hasTrailingIcon: false),
            16.verticalSpace,
            Wrap(
              spacing: 10.w,
              runSpacing: 10.w,
              children: [
                AnimationButtonEffect(
                  onTap: () {
                    Navigator.pushReplacement(
                        context, AppRoutes.getCardAdding());
                  },
                  child: Container(
                    width: 165.w,
                    height: 100.h,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(width: 1.w, color: colors.customGreyC3),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(icons.uzcard,
                                      height: 40.w, width: 30.w),
                                  2.horizontalSpace,
                                  Image.asset(icons.humo,
                                      height: 40.w, width: 70.w),
                                ]),
                            2.verticalSpace,
                            Text(
                              'Uzcard/Humo',
                              style: fonts.subtitle1,
                            ),
                          ]),
                    ),
                  ),
                ),
                _buildCard(
                    onTap: () {},
                    iconsName: icons.payme,
                    colors: colors,
                    fonts: fonts),
                _buildCard(
                    onTap: () {},
                    iconsName: icons.uzum,
                    colors: colors,
                    fonts: fonts),
                _buildCard(
                    onTap: () {},
                    iconsName: icons.click,
                    colors: colors,
                    fonts: fonts),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCard({
    required VoidCallback onTap,
    required String iconsName,
    required CustomColorSet colors,
    required FontSet fonts,
  }) {
    return AnimationButtonEffect(
      onTap: onTap,
      child: Container(
        width: 165.w,
        height: 100.h,
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.w, color: colors.customGreyC3),
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        child: Image.asset(iconsName),
      ),
    );
  }
}

class TopupBottomsheetSafetyComp extends StatelessWidget {
  const TopupBottomsheetSafetyComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        height: 300.h,
        decoration: ShapeDecoration(
          color: colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 0.w,
              leading: Text(
                'safety'.tr(),
                textAlign: TextAlign.center,
                style: fonts.subtitle2.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              trailing: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:
                    icons.clear.svg(height: 30.sp, color: colors.customGreyC3),
              ),
            ),
            24.verticalSpace,
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'orient_does_not_store_information'.tr(),
                    style: fonts.headline1,
                  ),
                  TextSpan(
                    text: 'Payme.',
                    style: fonts.headline2,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
