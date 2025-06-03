import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/app_colors.dart';
import '../../../../../app/app_export.dart';

class SwipeIndicator extends StatelessWidget {
  final int current;
  final int length;
  const SwipeIndicator({
    super.key,
    required this.current,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    if (length == 1) return const SizedBox();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          height: 5.w,
          width: current == index ? 20.w : 5.w,
          margin: EdgeInsets.only(right: 4.w),
          decoration: BoxDecoration(
              color: current == index
                  ? context.color.grey
                  : context.color.grey.withValues(alpha: .5),
              borderRadius: BorderRadius.circular(100)),
        ),
      ),
    );
  }
}
