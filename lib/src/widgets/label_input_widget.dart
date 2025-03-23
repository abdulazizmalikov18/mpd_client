import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/src/decorations/input_border.dart';
import 'package:mpd_client/src/widgets/input_widget.dart';
import 'package:mpd_client/src/themes/styles.dart';

class LabelInputWidget extends StatelessWidget {
  final String? topHint;
  final String? inputHint;
  final TextEditingController? controller;
  final String? require;
  final Widget? suffixIcon;
  final bool obsecure;
  final Color? background;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final bool readOnly;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputformater;
  final int? maxLength;
  final ValueChanged? onChanged;
  final AutovalidateMode? autovalidateMode;
  final String? errorText;
  const LabelInputWidget({
    super.key,
    required this.topHint,
    required this.inputHint,
    required this.controller,
    this.autovalidateMode,
    this.errorText,
    this.onChanged,
    this.obsecure = false,
    this.inputformater,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.textInputAction,
    this.validator,
    this.require,
    this.suffixIcon,
    this.textInputType,
    this.background,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: topHint!,
                style: Styles.boldTopHint.copyWith(color: context.color.black),
              ),
              TextSpan(
                text: require,
                style: TextStyle(
                  color: context.color.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontFamily: Styles.gilroyMedium,
                ),
              ),
            ]),
          ),
        ),
        ScreenUtil().setVerticalSpacing(8.h),
        InputWidget(
          errorText: errorText,
          autovalidateMode: autovalidateMode,
          inputformater: inputformater,
          maxLength: maxLength,
          textInputType: textInputType,
          readOnly: readOnly,
          background: background ?? context.color.white,
          suffixIcon: suffixIcon,
          controller: controller!,
          hintText: inputHint!,
          validator: validator,
          obscure: obsecure,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          style: Styles.headline7.copyWith(color: context.color.black),
        )
      ],
    );
  }
}

class LabelInputBioWidget extends StatelessWidget {
  final String? topHint;
  final String? inputHint;
  final TextEditingController? controller;
  final String? require;
  final Widget? suffixIcon;
  final bool obsecure;
  final Color? background;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final bool readOnly;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputformater;
  final int? maxLength;
  final ValueChanged? onChanged;
  final AutovalidateMode? autovalidateMode;
  final String? errorText;

  const LabelInputBioWidget({
    super.key,
    required this.topHint,
    required this.inputHint,
    required this.controller,
    this.autovalidateMode,
    this.errorText,
    this.onChanged,
    this.obsecure = false,
    this.inputformater,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.textInputAction,
    this.validator,
    this.require,
    this.suffixIcon,
    this.textInputType,
    this.background,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: topHint!,
                style: Styles.boldTopHint.copyWith(color: context.color.black),
              ),
              TextSpan(
                text: require,
                style: TextStyle(
                  color: context.color.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontFamily: Styles.gilroyMedium,
                ),
              ),
            ]),
          ),
        ),
        ScreenUtil().setVerticalSpacing(8.h),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: (background ?? context.color.white)),
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: TextFormField(
            autovalidateMode: autovalidateMode,
            keyboardType: textInputType,
            readOnly: readOnly,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            onChanged: onChanged,
            validator: validator,
            controller: controller,
            style: Styles.headline7.copyWith(color: context.color.black),
            maxLength: maxLength,
            maxLines: 6,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w, vertical: 8.h
              ),
              enabledBorder: Decorations.enabledBorder(context),
              focusedBorder: Decorations.focusedBorder(context),
              border: Decorations.enabledBorder(context),
              errorBorder: Decorations.errorBorder(context),
              errorText: errorText,
              hintText: inputHint,
              hintStyle: Styles.descSubtitle.copyWith(color: context.color.grey),
            ),
          ),
        ),
      ],
    );
  }
}
