import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_export.dart';
import '../../../../src/themes/styles.dart';

class DrProfileListile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconName;
  const DrProfileListile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -4),
      leading: Container(
        alignment: Alignment.center,
        height: 48.h,
        width: 48.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.color.mainBlue.withValues(alpha: 0.1)),
        child: Image.asset(
          iconName,
          height: 24.h,
          width: 24.h,
        ),
      ),
      title: Text(
        title,
        style: Styles.boldTopHint.copyWith(fontSize: 16.sp),
      ),
      subtitle: Text(
        subtitle,
        style: Styles.descSubtitle
            .copyWith(fontSize: 14.sp, color: context.color.grey),
      ),
    );
  }
}
