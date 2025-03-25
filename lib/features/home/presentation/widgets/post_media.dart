import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';
import 'package:mpd_client/features/home/domain/inherited/post_inhereted.dart';
import 'package:mpd_client/features/home/domain/service/flick_multi_manger.dart';
import 'package:mpd_client/features/home/presentation/widgets/post_image_or_video.dart';
import 'package:mpd_client/features/home/presentation/widgets/swipe_indicator.dart';
import 'package:video_player/video_player.dart';

import '../../../../app/app_colors.dart';
import '../../../../src/themes/styles.dart';

class PostMedia extends StatefulWidget {
  const PostMedia({
    super.key,
    required this.postMedias,
    required this.baseIndex,
    required this.flickMultiManager,
    required this.post,
  });
  final List<Media>? postMedias;
  final int baseIndex;
  final Post post;
  final FlickMultiManager flickMultiManager;

  @override
  State<PostMedia> createState() => _PostMediaState();
}

class _PostMediaState extends State<PostMedia>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2 + 60.h,
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.postMedias!.length,
            onPageChanged: (index) {
              PostInheritedNotifier.of(context).notifier!.changedMediaIndex(
                  postIndex: widget.baseIndex, mediaIndex: index);
            },
            itemBuilder: (context, index) {
              if (isVideo(index) ?? false) {
                return PostImageOrVideo(
                  flickMultiManager: widget.flickMultiManager,
                  screenshotVideo: widget.postMedias![index].screenshot,
                  url: isVideoUrl(index),
                  isVideo: isVideo(index),
                );
              }
              return GestureDetector(
                onDoubleTap: () {
                  context
                      .read<MediaControlBloc>()
                      .add(MediaLikePressed(widget.baseIndex));
                  // context.read<PostUiBloc>().add(PostLikeUnlikeEvent());
                  context.read<LikeUnlikeBloc>().add(LikeUnlikePressed(
                        postId: widget.post.id ?? 0,
                        isLiked: widget.post.isLiked ?? false,
                      ));
                },
                child: CachedNetworkImage(
                  imageUrl: widget.postMedias![index].image ??
                      'https://resources.comphealth.com/wp-content/uploads/2019/05/post-residency-career-tips.jpg',
                  errorWidget: (context, url, error) => CachedNetworkImage(
                    imageUrl:
                        'https://resources.comphealth.com/wp-content/uploads/2019/05/post-residency-career-tips.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          Positioned(
            bottom: 10.h,
            right: 0,
            left: 0,
            child: SwipeIndicator(
              current: PostInheritedNotifier.of(context).notifier!.post.isEmpty
                  ? 0
                  : PostInheritedNotifier.of(context)
                      .notifier!
                      .post[widget.baseIndex]
                      .selectedIndex!,
              length: widget.postMedias!.length,
            ),
          ),
          Positioned(
            top: 12.h,
            right: 12.w,
            child: widget.postMedias!.length != 1
                ? Text(
                    '${PostInheritedNotifier.of(context).notifier!.post.isEmpty ? 0 : PostInheritedNotifier.of(context).notifier!.post[widget.baseIndex].selectedIndex! + 1}/${widget.postMedias!.length}',
                    style: Styles.semiboldTitle.copyWith(
                      color: context.color.white,
                      fontFamily: Styles.gilroyRegular,
                    ),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  bool? isVideo(int index) {
    if (widget.postMedias!.isEmpty) {
      return null;
    } else if (widget.postMedias![index].image == null) {
      return true;
    } else {
      return false;
    }
  }

  String isVideoUrl(int index) {
    if (widget.postMedias!.isEmpty) {
      return '';
    } else {
      if (widget.postMedias![index].image == null &&
          widget.postMedias![index].file != null) {
        return widget.postMedias![index].file ?? "";
      } else {
        return widget.postMedias![index].image ?? "";
      }
    }
  }

  VideoPlayerController? getVideo(int index) {
    if (widget.postMedias!.isEmpty || widget.postMedias![index].image != null) {
      return null;
    }
    return VideoPlayerController.networkUrl(
        Uri.parse(widget.postMedias![index].file!));
  }

  @override
  bool get wantKeepAlive => true;
}
