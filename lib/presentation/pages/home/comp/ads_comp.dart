import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class AdsComp extends StatefulWidget {
  const AdsComp({super.key});

  @override
  State<AdsComp> createState() => _AdsCompState();
}

class _AdsCompState extends State<AdsComp> {
  late PageController _pageController;
  late int _pageIndex;

  @override
  void initState() {
    _pageController = PageController();
    _pageIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return ColoredBox(
        color: colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: SizedBox(
            height: 120.h,
            child: Stack(
              children: [
                /// page view
                PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemCount: 3,
                  controller: _pageController,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Container(
                        width: 1.sw - 32.w,
                        height: 120.h,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.newsPNG),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                ///dots
                Positioned(
                  bottom: 8.h,
                  left: 16.w,
                  right: 16.w,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: DotIndicator(
                              isActive: index == _pageIndex,
                              colors: colors,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

///
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    required this.colors,
    super.key,
  });

  final bool isActive;
  final CustomColorSet colors;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6.h,
      width: isActive ? 13.w : 6.w,
      decoration: BoxDecoration(
        color: isActive ? colors.white : colors.grey,
        border: isActive ? null : Border.all(color: colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(12.r),
        ),
      ),
    );
  }
}
