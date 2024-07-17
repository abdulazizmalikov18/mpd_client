import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/domain/models/main/main_model.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/gallery_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsModel param;
  const NewsDetailPage({super.key, required this.param});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.white,
          body: ListView(
            children: [
              Stack(
                children: [
                  Gallery2Comp(
                    images: param.photos?.toList() ?? [],
                    onTap: () {
                      List<ImagesModel> images = param.photos
                              ?.map((e) => ImagesModel((b) => b..url = e))
                              .toList() ??
                          [];
                      if (images.isNotEmpty) {
                        Navigator.push(context,
                            AppRoutes.getGalleryDetail(images: images));
                      }
                    },
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(16),
                    child: AnimationButtonEffect(
                      onTap: () => Navigator.pop(context),
                      child: CircleAvatar(
                        backgroundColor: colors.black.withOpacity(.4),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: icons.back.svg(color: colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ListView(
                padding: const EdgeInsets.all(16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(
                    param.title ?? 'news2'.tr(),
                    style: TextStyle(
                      color: colors.black,
                      fontSize: 18.sp,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'more_details'.tr(),
                          style: Style.medium14(color: colors.primary),
                        ),
                      ),
                      8.horizontalSpace,
                      Opacity(
                        opacity: .5,
                        child: Text(
                          param.createdAt
                                  ?.substring(0, 10)
                                  .replaceAll("-", "/") ??
                              "",
                          style: Style.medium14(color: colors.text),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: colors.customGreyC3,
                    thickness: .4,
                  ),
                  Text(
                    param.description ?? "",
                    style: Style.medium14(color: colors.black.withOpacity(0.5)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
