// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/home/domain/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:mpd_client/features/home/domain/blocs/post/post_bloc.dart';

class AnimatedLikeIconUser extends StatefulWidget {
  final bool isLiked;
  final int postId;
  final int baseIndex;
 final Color? colorUnLiked;
  final VoidCallback onTap;
  const AnimatedLikeIconUser({
    super.key,
    required this.isLiked,
    required this.postId,
    required this.baseIndex,
    required this.onTap, this.colorUnLiked,
  });

  @override
  State<AnimatedLikeIconUser> createState() => _AnimatedFollowIconState();
}

class _AnimatedFollowIconState extends State<AnimatedLikeIconUser>
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
            .read<PostBloc>()
            .add(MediaLikePressedUser(index: widget.baseIndex));
        // context.read<PostUiBloc>().add(PostLikeUnlikeEvent());
        context.read<LikeUnlikeBloc>().add(
            LikeUnlikePressed(postId: widget.postId, isLiked: widget.isLiked));
        widget.onTap();
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
          color: widget.isLiked ? context.color.red :widget.colorUnLiked?? context.color.grey,
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
