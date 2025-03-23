
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_export.dart';
import '../../../../src/themes/styles.dart';

class BuildLabel extends StatelessWidget {
  final String label;
  const BuildLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            label,
            style: Styles.boldTopHint
                .copyWith(fontSize: 18.sp, color: context.color.black),
          ),
        ),
      ],
    );
  }
}
