import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/features/home/domain/service/flick_multi_manger.dart';
import 'package:mpd_client/src/widgets/flick_video_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostImageOrVideo extends StatefulWidget {
  final String url;
  final bool? isVideo;
  final String? screenshotVideo;
  final FlickMultiManager flickMultiManager;

  const PostImageOrVideo(
      {super.key,
      required this.screenshotVideo,
      required this.url,
      required this.isVideo,
      required this.flickMultiManager});

  @override
  State<PostImageOrVideo> createState() => _PostImageOrVideoState();
}

class _PostImageOrVideoState extends State<PostImageOrVideo>
    with AutomaticKeepAliveClientMixin {
  FlickManager? flickManager;
  List<VideoPlayerController> videoControllers = [];

  @override
  void initState() {
    super.initState();
    if (widget.isVideo != null && widget.isVideo!) {
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(widget.url),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        )..setLooping(true),
        autoPlay: false,
      );
      widget.flickMultiManager.init(flickManager);
    }
  }

  @override
  void dispose() {
    flickManager!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VisibilityDetector(
      key: ObjectKey(widget.url),
      onVisibilityChanged: (visiblityInfo) {
        if (visiblityInfo.visibleFraction >= 0.9) {
          widget.flickMultiManager.play(flickManager);
        } else {
          widget.flickMultiManager.pause();
        }
      },
      child: getMedia(),
    );
  }

  Widget getMedia() {
    switch (widget.isVideo) {
      case null:
        return Image.network(
          'https://resources.comphealth.com/wp-content/uploads/2019/05/post-residency-career-tips.jpg',
          fit: BoxFit.cover,
        );

      case false:
        return CachedNetworkImage(
          imageUrl: widget.url.isEmpty
              ? 'https://resources.comphealth.com/wp-content/uploads/2019/05/post-residency-career-tips.jpg'
              : widget.url,
          fit: BoxFit.cover,
          // placeholder: (context, url) => Material(
          //   color: context.color.grey.withValues(alpha:0.2),
          // ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );

      case true:
        return FlickVideoWidget(
          flickManager: flickManager,
          flickMultiManager: widget.flickMultiManager,
          screenShotVideo: widget.screenshotVideo,
        );
    }
  }

  @override
  bool get wantKeepAlive => true;
}

/*
onVisibilityChanged: (visibilityInfo) {
          if (widget.isVideo == null || !widget.isVideo!) return;

          if (visibilityInfo.visibleFraction > 0.7) {
            _controller.play();

            if (_controller.value.isPlaying) {
              context
                  .read<MediaControlBloc>()
                  .add(VideoControlEvent(_controller));
            }
          } else {
            if (mounted) {
              if (!_controller.value.isPlaying) {
                context
                    .read<MediaControlBloc>()
                    .add(const VideoControlEvent(null));
              }
            }
          }
        },

 */
