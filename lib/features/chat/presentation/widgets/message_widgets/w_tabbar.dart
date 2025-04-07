import 'package:flutter/material.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/colors.dart';

class WTabBar extends StatelessWidget {
  final TabController? tabController;
  final List<Widget> tabs;
  final Function(int)? onTap;
  final bool? isScrollable;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? labelColor;

  const WTabBar({
    this.tabController,
    required this.tabs,
    super.key,
    this.onTap,
    this.padding,
    this.isScrollable,
    this.color,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: context.color.background,
      ),
      child: TabBar(
        dividerColor: Colors.transparent,
        tabAlignment: isScrollable == true ? TabAlignment.start : null,
        padding: padding ?? const EdgeInsets.all(4),
        labelPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
        isScrollable: isScrollable ?? false,
        indicator: ShapeDecoration(
          shadows: [
            BoxShadow(
              blurRadius: 1,
              offset: const Offset(0, 3),
              color: black.withValues(alpha: 0.04),
            ),
            BoxShadow(
              blurRadius: 8,
              offset: const Offset(0, 3),
              color: black.withValues(alpha: 0.12),
            ),
          ],
          shape: RoundedRectangleBorder(
            side: BorderSide(color: black.withValues(alpha: 0.04)),
            borderRadius: BorderRadius.circular(16),
          ),
          color: color ?? context.color.white,
        ),
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        onTap: onTap,
        splashBorderRadius: BorderRadius.circular(8),
        unselectedLabelStyle:
            Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
        labelStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
        unselectedLabelColor: shuttleGrey,
        labelColor: labelColor ?? dark,
        tabs: tabs,
      ),
    );
  }
}
