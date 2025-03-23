import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:video_player/video_player.dart';

class PostVideoView extends StatefulWidget {
  final File file;
  const PostVideoView({super.key, required this.file});

  @override
  State<PostVideoView> createState() => _PostVideoViewState();
}

class _PostVideoViewState extends State<PostVideoView> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(widget.file);
    _videoPlayerController.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 176.h,
      width: 176.h,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : const SizedBox.shrink(),
    );
  }
}
