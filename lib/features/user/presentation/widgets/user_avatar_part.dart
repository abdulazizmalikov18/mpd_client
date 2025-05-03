import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/src/widgets/gradient_icon.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../app/app_export.dart';

class UserAvatarPart extends StatelessWidget {
  const UserAvatarPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        if (state.status.isInProgress) {
          return _buildLoading();
        } else if (state.status.isSuccess) {
          return _buildAvatar(false, state.userInfo!.avatar, context);
        } else if (state.userInfo != null) {
          return _buildAvatar(true, state.userInfo!.avatar, context);
        } else {
          return const Text('Error');
        }
      },
    );
  }

  Positioned _buildLoading() {
    return Positioned(
      top: 150.h,
      left: 0,
      right: 0,
      child: Center(
        child: Shimmer.fromColors(
          direction: ShimmerDirection.ltr,
          baseColor: Colors.white38,
          highlightColor: Colors.grey[300]!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(48.h),
            child: Image.asset(
              AppImages.userAvatar,
              height: 96.h,
              width: 96.h,
            ),
          ),
        ),
      ),
    );
  }

  Positioned _buildAvatar(bool isLocal, dynamic image, BuildContext context) {
    return Positioned(
      top: 150.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Center(
        child: Hero(
          tag: 'image',
          child: setImage(isLocal, image, context),
        ),
      ),
    );
  }

  Widget setImage(bool isLocal, dynamic image, BuildContext context) {
    if (image is String) {
      return Container(
        height: 100.h,
        width: 100.h,
        decoration: BoxDecoration(
          border: Border.all(color: context.color.white, width: 4),
          shape: BoxShape.circle,
          image: DecorationImage(
            image: CachedNetworkImageProvider(image),
            onError: (exception, stackTrace) => Image.network(
              "https://www.no5.com/media/1772/place-holder-image.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    if (isLocal && image != null) {
      return Container(
        height: 100.h,
        width: 100.h,
        decoration: BoxDecoration(
          border: Border.all(color: context.color.black),
          borderRadius: BorderRadius.circular(48.r),
          image: DecorationImage(
            image: MemoryImage(image),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (!isLocal && image != null) {
      return Container(
        height: 100.h,
        width: 100.h,
        decoration: BoxDecoration(
          border: Border.all(color: context.color.white, width: 4),
          borderRadius: BorderRadius.circular(48.r),
          image: DecorationImage(
            image: CachedNetworkImageProvider(image),
            onError: (exception, stackTrace) => Image.network(
              "https://www.no5.com/media/1772/place-holder-image.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container(
        height: 100.h,
        width: 100.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.color.white.withValues(alpha: 0.9),
        ),
        child: const GradientIcon(
          iconName: AppIcons.avatarDefault,
          size: 68,
        ),
      );
    }
  }
}
