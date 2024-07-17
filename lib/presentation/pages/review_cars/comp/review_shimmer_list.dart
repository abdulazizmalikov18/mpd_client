import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ReviewShimmerList extends StatelessWidget {
  const ReviewShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (BuildContext context, CustomColorSet colors,
        FontSet fonts, IconSet icons, GlobalController controller) {
      return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            // height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: colors.white,
              border: Border.all(color: colors.borderColor, width: 1),
              boxShadow: const [Style.bottomShadow],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerView(child: ShimmerContainer(height: 18, width: 120)),
                SizedBox(height: 8),
                ShimmerView(child: ShimmerContainer(height: 14, width: 128)),
                SizedBox(height: 8),
                ShimmerView(child: ShimmerContainer(height: 14, width: 134)),
                SizedBox(height: 8),
                ShimmerView(child: ShimmerContainer(height: 16, width: 110)),
                SizedBox(height: 8),
                Center(
                  child: ShimmerView(
                    child: ShimmerContainer(width: 200, height: 110),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
