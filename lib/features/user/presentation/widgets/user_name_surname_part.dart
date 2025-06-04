import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../app/app_export.dart';

class UserNameSurnamePart extends StatelessWidget {
  const UserNameSurnamePart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              Text(
                '${state.userInfo!.name} ${state.userInfo!.lastname}',
                style: Styles.boldHeadline6.copyWith(fontSize: 24.sp),
                textAlign: TextAlign.center,
              ),
              if (state.userInfo?.status == 2) AppIcons.verify.svg()
            ],
          );
        } else if (state.userInfo != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              Text(
                '${state.userInfo!.name} ${state.userInfo!.lastname}',
                style: Styles.boldHeadline6.copyWith(fontSize: 24.sp),
                textAlign: TextAlign.center,
              ),
              if (state.userInfo?.status == 2) AppIcons.verify.svg()
            ],
          );
        } else {
          return Shimmer.fromColors(
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
          );
        }
      },
    );
  }
}
