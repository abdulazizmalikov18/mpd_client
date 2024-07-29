// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

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
        color: hasFocus ? blueBackground : background,
      ),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        onSubmitted: onSubmitted,
        textAlignVertical: TextAlignVertical.center,
        autofocus: autoFocus,
        style: AppTheme.headlineSmall.copyWith(
          color: mainBlue,
          fontSize: 16,
          fontWeight: FontWeight.w400,
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
              color: hasFocus ? mainBlue : grey,
            ),
          ),
          suffixIcon: controller.text.isEmpty
              ? null
              : GestureDetector(
                  onTap: () {
                    controller.clear();
                    onChanged!(controller.text);
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    size: 24,
                  ),
                ),
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: grey),
          ),
          alignLabelWithHint: false,
          hintText: searchHint,
          hintStyle: AppTheme.headlineSmall.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: grey,
          ),
        ),
      ),
    );
  }
}
