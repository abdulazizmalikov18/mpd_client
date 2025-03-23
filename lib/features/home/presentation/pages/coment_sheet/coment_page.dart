import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';
import 'package:mpd_client/features/home/domain/blocs/media_control/media_control_bloc.dart';
import 'package:mpd_client/features/home/domain/blocs/send_coment/send_coment_bloc.dart';
import 'package:mpd_client/features/home/domain/service/flick_multi_manger.dart';
import 'package:mpd_client/features/home/presentation/pages/coment_sheet/components/coment_content.dart';
import 'package:mpd_client/features/home/presentation/pages/coment_sheet/components/coment_input.dart';
import 'package:mpd_client/features/home/presentation/pages/coment_sheet/components/coment_post_info.dart';
import 'package:mpd_client/features/home/presentation/pages/coment_sheet/components/coment_post_owner.dart';
import 'package:mpd_client/features/home/presentation/pages/coment_sheet/components/coments.dart';
import 'package:mpd_client/features/home/presentation/pages/home_page.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

class ComentPageModel {
  final Post post;
  final FlickManager? flickManager;
  final int index;
  const ComentPageModel(
      {required this.flickManager, required this.post, required this.index});
}

class ComentPage extends StatelessWidget {
  final Post post;
  final FlickManager? flickManager;
  final int index;
  const ComentPage({
    super.key,
    required this.flickManager,
    required this.post,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    if (context.mounted && flickManager != null) {
      isComentRoute = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.lenth_comment,
          style: Styles.headline4.copyWith(
            color: context.color.black,
          ),
        ),
        toolbarHeight: 60.h,
        titleSpacing: 0,
        elevation: 0,
        iconTheme: IconThemeData(color: context.color.black),
        backgroundColor: context.color.white,
        actions: [
          IconButton(
            onPressed: () {
              Share.share(
                '${post.authorFullname} \n\n${post.text} \n\n${post.media?.first.image} \n\n${post.media?.first.file} \nhttps://play.google.com/store/apps/details?id=com.mpd.mpdclient',
                subject: 'Look what I made!',
              );
            },
            icon: SvgPicture.asset(
              AppIcons.moreIcon,
              colorFilter:
                  ColorFilter.mode(context.color.black, BlendMode.srcIn),
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () => onBackPress(context),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(top: 4.h, bottom: 12.h),
              sliver: SliverToBoxAdapter(
                child: ComentPostOwner(
                  fullname: post.authorFullname ?? "--",
                  job: post.mainCat ?? "--",
                  avatar: post.authorAvatar,
                  onPressed: () {},
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ComentContent(
                media: post.media!,
                flickManager: flickManager,
                flickMultiManager: FlickMultiManager(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 12.h),
              sliver:
                  BlocSelector<MediaControlBloc, MediaControlState, List<Post>>(
                selector: (state) => state.posts,
                builder: (context, posts) {
                  return ComentPostInfo(index: index, post: posts[index]);
                },
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverToBoxAdapter(
                child: post.text != null || post.text!.isNotEmpty
                    ? ReadMoreText(
                        post.text!,
                        style: Styles.postTitle.copyWith(
                          fontFeatures: [],
                          color: context.color.black,
                        ),
                        trimLines: 3,
                        moreStyle: Styles.postTitle
                            .copyWith(color: context.color.mainBlue),
                        lessStyle: Styles.postTitle
                            .copyWith(color: context.color.mainBlue),
                        trimMode: TrimMode.Line,
                        trimCollapsedText: context.l10n.lenth_read_more,
                        trimExpandedText: context.l10n.lenth_show_less,
                      )
                    : const SizedBox(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              sliver: SliverToBoxAdapter(
                child: Coments(post: post),
              ),
            )
          ],
        ),
      ),
      bottomSheet: ComentInput(postId: post.id!, postIndex: index),
    );
  }

  Future<bool> onBackPress(BuildContext context) {
    final isShowSticker = context.read<SendComentBloc>().state.emojiShowing;
    if (isShowSticker) {
      context.read<SendComentBloc>().add(const EmojiShowing(false));
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }
}
