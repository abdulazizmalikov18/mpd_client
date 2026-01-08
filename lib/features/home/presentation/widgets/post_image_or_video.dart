import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/home/domain/service/flick_multi_manger.dart';
import 'package:mpd_client/main.dart';
import 'package:mpd_client/src/widgets/flick_video_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostImageOrVideo extends StatefulWidget {
  final String url;
  final bool? isVideo;
  final String? screenshotVideo;
  final FlickMultiManager flickMultiManager;

  const PostImageOrVideo({
    super.key,
    required this.screenshotVideo,
    required this.url,
    required this.isVideo,
    required this.flickMultiManager,
  });

  @override
  State<PostImageOrVideo> createState() => _PostImageOrVideoState();
}

class _PostImageOrVideoState extends State<PostImageOrVideo>
    with AutomaticKeepAliveClientMixin {
  FlickManager? flickManager;
  VideoPlayerController? videoController;
  bool isInitializing = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoIfNeeded();
  }

  void _initializeVideoIfNeeded() {
    if (widget.isVideo ?? false) {
      if (isInitializing) return;

      isInitializing = true;
      hasError = false;

      Log.d('Initializing video: ${widget.url}');

      // Video controller yaratish
      videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.url),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
          allowBackgroundPlayback: false,
        ),
        // Qo'shimcha sozlamalar texture rendering uchun
        httpHeaders: {
          'User-Agent': 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36',
        },
      );

      // Controller listener qo'shish
      videoController!.addListener(_videoControllerListener);

      // Video initialize qilish
      videoController!
          .initialize()
          .then((_) {
            if (mounted && videoController != null) {
              Log.d('Video initialized successfully: ${widget.url}');
              videoController!.setLooping(true);

              // FlickManager yaratish
              flickManager = FlickManager(
                videoPlayerController: videoController!,
                autoPlay: false,
              );

              widget.flickMultiManager.init(flickManager);

              setState(() {
                isInitializing = false;
              });
            }
          })
          .catchError((error) {
            Log.e('Video initialization error: $error');
            if (mounted) {
              setState(() {
                hasError = true;
                isInitializing = false;
              });
            }
          });
    }
  }

  void _videoControllerListener() {
    if (videoController?.value.hasError == true) {
      Log.e('Video playback error: ${videoController!.value.errorDescription}');
      if (mounted) {
        setState(() {
          hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    try {
      // FlickManager dispose qilish
      if (flickManager != null) {
        widget.flickMultiManager.remove(flickManager!);
        flickManager!.dispose();
        flickManager = null;
      }

      // VideoController dispose qilish
      if (videoController != null) {
        videoController!.removeListener(_videoControllerListener);
        videoController!.dispose();
        videoController = null;
      }
    } catch (e) {
      Log.e('Dispose error: $e');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VisibilityDetector(
      key: ObjectKey(widget.url),
      onVisibilityChanged: (visibilityInfo) {
        if (widget.isVideo ?? false) {
          Log.d('Video visibility: ${visibilityInfo.visibleFraction}');
          if (visibilityInfo.visibleFraction > 0.9) {
            if (flickManager != null) {
              Log.d('Playing video: ${widget.url}');
              widget.flickMultiManager.play(flickManager);
            }
          } else {
            Log.d('Pausing video: ${widget.url}');
            widget.flickMultiManager.pause();
          }
        }
      },
      child: getMedia(),
    );
  }

  Widget getMedia() {
    switch (widget.isVideo) {
      case null:
        return _buildDefaultImage();

      case false:
        return _buildImage();

      case true:
        return _buildVideo();
    }
  }

  Widget _buildDefaultImage() {
    return CachedNetworkImage(
      imageUrl:
          'https://resources.comphealth.com/wp-content/uploads/2019/05/post-residency-career-tips.jpg',
      fit: BoxFit.fitWidth,
      errorWidget: (context, url, error) => Container(
        height: 200,
        color: Colors.grey[300],
        child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      imageUrl: widget.url.isEmpty
          ? 'https://resources.comphealth.com/wp-content/uploads/2019/05/post-residency-career-tips.jpg'
          : widget.url,
      fit: BoxFit.fitWidth,
      errorWidget: (context, url, error) => Container(
        height: 200,
        color: Colors.grey[300],
        child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildVideo() {
    if (hasError) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Image.asset($appType.logoImage),
      );
    }

    // Loading holati
    if (isInitializing || flickManager == null) {
      return Container(
        height: 200,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Screenshot ko'rsatish (agar mavjud bo'lsa)
            if (widget.screenshotVideo != null)
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: widget.screenshotVideo!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            else
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Video yuklanmoqda...',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ],
        ),
      );
    }

    // Video widget
    return FlickVideoWidget(
      flickManager: flickManager,
      flickMultiManager: widget.flickMultiManager,
      screenShotVideo: widget.screenshotVideo,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
