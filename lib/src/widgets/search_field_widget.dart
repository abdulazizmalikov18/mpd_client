// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_icons.dart';

import '../../app/app_colors.dart';
import '../decorations/input_border.dart';
import '../themes/styles.dart';

class SearchFieldWidget extends StatelessWidget {
  final bool autoFocus;
  final String searchHint;
  final VoidCallback? onTap;
  final bool hasFocus;
  final bool readOnly;
  final Function(String)? onSubmitted;
  final TextEditingController controller;

  final Function(String)? onChanged;
  const SearchFieldWidget({
    super.key,
    required this.searchHint,
    this.onTap,
    this.hasFocus = false,
    this.readOnly = false,
    this.onChanged,
    required this.controller,
    this.onSubmitted,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: context.color.background,
      ),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        onSubmitted: onSubmitted,
        textAlignVertical: TextAlignVertical.center,
        autofocus: autoFocus,
        style: Styles.headline7.copyWith(
          color: context.color.mainBlue,
          fontSize: 16.sp,
        ),
        decoration: InputDecoration(
          isDense: true,
          prefixIconConstraints: const BoxConstraints(),
          isCollapsed: true,
          prefixIcon: Container(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              AppIcons.search,
              height: 24.h,
              width: 24.h,
              color: hasFocus ? context.color.mainBlue : context.color.grey,
            ),
          ),
          suffixIcon: controller.text.isEmpty
              ? null
              : GestureDetector(
                  onTap: () {
                    controller.clear();
                    onChanged!(controller.text);
                  },
                  child: const Icon(Icons.close_rounded, size: 24),
                ),
          enabledBorder: InputBorder.none,
          focusedBorder: Decorations.focusedBorder(context),
          alignLabelWithHint: false,
          hintText: searchHint,
          hintStyle: Styles.cardReview.copyWith(
            color: context.color.grey,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
