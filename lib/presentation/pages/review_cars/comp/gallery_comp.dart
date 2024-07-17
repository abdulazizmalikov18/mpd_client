import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/cached_image_component.dart';
import 'package:orient_motors/presentation/pages/home/comp/ads_comp.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class GalleryComp extends StatefulWidget {
  const GalleryComp(
      {super.key,
      this.bottomGap = 24.0,
      this.onTap,
      required this.images,
      this.height = 250,
      this.borderRadius = 0,
      this.dotBottomPadding});

  final double bottomGap;
  final VoidCallback? onTap;
  final List<ImagesModel>? images;
  final double height;
  final double borderRadius;
  final double? dotBottomPadding;

  @override
  State<GalleryComp> createState() => _GalleryCompState();
}

class _GalleryCompState extends State<GalleryComp> {
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
        child: Column(
          children: [
            InkWell(
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: colors.white,
                ),
                height: widget.height.h,
                child: Stack(
                  children: [
                    PageView.builder(
                      onPageChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                      itemCount: widget.images?.length ?? 0,
                      controller: _pageController,
                      itemBuilder: (context, index) => CachedImageComponent(
                        fit: BoxFit.cover,
                        height: 200.h,
                        width: double.infinity,
                        imageUrl: widget.images?[index].url ?? "",
                        borderRadius: widget.borderRadius,
                      ),
                    ),

                    ///dots
                    Positioned(
                      bottom: 8.h,
                      left: 16.w,
                      right: 16.w,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: widget.dotBottomPadding ?? 16.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                              widget.images?.length ?? 0,
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
            widget.bottomGap.verticalSpace
          ],
        ),
      );
    });
  }
}

///
class Gallery2Comp extends StatefulWidget {
  final List<String> images;
  const Gallery2Comp(
      {super.key, this.bottomGap = 24.0, this.onTap, required this.images});

  final double bottomGap;
  final VoidCallback? onTap;

  @override
  State<Gallery2Comp> createState() => _Gallery2CompState();
}

class _Gallery2CompState extends State<Gallery2Comp> {
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
        child: Column(
          children: [
            InkWell(
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: colors.white,
                ),
                height: 250.h,
                child: Stack(
                  children: [
                    PageView.builder(
                      onPageChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.images.length,
                      controller: _pageController,
                      itemBuilder: (context, index) => CachedNetworkImage(
                          imageUrl: widget.images[index], fit: BoxFit.contain),
                    ),
                    Visibility(
                      visible: widget.images.length != 1,
                      child: Positioned(
                        right: 20.w,
                        top: 110.h,
                        bottom: 110.h,
                        child: AnimationButtonEffect(
                          onTap: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                              color: colors.transparent.withOpacity(0.5),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: icons.forward
                                .svg(color: colors.white, height: 12),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.images.length != 1,
                      child: Positioned(
                        left: 20.w,
                        top: 110.h,
                        bottom: 110.h,
                        child: AnimationButtonEffect(
                          onTap: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                              color: colors.transparent.withOpacity(0.5),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: icons.back.svg(color: colors.white),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.images.length != 1,
                      child: Positioned(
                        bottom: 14.h,
                        right: 20.w,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                            color: colors.transparent.withOpacity(0.5),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 8.w),
                          child: Text(
                            "${_pageIndex + 1}/${widget.images.length}",
                            textAlign: TextAlign.center,
                            style:
                                fonts.subtitle1.copyWith(color: colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            widget.bottomGap.verticalSpace
          ],
        ),
      );
    });
  }
}

class GalleryGridComp extends StatelessWidget {
  final List<String> images;
  const GalleryGridComp({super.key, this.onTap, required this.images});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return ColoredBox(
        color: colors.white,
        child: Column(
          children: [
            InkWell(
              onTap: onTap,
              child: ColoredBox(
                color: colors.white,
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.52,
                  ),
                  itemCount: images.length,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(images[index], fit: BoxFit.cover),
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            ),
            16.verticalSpace,
          ],
        ),
      );
    });
  }
}
