import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:orient_motors/domain/models/home/home.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class HomeServiceGridComp extends StatelessWidget {
  final bool isBordered;
  final HomeItemEntity param;
  const HomeServiceGridComp({super.key, this.isBordered = false, required this.param});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: () {
            if (param.route != null) {}
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: GradientBoxBorder(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF72000B),
                    Color(0xFFD80116),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                width: 1.6.w,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isBordered
                      ? Padding(
                          padding: EdgeInsets.only(left: 4.w, top: 4.h, bottom: 4.h),
                          child: param.icon.svg(height: 20.h, width: 20.h),
                        )
                      : DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: colors.customRed,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.h),
                            child: param.icon.svg(
                              color: colors.white,
                              height: 20.h,
                              width: 20.h,
                            ),
                          ),
                        ),
                  8.h.verticalSpace,
                  AutoSizeText(
                    param.title,
                    maxLines: 1,
                    style: Style.semiBold16(size: 16.sp),
                  ),
                  2.h.verticalSpace,
                  AutoSizeText(
                    param.subtitle,
                    maxLines: 2,
                    style: Style.regular12(color: colors.grey1, size: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
