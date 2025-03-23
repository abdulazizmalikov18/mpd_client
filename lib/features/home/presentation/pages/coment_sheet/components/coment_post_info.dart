import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';
import 'package:mpd_client/features/home/presentation/widgets/animated_like.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';

class ComentPostInfo extends StatelessWidget {
  const ComentPostInfo({super.key, required this.post, required this.index});
  final Post post;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          ScreenUtil().setHorizontalSpacing(16.w),
          AnimatedLikeIcon(isLiked: post.isLiked!, postId: post.id!, baseIndex: index),
          ScreenUtil().setHorizontalSpacing(8.w),
          Text('${post.likesCount} ${context.l10n.lenth_likes}',
              style: Styles.postTitle.copyWith(fontFamily: Styles.gilroyRegular, color: context.color.grey)),
          ScreenUtil().setHorizontalSpacing(24.w),
          SvgPicture.asset(AppIcons.coment),
          ScreenUtil().setHorizontalSpacing(8.w),
          Text('${post.commentCount}  ${context.l10n.lenth_comment}',
              style: Styles.postTitle.copyWith(fontFamily: Styles.gilroyRegular, color: context.color.grey)),
          const Spacer(),
          Text(
            Utils.formatPostDate(post.date!, context),
            style: Styles.bottomLabel.copyWith(
              fontFamily: Styles.gilroyRegular,
              color: context.color.grey,
            ),
          ),
          ScreenUtil().setHorizontalSpacing(16.w)
        ],
      ),
    );
  }
}
