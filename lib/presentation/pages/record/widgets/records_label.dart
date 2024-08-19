import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';


class RecordsLabelPart extends StatelessWidget {
  final bool isNew;
  final String dateTime;

  const RecordsLabelPart({
    this.isNew = false,
    required this.dateTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 6.h, top: 12.h),
      child: Row(
        children: [
          if (isNew)
            Container(
              height: 8,
              width: 8,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: gradientRedOpacity),
            ),
          const SizedBox(height: 8),
          Text(
            dateTime,
            style: Styles.boldTopHint.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
