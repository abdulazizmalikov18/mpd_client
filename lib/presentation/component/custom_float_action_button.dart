import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CustomFloatActionButton extends StatelessWidget {
  final Function function;
  final Widget icon;
  const CustomFloatActionButton({super.key, required this.function, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return AnimationButtonEffect(
          onTap: () {
            function();
          },
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
                color: colors.white.withOpacity(0.8), borderRadius: BorderRadius.circular(16.r), boxShadow: const [Style.blueIconShadow]),
            child: icon,
          ));
    });
  }
}
