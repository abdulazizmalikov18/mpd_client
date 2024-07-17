import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/pages/home/comp/search_comp.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (contextT, colors, fonts, icons, controller) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24.r),
            ),
            image: DecorationImage(
              image: svg.Svg(icons.netLarge),
              fit: BoxFit.cover,
            ),
            // color: colors.dark,
            gradient: const LinearGradient(
              colors: [
                Color(0xFF0F0F11),
                Color(0xFF313131),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            children: [
              SafeArea(
                bottom: false,
                child: 2.verticalSpace,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 16.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          icons.logoIc.svg(width: 182.w, height: 24.h),
                          const Spacer(),
                          AnimationButtonEffect(
                            onTap: () {
                              Scaffold.of(context).openEndDrawer();
                            },
                            child: CircleAvatar(
                              backgroundColor: colors.white,
                              radius: 22.r,
                              child: SvgPicture.asset(
                                icons.menu,
                                height: 18.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      16.h.verticalSpace,
                      const SearchComp(),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
