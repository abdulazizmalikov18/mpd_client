import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class MyPaymentRadioTile<T> extends StatelessWidget {
  final T value;
  final String imagePath;
  final ValueChanged onChanged;
  final T groupValue;
  final String? text;
  final String? extraText;

  const MyPaymentRadioTile(
      {super.key,
      this.text = '',
      this.extraText,
      required this.value,
      required this.onChanged,
      required this.groupValue,
      required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: white,
        boxShadow: [BoxShadow(color: cardShadow, blurRadius: 20.r)],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        onPressed: () => onChanged(value),
        child: Row(
          children: [
            _buildRadio(context),
            ScreenUtil().setHorizontalSpacing(16.w),
            _buildImage(),
            ScreenUtil().setHorizontalSpacing(12.w),
            _buildText(context),
            if (extraText != null) Text(extraText!, style: Styles.headline5.copyWith(color: black))
          ],
        ),
      ),
    );
  }

  Widget _buildRadio(BuildContext context) {
    final bool isSelected = value == groupValue;
    return Container(
        alignment: Alignment.center,
        height: 22,
        width: 22,
        decoration: ShapeDecoration(
            shape: CircleBorder(side: BorderSide(color: isSelected ? mainBlue : grey, width: 1.5))),
        child: CircleAvatar(
          backgroundColor: isSelected ? mainBlue : white,
          radius: 7,
        ));
  }

  Widget _buildImage() {
    return Image.asset(
      imagePath,
      height: 24.h,
      fit: BoxFit.fill,
    );
  }

  Widget _buildText(BuildContext context) {
    final isSelected = value == groupValue;
    return Text(
      text!,
      style: Styles.descSubtitle.copyWith(fontSize: 18.sp, color: isSelected ? mainBlue : black),
    );
  }
}
