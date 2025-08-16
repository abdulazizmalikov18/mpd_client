import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/src/widgets/cached_image_widget.dart';

import '../../../../app/app_export.dart';
import '../../../../src/themes/styles.dart';

class DrProfileDocument extends StatelessWidget {
  final String title;
  final String iconName;
  final String? iconNetwork;
  final VoidCallback onPressed;
  const DrProfileDocument({
    super.key,
    required this.onPressed,
    required this.title,
    required this.iconName,
    this.iconNetwork,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      horizontalTitleGap: 10.w,
      contentPadding: EdgeInsets.zero,
      leading: iconNetwork != null
          ? CachedImageWidget(url: iconNetwork ?? "", size: 48.h)
          : Image.asset(iconName, height: 48.h, width: 48.h),
      title: Text(title, style: Styles.boldHeadline6),
    );
  }
}
