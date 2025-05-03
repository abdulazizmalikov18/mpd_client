import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/app_colors.dart';

class PinnedSheet extends StatelessWidget {
  final Widget widget;
  final double verticalPadding;

  const PinnedSheet({
    super.key,
    required this.widget,
    this.verticalPadding = 14,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding.h,
        horizontal: 16.w,
      ).copyWith(
        bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 12 : 32,
      ),
      decoration: BoxDecoration(
        color: context.color.white,
        boxShadow: [
          BoxShadow(
            color: context.color.shadow,
            offset: const Offset(0, -4),
            blurRadius: 12,
          )
        ],
      ),
      duration: const Duration(milliseconds: 300),
      child: widget,
    );
  }
}
