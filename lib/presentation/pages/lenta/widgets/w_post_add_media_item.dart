import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpd_client/presentation/pages/lenta/view/create_post_view.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add photo',
          style: AppTheme.labelSmall.copyWith(
            color: white,
          ),
        ),
        const SizedBox(height: 8),
        files.isEmpty
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 96,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                child: Image.file(
                                  files[index],
                                  width: 96,
                                  height: 96,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 96,
                                      height: 96,
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
                                  onTap: () => onRemoveFile(index),
                                  child: AppIcons.back.svg(
                                    width: 16,
                                    height: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 8);
                      },
                      itemCount: files.length,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
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
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: white.withOpacity(0.1),
              border: Border.all(
                color: borderColor,
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
                    color: white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AppIcons.gallery.svg(),
                ),
                const SizedBox(height: 4),
                Text(
                  'Add Media',
                  style: AppTheme.headlineSmall.copyWith(
                    color: white.withOpacity(0.5),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
