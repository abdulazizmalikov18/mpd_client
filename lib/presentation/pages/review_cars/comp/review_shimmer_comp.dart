import 'package:flutter/material.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ReviewShimmerComp extends StatelessWidget {
  const ReviewShimmerComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ListView(
          children: [
            const ShimmerView(
              child: ShimmerContainer(
                  width: double.maxFinite, height: 200, borderRadius: 0),
            ),
            _buildShimmerShape(
              height: 60,
              child: const ShimmerView(
                child: ShimmerContainer(
                  height: 28,
                  width: 160,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildShimmerShape(
              height: 120,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ShimmerView(
                        child: ShimmerContainer(height: 30, width: 30),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ShimmerView(child: ShimmerContainer(height: 30)),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      ShimmerView(
                        child: ShimmerContainer(height: 30, width: 30),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ShimmerView(child: ShimmerContainer(height: 30)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildShimmerShape(
              height: 400,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ShimmerView(
                      child: ShimmerContainer(
                        height: 30,
                        width: 220,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ShimmerView(
                    child: ShimmerContainer(height: 16, width: 220),
                  ),
                  SizedBox(height: 8),
                  ShimmerView(
                    child: ShimmerContainer(height: 16, width: 120),
                  ),
                  SizedBox(height: 24),
                  Expanded(child: ShimmerView(child: ShimmerContainer())),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildFaqShimmer(colors),
          ],
        );
      },
    );
  }

  Widget _buildFaqShimmer(CustomColorSet colors) {
    return ColoredBox(
      color: colors.white,
      child: const SizedBox(
        height: 200,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ShimmerView(
                  child: ShimmerContainer(width: 230, height: 22),
                ),
              ),
              SizedBox(height: 24),
              ShimmerView(
                child: ShimmerContainer(
                  width: double.maxFinite,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              SizedBox(height: 12),
              ShimmerView(
                child: ShimmerContainer(
                  width: double.maxFinite,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerShape({required double height, required Widget child}) {
    return Container(
      height: height,
      alignment: Alignment.center,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
