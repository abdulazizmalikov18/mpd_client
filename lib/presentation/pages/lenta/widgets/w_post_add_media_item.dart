import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpd_client/presentation/pages/lenta/view/create_post_view.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';
import 'package:video_player/video_player.dart';

class WPostAddPhotoItem extends StatefulWidget {
  const WPostAddPhotoItem({super.key});

  @override
  State<WPostAddPhotoItem> createState() => _WPostAddPhotoItemState();
}

class _WPostAddPhotoItemState extends State<WPostAddPhotoItem> {
  void onRemoveFile(int index) {
    CreatePostView.maybeOf(context)!.files.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final files = CreatePostView.maybeOf(context)!.files;
    final size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      for (int index = 0; index < files.length; index++)
                        Padding(
                          padding: EdgeInsets.only(left: index.isOdd ? 16 : 0, top: index > 1 ? 16 : 0),
                          child: WMediaReder(
                            onClose: () => onRemoveFile(index),
                            file: files[index],
                            width: (size.width - 48) * 0.5,
                            height: (size.width - 48) * 0.5,
                          ),
                        ),
                      GestureDetector(
                        onTap: () async {
                          final medias = await ImagePicker().pickMultipleMedia(limit: 5);
                          if (context.mounted && medias.isNotEmpty) {
                            CreatePostView.maybeOf(context)!.files = [...files, ...medias.map((e) => File(e.path))];
                            setState(() {});
                          }
                        },
                        child: Container(
                          width: files.isEmpty ? double.infinity : (size.width - 48) * 0.5,
                          height: (size.width - 48) * 0.5,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: files.length.isOdd ? 16 : 0, top: files.length > 1 ? 16 : 0),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: border,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: AppIcons.gallery.svg(),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Add Media',
                                style: AppTheme.headlineSmall.copyWith(
                                  color: black.withOpacity(0.5),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
      ],
    );
  }
}

class WMediaReder extends StatefulWidget {
  final File file;
  final void Function() onClose;
  final double width;
  final double height;
  const WMediaReder({
    super.key,
    required this.onClose,
    required this.file,
    required this.width,
    required this.height,
  });

  @override
  State<WMediaReder> createState() => _WMediaRederState();
}

class _WMediaRederState extends State<WMediaReder> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    if (widget.file.path.toLowerCase().endsWith('mp4')) {
      _videoPlayerController = VideoPlayerController.file(widget.file);
      _videoPlayerController.initialize().then((value) => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          widget.file.path.toLowerCase().endsWith('mp4')
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: widget.width,
                    height: widget.height,
                    child: AspectRatio(
                      aspectRatio: 19 / 6,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Image.file(
                    widget.file,
                    width: widget.width,
                    height: widget.height,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: widget.width,
                        height: widget.height,
                        decoration: BoxDecoration(
                          color: white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: white.withOpacity(0.2),
                          ),
                        ),
                        child: Icon(
                          CupertinoIcons.doc_fill,
                          color: white.withOpacity(0.5),
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: widget.onClose,
              child: AppIcons.circleCancel.svg(
                width: 16,
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
