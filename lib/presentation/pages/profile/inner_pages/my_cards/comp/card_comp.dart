import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/presentation/component/custom_dialog_component.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CardComp extends StatefulWidget {
  const CardComp({
    super.key,
    required this.onTap,
    this.hasTrailingIcon = true,
  });

  final Function() onTap;
  final bool hasTrailingIcon;

  @override
  State<CardComp> createState() => _CardCompState();
}

class _CardCompState extends State<CardComp> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        height: 90.h,
        decoration: ShapeDecoration(
          color: colors.text,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        child: Center(
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
            onTap: widget.onTap,
            leading: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
                child: Image.asset(icons.uzcard, height: 50.w, width: 50.w)),
            title: Text(
              '8600 0602 **** 8442',
              style: fonts.headline1.copyWith(
                color: colors.white,
              ),
            ),
            subtitle: Text(
              '05/24',
              style: fonts.headline1.copyWith(
                color: colors.white,
              ),
            ),
            trailing: widget.hasTrailingIcon
                ? IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => CustomDialogComponent(
                              title: "do_delete_all_card_data".tr(),
                              leftButtonTitle: "cancel".tr(),
                              rightButtonTitle: "delete".tr(),
                              onRightButtonPressed: () {}));
                    },
                    icon: Container(
                      height: 30.h,
                      width: 30.w,
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: SvgPicture.asset(icons.delete),
                    ),
                  )
                : null,
          ),
        ),
      );
    });
  }
}
