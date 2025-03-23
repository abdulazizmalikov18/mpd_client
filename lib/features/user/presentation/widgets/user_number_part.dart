import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../app/app_colors.dart';
import '../../../../../../app/app_export.dart';

class UserNumberPart extends StatelessWidget {
  const UserNumberPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return Text('+${state.userInfo!.phone}', style: Styles.descSubtitle.copyWith(color: context.color.black));
        } else if (state.userInfo != null) {
          return Text('+${state.userInfo!.phone}',
              style: Styles.descSubtitle.copyWith(color: context.color.black));
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Shimmer.fromColors(
              direction: ShimmerDirection.ltr,
              baseColor: Colors.white38,
              highlightColor: Colors.grey[300]!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.h),
                child: Container(
                  width: 150,
                  height: 25,
                  color: Colors.black,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
