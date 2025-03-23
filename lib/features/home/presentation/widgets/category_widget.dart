import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../app/app_colors.dart';
import '../../../../../../../app/app_export.dart';
import '../../../../../../../src/themes/styles.dart';

class CategoryWidget extends StatelessWidget {
  final String categoryName;
  final String? categoryImagePath;
  const CategoryWidget({
    super.key,
    required this.categoryName,
    required this.categoryImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 75.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.zero,
            height: 75.h,
            width: 75.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: /* categoryImagePath != null
                  ? DecorationImage(
                      scale: 1,
                      image: NetworkImage(categoryImagePath!),
                    )
                  : const */
                  DecorationImage(
                      image: AssetImage(categoryImagePath!), scale: 2),
              color: context.color.background,
            ),
          ),
          ScreenUtil().setVerticalSpacing(10.h),
          Text(
            categoryName,
            textAlign: TextAlign.center,
            style: Styles.headline7
                .copyWith(color: context.color.black, fontSize: 12.sp),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
