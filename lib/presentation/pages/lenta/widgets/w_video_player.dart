import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';
import 'package:visibility_detector/visibility_detector.dart';

class WVideoUrlPlayer extends StatefulWidget {
  final String url;

  const WVideoUrlPlayer({super.key, required this.url});

  @override
  State<WVideoUrlPlayer> createState() => _WVideoUrlPlayerState();
}

class _WVideoUrlPlayerState extends State<WVideoUrlPlayer> with AutomaticKeepAliveClientMixin{
  late final player = Player(configuration: const PlayerConfiguration());

  late final controller = VideoController(player, configuration: const VideoControllerConfiguration());

  @override
  void initState() {
    super.initState();
    player.open(Media(widget.url));
    player.pause();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VisibilityDetector(
      key: Key('my-widget-${widget.url}'),
      onVisibilityChanged: (VisibilityInfo info) async {
        if (info.visibleFraction >= 0.9) {
          player.play();
        } else {
          player.pause();
        }
      },
      child: PinchToZoomScrollableWidget(
        maxScale: 2.5,
        rootOverlay: true,
        child: Video(
          width: double.infinity,
          height: double.infinity,
          controller: controller,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
