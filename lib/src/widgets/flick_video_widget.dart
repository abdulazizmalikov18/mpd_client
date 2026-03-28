import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/features/home/domain/service/flick_multi_manger.dart';
import 'package:mpd_client/features/home/presentation/widgets/porttrait_controls.dart';

class FlickVideoWidget extends StatelessWidget {
  const FlickVideoWidget({
    super.key,
    required this.flickManager,
    this.flickMultiManager,
    required this.screenShotVideo,
  });

  final FlickManager? flickManager;
  final FlickMultiManager? flickMultiManager;
  final String? screenShotVideo;

  @override
  Widget build(BuildContext context) {
    return FlickVideoPlayer(
      flickManager: flickManager!,
      flickVideoWithControls: FlickVideoWithControls(
        playerLoadingFallback: Positioned.fill(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: screenShotVideo != null
                    ? CachedNetworkImage(
                        imageUrl:
                            screenShotVideo ??
                            'https://resources.comphealth.com/wp-content/uploads/2019/05/post-residency-career-tips.jpg',
                        fit: BoxFit.cover,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(32),
                        child: Image.asset(AppImages.logo, color: white),
                      ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    strokeWidth: 4,
                    color: context.color.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        controls: FeedPlayerPortraitControls(
          flickMultiManager: flickMultiManager,
          flickManager: flickManager,
        ),
      ),
      flickVideoWithControlsFullscreen: FlickVideoWithControls(
        videoFit: BoxFit.fitWidth,
        playerLoadingFallback: Center(
          child: screenShotVideo != null
              ? CachedNetworkImage(
                  imageUrl:
                      screenShotVideo ??
                      'https://resources.comphealth.com/wp-content/uploads/2019/05/post-residency-career-tips.jpg',
                  fit: BoxFit.fitWidth,
                )
              : Image.asset(AppImages.logo, color: mainBlue),
        ),
        controls: const FlickLandscapeControls(),
        iconThemeData: const IconThemeData(size: 40, color: Colors.white),
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
