import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CustomTabbarComponent extends StatefulWidget {
  const CustomTabbarComponent({
    super.key,
    required this.list,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<String> list;
  final int selectedIndex;
  final VoidCallback onTap;

  @override
  State<CustomTabbarComponent> createState() => _CustomTabbarComponentState();
}

class _CustomTabbarComponentState extends State<CustomTabbarComponent> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return SizedBox(
        height: 40.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.list.length,
          separatorBuilder: (context, index) => VerticalDivider(
            color: colors.customGreyC3,
            thickness: 1,
            indent: 8,
            endIndent: 8,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: widget.onTap,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Center(
                      child: Text(
                        widget.list[index],
                        style: Style.medium14(
                          color: widget.selectedIndex == index
                              ? colors.primary
                              : colors.text.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // Adjust this value based on the number of tabs
                      height: 1.h,
                      color: widget.selectedIndex == index
                          ? colors.primary
                          : colors.customGreyC3,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}

/// black tab bar
class CustomTabbarBlack extends StatefulWidget {
  const CustomTabbarBlack({
    super.key,
    required this.leftTab,
    required this.rightTab,
    required this.middleTab,
    required this.index,
  });

  final String leftTab;
  final String rightTab;
  final String middleTab;
  final int index;

  @override
  State<CustomTabbarBlack> createState() => _CustomTabbarBlackState();
}

class _CustomTabbarBlackState extends State<CustomTabbarBlack> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        height: 50.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: const EdgeInsets.all(5),
        decoration: ShapeDecoration(
          color: colors.backgroundScaffold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        child: TabBar(
          indicatorPadding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          dividerColor: colors.transparent,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          padding: EdgeInsets.zero,
          indicatorColor: colors.transparent,
          tabs: [
            Tab(
              child: Container(
                width: double.infinity,
                decoration: _selectedIndex == 0
                    ? ShapeDecoration(
                        color: colors.text,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      )
                    : null,
                child: Center(
                  child: Text(
                    widget.leftTab,
                    textAlign: TextAlign.center,
                    style: fonts.subtitle1.copyWith(
                        fontSize: 12.sp,
                        color:
                            _selectedIndex == 0 ? colors.white : colors.text),
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                width: double.infinity,
                decoration: _selectedIndex == 1
                    ? ShapeDecoration(
                        color: colors.text,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      )
                    : null,
                child: Center(
                  child: Text(
                    widget.middleTab,
                    textAlign: TextAlign.center,
                    style: fonts.subtitle1.copyWith(
                        fontSize: 12.sp,
                        color:
                            _selectedIndex == 1 ? colors.white : colors.text),
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                decoration: _selectedIndex == 2
                    ? ShapeDecoration(
                        color: colors.text,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      )
                    : null,
                child: Center(
                  child: Text(
                    widget.rightTab,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: fonts.subtitle1.copyWith(
                        fontSize: 12.sp,
                        color:
                            _selectedIndex == 2 ? colors.white : colors.text),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
