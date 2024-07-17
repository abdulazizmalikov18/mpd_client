import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class BottomSheetComp extends StatefulWidget {
  const BottomSheetComp({
    super.key,
    required this.firstItem,
    required this.onTapFirst,
    required this.secondItem,
    required this.onTapSecond,
    this.thirdItem,
    this.onTapThird,
    this.fourthItem,
    this.onTapFourth,
  });

  final String firstItem;
  final VoidCallback onTapFirst;
  final String secondItem;
  final VoidCallback onTapSecond;
  final String? thirdItem;
  final VoidCallback? onTapThird;
  final String? fourthItem;
  final VoidCallback? onTapFourth;

  @override
  State<BottomSheetComp> createState() => _BottomSheetCompState();
}

class _BottomSheetCompState extends State<BottomSheetComp> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.symmetric(vertical: 4.h),
              width: double.infinity,
              decoration: ShapeDecoration(
                color: colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimationButtonEffect(
                    onTap: widget.onTapFirst,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.0.h),
                      width: double.infinity,
                      color: colors.transparent,
                      child: Center(
                        child: Text(
                          widget.firstItem,
                          style: fonts.subtitle1.copyWith(fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 1, color: colors.customGreyC3),
                  AnimationButtonEffect(
                    onTap: widget.onTapSecond,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.0.h),
                      width: double.infinity,
                      color: colors.transparent,
                      child: Center(
                        child: Text(
                          widget.secondItem,
                          style: fonts.subtitle1.copyWith(fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ),
                  if (widget.thirdItem != null)
                    Column(children: [
                      Divider(thickness: 1, color: colors.customGreyC3),
                      AnimationButtonEffect(
                        onTap: widget.onTapThird ?? () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.0.h),
                          width: double.infinity,
                          color: colors.transparent,
                          child: Center(
                            child: Text(
                              widget.thirdItem ?? '',
                              style: fonts.subtitle1.copyWith(fontSize: 18.sp),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  if (widget.fourthItem != null)
                    Column(children: [
                      Divider(thickness: 1, color: colors.customGreyC3),
                      AnimationButtonEffect(
                        onTap: widget.onTapFourth ?? () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.0.h),
                          width: double.infinity,
                          color: colors.transparent,
                          child: Center(
                            child: Text(
                              widget.fourthItem ?? '',
                              style: fonts.subtitle1.copyWith(
                                  fontSize: 18.sp, color: colors.primary),
                            ),
                          ),
                        ),
                      ),
                    ])
                ],
              )),

          /// cancel
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AnimationButtonEffect(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 56.h,
                decoration: ShapeDecoration(
                  color: colors.text,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                ),
                child: Center(
                  child: Text(
                    'cancel'.tr(),
                    style: fonts.headline3
                        .copyWith(fontSize: 18.sp, color: colors.white),
                  ),
                ),
              ),
            ),
          ),
          (MediaQuery.of(context).padding.bottom + 8.w).verticalSpace
        ],
      );
    });
  }
}
