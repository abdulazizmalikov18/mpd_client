import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../app/app_export.dart';

class UserNameSurnamePart extends StatelessWidget {
  const UserNameSurnamePart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      // YECHIM 1: buildWhen qo'shish
      buildWhen: (previous, current) {
        // Har doim rebuild qilish
        final shouldRebuild =
            previous.userInfo?.name != current.userInfo?.name ||
            previous.userInfo?.lastname != current.userInfo?.lastname ||
            previous.userInfo?.status != current.userInfo?.status ||
            previous.status != current.status;

        if (shouldRebuild) {
          debugPrint(
            '🔄 UserNameSurnamePart rebuild: ${current.userInfo?.name}',
          );
        }

        return shouldRebuild;
      },
      builder: (context, state) {
        // YECHIM 2: Shartlarni soddalash
        final hasUserInfo = state.userInfo != null;

        if (!hasUserInfo) {
          return _buildShimmer();
        }

        // YECHIM 3: Key bilan qayta yaratish
        return _UserNameDisplay(
          key: ValueKey(
            '${state.userInfo?.name}_${state.userInfo?.lastname}_${state.userInfo?.status}',
          ),
          name: state.userInfo!.name ?? '',
          lastname: state.userInfo!.lastname ?? '',
          isVerified: state.userInfo?.status == 2,
        );
      },
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: Colors.white38,
      highlightColor: Colors.grey[300]!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.h),
        child: Container(width: 150, height: 25, color: Colors.black),
      ),
    );
  }
}

class _UserNameDisplay extends StatelessWidget {
  final String name;
  final String lastname;
  final bool isVerified;

  const _UserNameDisplay({
    super.key,
    required this.name,
    required this.lastname,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8,
      children: [
        Text(
          '$name $lastname',
          style: Styles.boldHeadline6.copyWith(fontSize: 24.sp),
          textAlign: TextAlign.center,
        ),
        if (isVerified) AppIcons.verify.svg(),
      ],
    );
  }
}
