import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/src/themes/styles.dart';

class MyCustomRadioButton<T> extends StatelessWidget {
  final T value;
  final ValueChanged onChanged;
  final T groupValue;
  final String? text;
  final bool isSelected;

  const MyCustomRadioButton({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    required this.groupValue,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.color.background,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        enableFeedback: false,
        onTap: () => onChanged(value),
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Container(
          height: 40.h,
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 22,
                width: 22,
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: isSelected
                          ? context.color.mainBlue
                          : context.color.grey,
                      width: 1.5,
                    ),
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: isSelected
                      ? context.color.mainBlue
                      : context.color.background,
                  radius: 7,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                text!,
                style: Styles.descSubtitle.copyWith(
                  color:
                      isSelected ? context.color.mainBlue : context.color.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
