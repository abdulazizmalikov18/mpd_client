// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/features/home/domain/blocs/post/post_bloc.dart';
import 'package:mpd_client/features/home/domain/service/flick_multi_manger.dart';
import 'package:mpd_client/features/user/domain/blocs/user_info/user_info_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';
import 'package:shimmer/shimmer.dart';

class HomeAppbarComponent extends StatelessWidget implements PreferredSize {
  final FlickMultiManager flickMultiManager;

  const HomeAppbarComponent({super.key, required this.flickMultiManager});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      backgroundColor: context.color.white,
      elevation: .0,
      toolbarHeight: 60.h,
      centerTitle: false,
      titleSpacing: 16.w,
      title: BlocBuilder<UserInfoBloc, UserInfoState>(
        builder: (context, state) {
          if (state.userInfo != null) {
            return _buildUserInfo(
              state.userInfo!.name ?? "--",
              state.userInfo!.lastname ?? "--",
              state.userInfo!.avatar,
              true,
              () {
                flickMultiManager.pause();
                Navigator.of(context)
                    .pushNamed(AppRoutes.userInfo, arguments: state.userInfo);
              },
              context,
            );
          }
          if (state.status.isSuccess) {
            return _buildUserInfo(
              state.userInfo!.name!,
              state.userInfo!.surname!,
              state.userInfo!.avatar!,
              false,
              () {
                Navigator.of(context).pushNamed(
                  AppRoutes.userInfo,
                  arguments: state.userInfo,
                );
              },
              context,
            );
          } else if (state.status.isInProgress) {
            return Shimmer.fromColors(
              baseColor: context.color.mainBlue.withValues(alpha: 0.2),
              highlightColor: context.color.mainBlue.withValues(alpha: 0.4),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 42.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: context.color.white),
                ),
                title: Container(
                  height: 14.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: context.color.white),
                ),
                subtitle: Container(
                  height: 16.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: context.color.white),
                ),
              ),
            );
          } else {
            return const Text('Error');
          }
        },
      ),
      actions: [
        IconButton(
          splashRadius: 26,
          constraints: const BoxConstraints(),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.notification);
          },
          icon: SvgPicture.asset(
            AppIcons.notification,
            color: context.color.black,
          ),
        ),
        BlocBuilder<UserInfoBloc, UserInfoState>(
          builder: (context, state) {
            if (state.specailistModel.isEmpty) {
              return const SizedBox();
            }
            return IconButton(
              splashRadius: 26,
              constraints: const BoxConstraints(),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.createPost).then(
                  (value) {
                    if (value != null) {
                      if (value as bool) {
                        if (context.mounted) {
                          context.read<PostBloc>().add(PostFetched(true));
                        }
                      }
                    }
                  },
                );
              },
              icon: SvgPicture.asset(
                AppIcons.plusCircle,
                colorFilter:
                    ColorFilter.mode(context.color.black, BlendMode.srcIn),
              ),
            );
          },
        )
      ],
    );
  }

  Theme _buildUserInfo(String name, String surname, dynamic image, bool isLocal,
      VoidCallback onTap, BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: setImage(false, image),
            ),
            ScreenUtil().setHorizontalSpacing(10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.lenth_hello,
                  style: Styles.bottomLabel.copyWith(color: context.color.grey),
                ),
                Text(
                  '$name $surname',
                  style: Styles.bottomLabel.copyWith(
                      color: context.color.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget setImage(bool isLocal, dynamic image) {
    if (isLocal && image != null) {
      return Image.memory(image, height: 42.h, width: 42.h, fit: BoxFit.cover);
    } else if (!isLocal) {
      return SizedBox(
        height: 42.h,
        width: 42.h,
        child: CachedNetworkImage(
          imageUrl: image ??
              'https://resources.comphealth.com/wp-content/uploads/2019/05/post-residency-career-tips.jpg',
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => CircleAvatar(
            backgroundColor: mainBlue.withValues(alpha: 0.1),
          ),
        ),
      );
    } else {
      return const DefaultAvatar(containerSize: 42, imageSize: 28);
    }
  }

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}

//searchfield
/*
 ListTile(
          onTap: onTap,
          horizontalTitleGap: 4.w,
          contentPadding: EdgeInsets.zero,
          isThreeLine: true,
          visualDensity: const VisualDensity(vertical: -1),
          subtitle: Text(
            '$name $surname',
            style: Styles.bottomLabel.copyWith(
                color: context.color.black,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          title: Text(
            context.l10n.lenth_hello,
            style: Styles.bottomLabel.copyWith(color: context.color.grey),
          ),
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: setImage(isLocal, image))),
 
  */
