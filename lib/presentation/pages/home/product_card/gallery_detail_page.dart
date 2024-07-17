import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class GalleryDetailPage extends StatelessWidget {
  const GalleryDetailPage({super.key, required this.images});

  final List<ImagesModel> images;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.text,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: colors.text,
              surfaceTintColor: colors.text,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: icons.back.svg(color: colors.white),
              ),
            )
          ],
          body: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: images[index].url ?? "",
                fit: BoxFit.contain,
                placeholder: (context, url) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Platform.isAndroid
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(colors.blue),
                          ),
                        )
                      : const Stack(
                          alignment: Alignment.center,
                          children: [
                            CupertinoActivityIndicator(),
                            Visibility(
                              visible: false,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text('Loading'),
                              ),
                            )
                          ],
                        ),
                ),
                errorWidget: (context, _, __) => Image.asset(
                  'assets/images/default_image.jpg',
                  fit: BoxFit.cover,
                ),
              );
            },
            itemCount: images.length,
          ),
        ),
      );
    });
  }
}
