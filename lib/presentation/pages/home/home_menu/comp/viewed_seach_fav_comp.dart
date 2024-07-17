import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ViewedSearchedFavComp extends StatelessWidget {
  const ViewedSearchedFavComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: ShapeDecoration(
          color: colors.colorF5F5F5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildButton(
                  onTap: () {},
                  text: "viewed".tr(),
                  icon: icons.eye.svg(color: colors.customGreyC3, height: 20),
                  colors: colors,
                  fonts: fonts),
              8.horizontalSpace,
              _buildButton(
                  onTap: () {
                    Navigator.push(context, AppRoutes.getFavorites(index: 1));
                  },
                  text: "recent_search".tr(),
                  icon:
                      icons.search.svg(color: colors.customGreyC3, height: 20),
                  colors: colors,
                  fonts: fonts),
              8.horizontalSpace,
              _buildButton(
                  onTap: () {
                    Navigator.push(context, AppRoutes.getFavorites(index: 0));
                  },
                  text: "favorites".tr(),
                  icon: icons.favorite
                      .svg(color: colors.customGreyC3, height: 20),
                  colors: colors,
                  fonts: fonts),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildButton({
    required VoidCallback onTap,
    required String text,
    required Widget icon,
    required CustomColorSet colors,
    required FontSet fonts,
  }) {
    return AnimationButtonEffect(
      onTap: onTap,
      child: Row(children: [
        icon,
        4.horizontalSpace,
        Text(
          text,
          style: fonts.subtitle1.copyWith(fontSize: 10.sp),
        )
      ]),
    );
  }
}
