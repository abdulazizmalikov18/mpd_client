import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomPagination extends StatelessWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final VoidCallback onRetry;
  final RefreshController controller;
  final Widget? child;
  final Axis scrollDirection;
  final bool enablePullDown;
  final bool enablePullUp;
  final bool hasFloatActionButton;
  final bool primary;

  const CustomPagination(
      {super.key,
      required this.controller,
      this.onRefresh,
      this.onLoading,
      this.child,
      required this.onRetry,
      this.scrollDirection = Axis.vertical,
      this.enablePullDown = true,
      this.enablePullUp = true,
      this.hasFloatActionButton = false,
      this.primary = true});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (BuildContext context, CustomColorSet colors, FontSet fonts, IconSet icons, _) {
      return SmartRefresher(
        scrollDirection: scrollDirection,
        primary: primary,
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp,
        header: WaterDropMaterialHeader(
          color: colors.backgroundColor,
          backgroundColor: colors.primary,
        ),
        footer: CustomFooter(
          height: 56 + (hasFloatActionButton ? 88.h : 0),
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = CupertinoActivityIndicator(
                color: colors.primary,
              );
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator(
                color: colors.primary,
              );
            } else if (mode == LoadStatus.failed) {
              body = RichText(
                text: TextSpan(
                  style: fonts.caption,
                  children: <TextSpan>[
                    TextSpan(text: 'load_failed'.tr()),
                    TextSpan(
                        text: 'retry'.tr(),
                        style: fonts.caption.copyWith(color: colors.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            onRetry();
                          }),
                  ],
                ),
              );
            } else if (mode == LoadStatus.canLoading) {
              body = CupertinoActivityIndicator(
                color: colors.primary,
              );
            } else if (mode == LoadStatus.noMore) {
              body = Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Text(
                  "no_more_data".tr(),
                  style: fonts.caption,
                ),
              );
            } else {
              body = Text(
                "no_more_data".tr(),
                style: fonts.caption,
              );
            }
            return SizedBox(
              height: 56 + (hasFloatActionButton ? 88.h : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  body,
                ],
              ),
            );
          },
        ),
        controller: controller,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: child,
      );
    });
  }
}
