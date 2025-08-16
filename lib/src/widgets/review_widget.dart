import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/home/data/models/coment_model.dart';
import 'package:mpd_client/features/home/domain/blocs/send_coment/send_coment_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/widgets/cached_image_widget.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';
import 'package:readmore/readmore.dart';

import '../../app/app_colors.dart';
import '../../app/app_icons.dart';
import '../../features/home/domain/blocs/post_coment/post_coment_bloc.dart';
import '../themes/styles.dart';

class ReviewWidget extends StatelessWidget {
  final Coment? coment;
  final SendComentState status;
  final int postId;
  const ReviewWidget({
    super.key,
    this.coment,
    required this.status,
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
                  ? coment!.avatar != null || coment!.avatar != ''
                        ? CachedImageWidget(url: coment!.avatar ?? "", size: 40)
                        : const DefaultAvatar(containerSize: 40, imageSize: 28)
                  : const DefaultAvatar(containerSize: 40, imageSize: 28),
              ScreenUtil().setHorizontalSpacing(10),
              coment != null
                  ? Text(
                      '${coment!.name ?? "--"} ${coment!.lastname ?? "--"}',
                      style: Styles.boldHeadline6,
                    )
                  : Text('Leslie Alexader', style: Styles.boldHeadline6),
              const Spacer(),
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.clockTransparent,
                    height: 16.h,
                    width: 16.h,
                    colorFilter: ColorFilter.mode(
                      context.color.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  ScreenUtil().setHorizontalSpacing(4),
                  comentStatus(context),
                ],
              ),
            ],
          ),
        ),
        ScreenUtil().setVerticalSpacing(8.h),
        ReadMoreText(
          coment != null
              ? coment!.text!
              : 'Lorem ipsum dolor sit amet consectetur. Risus faucibus euismod turpis faucibus euismod elit augue interdum lacus. Dictum urna tempus dui interdum elementum dui dui  dui dui  dui duisadasdasd  dui dui',
          style: Styles.headline7.copyWith(
            color: context.color.grey,
            fontSize: 14.sp,
          ),
          moreStyle: Styles.headline7.copyWith(
            color: context.color.mainBlue,
            fontSize: 14.sp,
          ),
          lessStyle: Styles.headline7.copyWith(
            color: context.color.mainBlue,
            fontSize: 14.sp,
          ),
          trimExpandedText: context.l10n.lenth_show_less,
          trimCollapsedText: context.l10n.lenth_read_more,
          trimLines: 3,
          trimMode: TrimMode.Line,
        ),
      ],
    );
  }

  Widget comentStatus(BuildContext context) {
    if (status.coment != null &&
        status is SendComentLoading &&
        coment!.id == status.coment!.id) {
      return Text(
        context.l10n.lenth_publish_comment,
        style: Styles.bottomLabel.copyWith(color: context.color.grey),
      );
    } else if (status is SendComentSuccess && coment!.id == status.coment!.id) {
      return Text(
        Utils.formatPostDate(coment!.date!, context),
        style: Styles.bottomLabel.copyWith(color: context.color.grey),
      );
    } else if (status is SendComentFailure && coment!.id == status.coment!.id) {
      return IconButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          final oldComent = Coment(id: -1, text: coment!.text);
          context.read<SendComentBloc>().add(SendComment(postId, oldComent));
          context.read<PostComentBloc>().add(
            UpdateOldComent(oldComent, isSuccess: false),
          );
        },
        icon: const Icon(Icons.refresh),
      );
    } else {
      return Text(
        coment != null
            ? coment!.date != null
                  ? Utils.formatPostDate(coment!.date!, context)
                  : Utils.formatPostDate(DateTime.now(), context)
            : '24 Dec 2022',
        style: Styles.bottomLabel.copyWith(color: context.color.grey),
      );
    }
  }
}
