import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/domain/entity/lenta/comment_entity.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_network_image.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class WComment extends StatefulWidget {
  final bool isMine;
  final CommentEntity comment;

  const WComment({
    super.key,
    this.isMine = true,
    required this.comment,
  });

  @override
  State<WComment> createState() => _WCommentState();
}

class _WCommentState extends State<WComment> {
  late bool isLike = false;

  void onPressLike() {
    // context.read<CommentBloc>().add(CommentLikeEvent(isLike));

    setState(() {
      isLike = !isLike;
    });
  }

  // void onPressReply() => CommentView.maybeOf(context)!.onPressReply(widget.comment);

  String calculateDate(String dateTime) {
    final oldTime = DateTime.tryParse(dateTime) ?? DateTime.now();
    final time = DateTime.now().difference(oldTime);
    if (time.inDays != 0) {
      return "${time.inDays} day ago";
    } else if (time.inHours != 0) {
      return "${time.inHours} hour ago";
    } else if (time.inMinutes != 0) {
      return "${time.inMinutes} minute ago";
    } else {
      return "${time.inSeconds} second ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WNetworkImage(
                image: widget.comment.avatar,
                height: 40,
                width: 40,
                borderRadius: 100,
                defaultWidget: Image.asset(
                  AppImages.userAvatar,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${widget.comment.name} ${widget.comment.lastname}',
                style: AppTheme.bodyMedium.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcons.clockTransparent.svg(
                    color: gray,
                  ),
                  Text(
                    calculateDate(widget.comment.date),
                    style: AppTheme.bodyMedium.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: gray,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.comment.text.isNotEmpty ? widget.comment.text : '',
            style: AppTheme.labelSmall.copyWith(
              color: black.withOpacity(.4),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
