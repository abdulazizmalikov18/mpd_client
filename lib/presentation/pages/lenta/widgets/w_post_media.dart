import 'package:flutter/material.dart';
import 'package:mpd_client/domain/entity/lenta/media_entity.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/w_video_player.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_shimmer.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

class WPostMedia extends StatefulWidget {
  final MediaEntity media;

  const WPostMedia({
    super.key,
    required this.media,
  });

  @override
  State<WPostMedia> createState() => _WPostMediaState();
}

class _WPostMediaState extends State<WPostMedia> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 400,
      child: switch (widget.media.type) {
        "image" => PinchToZoomScrollableWidget(
            maxScale: 2.5,
            rootOverlay: true,
            child: Image.network(
              widget.media.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: red,
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const WShimmer(
                    width: double.infinity,
                    height: 400,
                  );
                }
              },
            ),
          ),
        "video" => WVideoUrlPlayer(
            url: widget.media.file,
          ),
        _ => Container(
            color: black,
          ),
      },
    );
  }
}
