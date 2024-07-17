import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class LastViewedCarsComp extends StatefulWidget {
  const LastViewedCarsComp({super.key});

  @override
  State<LastViewedCarsComp> createState() => _LastViewedCarsCompState();
}

class _LastViewedCarsCompState extends State<LastViewedCarsComp> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ColoredBox(
          color: colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Text(
                  'last_viewed_cars'.tr(),
                  textAlign: TextAlign.left,
                  style: Style.medium20(size: 18.sp),
                ),
              ),
              8.verticalSpace,
              SizedBox(
                  height: 192.h,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationButtonEffect(
                        onTap: () {},
                        child: Container(
                          width: 164.w,
                          // padding: EdgeInsets.all(12.sp),
                          margin: EdgeInsets.only(
                            left: index == 0 ? 16.0.w : 8.w,
                            right: index == 4 ? 16.0.w : 0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 162.w,
                                height: 94.h,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(icons.bently),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),
                              Text(
                                'Bentley Continental Flying ',
                                style:
                                    fonts.subtitle1.copyWith(fontSize: 12.sp),
                              ),
                              AutoSizeText(
                                '2 116 167 600 сум',
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    fonts.headline2.copyWith(fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
              24.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
