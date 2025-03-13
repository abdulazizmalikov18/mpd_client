import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class AnimatedFollowIcon extends StatefulWidget {
  const AnimatedFollowIcon({super.key});

  @override
  State<AnimatedFollowIcon> createState() => _AnimatedFollowIconState();
}

class _AnimatedFollowIconState extends State<AnimatedFollowIcon> with TickerProviderStateMixin {
  bool? onTapped = false;

  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200), value: 1.0, upperBound: 1.25, lowerBound: 1.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (onTapped == false) {
            _animationController.forward().then((value) => _animationController.reverse());
          }
          onTapped = !onTapped!;
        });
      },
      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
      child: ScaleTransition(
        scale: _animationController,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: !onTapped!
              ? SvgPicture.asset(
                  AppIcons.userAdd,
                  key: const ValueKey('1'),
                  height: 20.h,
                  width: 20.w,
                  colorFilter:  const ColorFilter.mode(grey, BlendMode.srcIn),
                )
              : SvgPicture.asset(
                  AppIcons.userTick,
                  height: 20.h,
                  width: 20.w,
                  colorFilter:  const ColorFilter.mode(mainBlue, BlendMode.srcIn),
                  key: const ValueKey('2'),
                ),
        ),
      ),
    );
  }
}
