import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_text_field.dart';

class WVerificationTextFieldWithTitle extends StatelessWidget {
  final String title;
  final String hintText;
  final bool isRequired;
  final TextEditingController? controller;
  final bool isReadOnly;
  final void Function()? onTap;
  final void Function(String message)? onChange;
  final Widget? rightIcon;

  const WVerificationTextFieldWithTitle({
    super.key,
    required this.title,
    required this.hintText,
    this.isRequired = false,
    this.controller,
    this.isReadOnly = false,
    this.onTap,
    this.rightIcon,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTheme.bodySmall.copyWith(color: white),
            children: [
              TextSpan(
                text: title,
                style: AppTheme.bodySmall.copyWith(color: white),
              ),
              if (isRequired)
                const TextSpan(
                  text: '*',
                  style: TextStyle(color: red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        WTextField(
          textCapitalization: TextCapitalization.words,
          readOnly: isReadOnly,
          onTap: onTap,
          controller: controller,
          onChanged: onChange ?? (e) {},
          style: AppTheme.labelSmall.copyWith(
            color: white,
          ),
          borderColor: borderColor,
          hintText: hintText,
          hintStyle: AppTheme.labelSmall.copyWith(
            color: gray,
          ),
          fillColor: white.withOpacity(0.2),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: rightIcon ?? const SizedBox(),
          ),
        ),
      ],
    );
  }
}
