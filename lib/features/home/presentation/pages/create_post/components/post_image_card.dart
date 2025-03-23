import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/home/data/models/file_model.dart';
import 'package:video_player/video_player.dart';

class PostImageAndVideoView extends StatefulWidget {
  final FileModel filemodel;
  final VoidCallback onRemovePressed;
  const PostImageAndVideoView(
      {super.key, required this.filemodel, required this.onRemovePressed});

  @override
  State<PostImageAndVideoView> createState() => _PostImageAndVideoViewState();
}

class _PostImageAndVideoViewState extends State<PostImageAndVideoView> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    if (widget.filemodel.fileType == 'video') {
      _videoPlayerController =
          VideoPlayerController.file(widget.filemodel.file);
      _videoPlayerController.initialize().then((value) => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176.h,
      width: 176.h,
      margin: EdgeInsets.only(right: 16.w),
      child: Stack(
        children: [
          Positioned.fill(
            child: widget.filemodel.fileType == 'image'
                ? RepaintBoundary(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image(
                        image: FileImage(widget.filemodel.file),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                  ),
          ),
          Material(
            color: context.color.white.withValues(alpha: 0.5),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  splashRadius: 21,
                  onPressed: widget.onRemovePressed,
                  icon: SvgPicture.asset(AppIcons.remove)),
            ),
          ),
        ],
      ),
    );
  }
}
