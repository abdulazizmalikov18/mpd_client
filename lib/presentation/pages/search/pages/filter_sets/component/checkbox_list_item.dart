import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/utils/extensions.dart';

class CheckboxListItem extends StatelessWidget {
  const CheckboxListItem(
      {super.key,
      required this.isSelected,
      required this.title,
      required this.onTap,
      required this.fonts,
      required this.colors,
      required this.count,
      required this.icons,
      this.disabled = false});

  final bool isSelected;
  final String title;
  final String count;
  final VoidCallback onTap;
  final FontSet fonts;
  final CustomColorSet colors;
  final IconSet icons;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      onTap: disabled ? null : onTap,
      leading: SvgPicture.asset(
        isSelected ? icons.checkRed : icons.checkGrey,
        height: 25.h,
        width: 25.h,
        fit: BoxFit.contain,
      ),
      title: Text(
        title,
        style: fonts.subtitle1.copyWith(
          fontSize: 16.sp,
          decoration:
              disabled ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Text(
        count,
        style: fonts.subtitle1.copyWith(
            fontSize: 14.sp, color: colors.customBlack.withOpacity(0.5)),
      ),
    );
  }
}

//
class CheckboxColorItem extends StatelessWidget {
  const CheckboxColorItem({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTap,
    required this.fonts,
    required this.colors,
    required this.count,
    required this.icons,
    required this.colorVal,
    this.disabled = false,
  });

  final bool isSelected;
  final String title;
  final String count;
  final VoidCallback onTap;
  final FontSet fonts;
  final CustomColorSet colors;
  final IconSet icons;
  final String colorVal;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      onTap: disabled ? null : onTap,
      leading: Container(
        height: 24.h,
        width: 24.h,
        padding: EdgeInsets.all(4.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            color: colorValue(colorVal),
            border: Border.all(color: colors.customGreyC3)),
        child: isSelected
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  color: colors.customGreyC3,
                ),
                child: SvgPicture.asset(icons.checkGrey),
              )
            : null,
      ),
      title: Text(
        title,
        style: fonts.subtitle1.copyWith(
          fontSize: 16.sp,
          color: isSelected ? colors.primary : colors.text,
          decoration:
              disabled ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Text(
        count,
        style: fonts.subtitle1.copyWith(
            fontSize: 14.sp, color: colors.customBlack.withOpacity(0.5)),
      ),
    );
  }
}
