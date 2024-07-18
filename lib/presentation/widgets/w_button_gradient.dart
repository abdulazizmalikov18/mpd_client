import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_scale_animation.dart';

class WButtonGradient extends StatelessWidget {
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
  final double borderHeight;

  const WButtonGradient({
    required this.onTap,
    this.child,
    this.text = '',
    this.color,
    this.textColor = white,
    this.borderRadius = 8,
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
    this.borderHeight = 1,
  });

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      scaleValue: scaleValue ?? 0.98,
      onTap: () {
        if (!(isLoading || isDisabled)) {
          onTap();
        }
      },
      isDisabled: isDisabled,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height ?? (isPhone ? 48 : 70),
        margin: margin,
        padding: padding ?? EdgeInsets.zero,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDisabled ? contGrey : color ?? blue,
          borderRadius: BorderRadius.circular(isPhone ? borderRadius : 16),
          border: isDisabled ? Border.all(color: greyText, width: 1) : border,
          gradient: isDisabled
              ? null
              : color != null
              ? null
              : (gradient ?? wgradient),
          boxShadow: shadow,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.all(borderHeight),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(
            child: isLoading
                ? Lottie.asset(
              'assets/anim/loading_light.json',
              height: 32,
              width: 32,
            )
                : AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                height: 1.36,
                color: isDisabled ? greyText : textColor,
                fontSize: isPhone ? 16 : 20,
                fontWeight: isPhone ? FontWeight.w400 : FontWeight.w500,
              ),
              child: child ??
                  Text(
                    text,
                    style: textStyle,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
