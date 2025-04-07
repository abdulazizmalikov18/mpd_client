// ignore_for_file: deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';

import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/home/domain/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:mpd_client/features/home/domain/blocs/media_control/media_control_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';

class Like extends StatelessWidget {
  final int? likeCount;
  final bool isLiked;
  final int postId;
  final int baseIndex;
  const Like({
    super.key,
    required this.baseIndex,
    required this.likeCount,
    required this.isLiked,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedLikeIcon(
          isLiked: isLiked,
          postId: postId,
          baseIndex: baseIndex,
        ),
        ScreenUtil().setHorizontalSpacing(4.w),
        Text(
          '$likeCount ${context.l10n.lenth_likes}',
          style: Styles.postTitle.copyWith(
              color: context.color.grey, fontFamily: Styles.gilroyRegular),
        ),
      ],
    );
  }
}

class AnimatedLikeIcon extends StatefulWidget {
  final bool isLiked;
  final int postId;
  final int baseIndex;
  const AnimatedLikeIcon({
    super.key,
    required this.isLiked,
    required this.postId,
    required this.baseIndex,
  });

  @override
  State<AnimatedLikeIcon> createState() => _AnimatedFollowIconState();
}

class _AnimatedFollowIconState extends State<AnimatedLikeIcon>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 1.0,
      upperBound: 1.25,
      lowerBound: 1.0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (!widget.isLiked) {
          _animationController
              .forward()
              .then((value) => _animationController.reverse());
        }
        context
            .read<MediaControlBloc>()
            .add(MediaLikePressed(widget.baseIndex));
        // context.read<PostUiBloc>().add(PostLikeUnlikeEvent());
        context.read<LikeUnlikeBloc>().add(
            LikeUnlikePressed(postId: widget.postId, isLiked: widget.isLiked));
      },
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(minHeight: 32.w, minWidth: 32.w),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: ScaleTransition(
        scale: _animationController,
        child: SvgPicture.asset(
          widget.isLiked ? AppIcons.liked : AppIcons.unliked,
          height: 20.h,
          color: widget.isLiked ? context.color.red : context.color.grey,
        ),
      ),
    );
  }
}

/*

Icon(
          onTapped! ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
          color: onTapped! ? context.color.red : context.color.grey,
          size: 24.h,
        ),

 */
