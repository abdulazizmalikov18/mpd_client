import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/domain/models/lenta/comment_model.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/cached_image_widget.dart';
import 'package:mpd_client/presentation/widgets/widget_defaul_avatar.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:readmore/readmore.dart';

class ReviewWidget extends StatelessWidget {
  final CommentModel? coment;
  final int postId;
  const ReviewWidget({
    super.key,
    this.coment,
    this.postId = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coment != null
                  ? coment?.avatar != null || coment!.avatar != ''
                      ? CachedImageWidget(url: coment!.avatar, size: 40)
                      : const DefaultAvatar(containerSize: 40, imageSize: 28)
                  : const DefaultAvatar(containerSize: 40, imageSize: 28),
              ScreenUtil().setHorizontalSpacing(10),
              coment != null
                  ? Text(
                      '${coment!.name} ${coment!.lastname}',
                      style: Styles.boldHeadline6,
                    )
                  : Text(
                      'Leslie Alexader',
                      style: Styles.boldHeadline6,
                    ),
              const Spacer(),
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.clockTransparent,
                    height: 16.h,
                    width: 16.h,
                    colorFilter: const ColorFilter.mode(grey, BlendMode.srcIn),
                  ),
                  ScreenUtil().setHorizontalSpacing(4),
                  // comentStatus(context)
                ],
              ),
            ],
          ),
        ),
        ScreenUtil().setVerticalSpacing(8.h),
        ReadMoreText(
          coment != null
              ? coment!.text
              : 'Lorem ipsum dolor sit amet consectetur. Risus faucibus euismod turpis faucibus euismod elit augue interdum lacus. Dictum urna tempus dui interdum elementum dui dui  dui dui  dui duisadasdasd  dui dui',
          style: Styles.headline7.copyWith(color: grey, fontSize: 14),
          moreStyle: Styles.headline7.copyWith(color: mainBlue, fontSize: 14),
          lessStyle: Styles.headline7.copyWith(color: mainBlue, fontSize: 14),
          trimExpandedText: context.l10n.lenth_show_less,
          trimCollapsedText: context.l10n.lenth_read_more,
          trimLines: 3,
          trimMode: TrimMode.Line,
        ),
      ],
    );
  }
}
