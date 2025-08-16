import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';
import 'package:mpd_client/features/home/domain/inherited/post_inhereted.dart';
import 'package:mpd_client/features/home/domain/service/flick_multi_manger.dart';
import 'package:mpd_client/features/home/presentation/widgets/swipe_indicator.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/flick_video_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ComentContent extends StatefulWidget {
  final List<Media> media;
  final FlickManager? flickManager;
  final FlickMultiManager flickMultiManager;
  const ComentContent({
    super.key,
    required this.media,
    this.flickManager,
    required this.flickMultiManager,
  });

  @override
  State<ComentContent> createState() => _ComentContentState();
}

class _ComentContentState extends State<ComentContent> {
  @override
  void dispose() {
    widget.flickMultiManager.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(widget.flickMultiManager),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 0 && context.mounted) {
          widget.flickMultiManager.pause();
        }
      },
      child: AspectRatio(
        aspectRatio: 6 / 5,
        child: Stack(
          children: [
            PageView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.media.length,
              onPageChanged: (index) {
                PostInheritedNotifier.of(
                  context,
                ).notifier!.changeSelectedMediaIndex(index);
              },
              itemBuilder: (context, index) {
                return ComentMediaContent(
                  media: widget.media[index],
                  flickManager: widget.flickManager,
                  flickMultiManager: widget.flickMultiManager,
                );
              },
            ),
            Positioned(
              bottom: 10.h,
              right: 0,
              left: 0,
              child: SwipeIndicator(
                current: PostInheritedNotifier.of(
                  context,
                ).notifier!.selectedMediaIndex,
                length: widget.media.length,
              ),
            ),
            Positioned(
              top: 12.h,
              right: 12.w,
              child: Text(
                widget.media.length > 1
                    ? '${PostInheritedNotifier.of(context).notifier!.selectedMediaIndex + 1}/${widget.media.length}'
                    : '',
                style: Styles.semiboldTitle.copyWith(
                  color: context.color.white,
                  fontFamily: Styles.gilroyRegular,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComentMediaContent extends StatefulWidget {
  const ComentMediaContent({
    super.key,
    required this.media,
    required this.flickManager,
    required this.flickMultiManager,
  });

  final Media media;
  final FlickManager? flickManager;
  final FlickMultiManager flickMultiManager;

  @override
  State<ComentMediaContent> createState() => _ComentMediaContentState();
}

class _ComentMediaContentState extends State<ComentMediaContent>
    with AutomaticKeepAliveClientMixin {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    if (widget.media.file == null) return;
    if (widget.flickManager == null) {
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(widget.media.file!),
        )..setLooping(true),
        autoPlay: false,
      );

      widget.flickMultiManager.init(flickManager);
      return;
    }
    flickManager = widget.flickManager!;
    if (widget.media.file !=
        flickManager.flickVideoManager!.videoPlayerController!.dataSource) {
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(widget.media.file!),
        )..setLooping(true),
        autoPlay: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VisibilityDetector(
      key: ObjectKey(widget.media.id),
      onVisibilityChanged: (visibility) {
        if (widget.media.file == null) widget.flickMultiManager.play(null);
        if (visibility.visibleFraction > 0.9) {
          widget.flickMultiManager.play(null);
        }
      },
      child: widget.media.file == null
          ? CachedNetworkImage(
              imageUrl:
                  widget.media.image ??
                  "https://dwed.fra1.digitaloceanspaces.com/SMMS/media/PostMedia/image/a651706c-f6a0-45fe-9d40-46e9fb37271b.jpeg",
              fit: BoxFit.cover,
              // placeholder: (context, url) =>  Material(color: context.color.grey),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          : FlickVideoWidget(
              flickManager: flickManager,
              flickMultiManager: widget.flickMultiManager,
              screenShotVideo: AppImages.marketCategory,
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
