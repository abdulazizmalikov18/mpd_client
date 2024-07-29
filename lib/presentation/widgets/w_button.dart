import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class WButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Color? color;
  final Color textColor;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final GestureTapCallback onTap;
  final BoxBorder? border;
  final double borderRadius;
  final Widget? child;
  final Color disabledColor;
  final bool isDisabled;
  final bool isLoading;
  final double? scaleValue;
  final List<BoxShadow>? shadow;
  final Gradient? gradient;
  final bool isPhone;

  const WButton({
    required this.onTap,
    this.child,
    this.text = '',
    this.color,
    this.textColor = white,
    this.borderRadius = 12,
    this.disabledColor = grey,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.textStyle,
    this.border,
    this.scaleValue,
    this.shadow,
    this.gradient,
    super.key,
    this.isPhone = true,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        if (!(isLoading || isDisabled)) {
          onTap();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height ?? (isPhone ? 56 : 70),
        margin: margin,
        padding: padding ?? EdgeInsets.zero,
        alignment: Alignment.center,
        foregroundDecoration: color == null
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(isPhone ? borderRadius : 16),
                border: Border.all(
                  color: white.withOpacity(0.1),
                  width: 2,
                  strokeAlign: -2,
                ),
              )
            : null,
        decoration: BoxDecoration(
          color: isDisabled ? gray : color ?? primary,
          borderRadius: BorderRadius.circular(isPhone ? borderRadius : 16),
          border: isDisabled
              ? border ?? Border.all(color: white.withOpacity(0.3))
              : border ??
                  Border.all(
                    color: white.withOpacity(0.3),
                  ),
          gradient: isDisabled ? null : color == null ? gradient ?? wgradient : null,
          // boxShadow: shadow,
          // boxShadow: shadow ??
          //     [
          //       if (!isDisabled)
          //         BoxShadow(
          //           color: primary.withOpacity(0.5),
          //           blurRadius: 8,
          //           spreadRadius: 3,
          //         )
          //     ],
        ),
        child: isLoading
            ? const Center(
                child: CupertinoActivityIndicator(color: white),
              )
            : AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color:  white,
                    ),
                child: child ??
                    Text(
                      text,
                      style: isDisabled ? textStyle?.copyWith(color: white) : textStyle,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
              ),
      ),
    );
  }
}
