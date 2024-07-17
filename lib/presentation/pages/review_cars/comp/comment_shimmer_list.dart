import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CommentShimmerList extends StatelessWidget {
  const CommentShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ListView.builder(
          itemCount: 6,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: colors.searchTextfieldColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const ShimmerView(
                            child: ShimmerContainer(
                              height: 18,
                              width: 110,
                            ),
                          ),
                          20.horizontalSpace,
                          const ShimmerView(
                            child: ShimmerContainer(
                              height: 18,
                              width: 120,
                            ),
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      const ShimmerView(
                        child: ShimmerContainer(
                          height: 18,
                          width: 260,
                        ),
                      ),
                      10.verticalSpace,
                      const ShimmerView(
                        child: ShimmerContainer(
                          height: 18,
                          width: 230,
                        ),
                      ),
                      10.verticalSpace,
                      const ShimmerView(
                        child: ShimmerContainer(
                          height: 18,
                          width: 240,
                        ),
                      ),
                      10.verticalSpace,
                      const ShimmerView(
                        child: ShimmerContainer(
                          height: 18,
                          width: 220,
                        ),
                      ),
                      10.verticalSpace,
                      const ShimmerView(
                        child: ShimmerContainer(
                          height: 18,
                          width: 80,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
