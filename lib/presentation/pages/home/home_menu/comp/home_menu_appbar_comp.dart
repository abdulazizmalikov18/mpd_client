import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/application/main/main_bloc.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/styles/theme.dart';

class HomeMenuAppBarComp extends StatelessWidget {
  const HomeMenuAppBarComp({
    super.key,
    required this.icons,
    required this.colors,
    required this.onTap,
    required this.fonts,
  });

  final IconSet icons;
  final CustomColorSet colors;
  final VoidCallback onTap;
  final FontSet fonts;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: colors.white,
      leadingWidth: 128.w,
      pinned: true,
      elevation: 0.5,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: SvgPicture.asset(
          icons.logo,
          width: 128.w,
          height: 40.h,
        ),
      ),
      actions: [
        AnimationButtonEffect(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 32.w,
              height: 20.w,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SvgPicture.asset(icons.notificationIcon),
                  ),
                  BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      return Visibility(
                        visible: (state.undreadModel?.count ?? 0) > 0,
                        child: Positioned(
                          top: 0,
                          right: 2,
                          child: Container(
                            height: 14.w,
                            width: 14.w,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.r)),
                                color: colors.primary),
                            child: Text(
                              "${(state.undreadModel?.count ?? 0) < 0 ? 0 : state.undreadModel?.count ?? 0}",
                              textAlign: TextAlign.center,
                              style: fonts.subtitle1.copyWith(
                                  fontSize: 10.sp, color: colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        AnimationButtonEffect(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding:
                EdgeInsets.only(right: 24.0.w, top: 16.0.w, bottom: 16.0.w),
            child: SvgPicture.asset(
              icons.clear,
              width: 32.w,
              height: 16.h,
            ),
          ),
        ),
      ],
    );
  }
}

class HomeSliverAppBarComp extends StatelessWidget {
  const HomeSliverAppBarComp({
    super.key,
    required this.icons,
    required this.colors,
    required this.onTap,
    required this.onTapNotification,
    required this.fonts,
  });

  final IconSet icons;
  final CustomColorSet colors;
  final VoidCallback onTap;
  final VoidCallback onTapNotification;
  final FontSet fonts;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: colors.white,
      leadingWidth: 128.w,
      elevation: 0.5,
      floating: false,
      snap: false,
      surfaceTintColor: colors.white,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: SvgPicture.asset(
          icons.logo,
          width: 128.w,
          height: 40.h,
        ),
      ),
      actions: [
        AnimationButtonEffect(
          onTap: onTapNotification,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 32.w,
              height: 20.w,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SvgPicture.asset(icons.notificationIcon),
                  ),
                  Positioned(
                      top: 0,
                      right: 2,
                      child: Container(
                        height: 14.w,
                        width: 14.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.r)),
                            color: colors.primary),
                        child: Text(
                          "3",
                          textAlign: TextAlign.center,
                          style: fonts.subtitle1
                              .copyWith(fontSize: 10.sp, color: colors.white),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        AnimationButtonEffect(
          onTap: onTap,
          child: Padding(
            padding:
                EdgeInsets.only(right: 16.0.w, top: 16.0.w, bottom: 16.0.w),
            child: SvgPicture.asset(
              icons.menu,
              width: 32.w,
              height: 16.h,
            ),
          ),
        ),
      ],
    );
  }
}
