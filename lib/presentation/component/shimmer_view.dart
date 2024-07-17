import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerView extends StatelessWidget {
  final Widget child;
  final bool forText;

  const ShimmerView({super.key, required this.child, this.forText = false});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Shimmer.fromColors(
        baseColor: forText ? colors.customGreyE1 : colors.customGreyE1,
        highlightColor: colors.colorF5F5F5,
        child: child,
      );
    });
  }
}

class ShimmerContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const ShimmerContainer({
    super.key,
    this.height,
    this.width,
    this.child,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?.h,
      width: width?.w,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
      ),
      child: child,
    );
  }
}

class ShimmerWrapBox extends StatelessWidget {
  final Widget child;

  const ShimmerWrapBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
