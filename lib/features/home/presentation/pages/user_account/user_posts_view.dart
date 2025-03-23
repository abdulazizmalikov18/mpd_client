import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';
import 'package:mpd_client/features/home/presentation/widgets/swipe_indicator.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/appbar_widget.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

class UserPostsView extends StatefulWidget {
  const UserPostsView({
    super.key,
    required this.postsUser,
    required this.index,
    required this.name,
    required this.avatar,
  });
  final List<Post> postsUser;
  final int index;
  final String name;
  final String avatar;

  @override
  State<UserPostsView> createState() => _UserPostsViewState();
}

class _UserPostsViewState extends State<UserPostsView> {
  late final PageController controller;
  @override
  void initState() {
    controller = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.name,
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: controller,
        scrollDirection: Axis.vertical,
        itemCount: widget.postsUser.length,
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ColoredBox(
              color: context.color.white,
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 16),
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(widget.avatar),
                  onBackgroundImageError: (exception, stackTrace) =>
                      const DefaultAvatar(
                    containerSize: 24,
                    imageSize: 28,
                  ),
                ),
                title: Text(widget.name),
                trailing: IconButton(
                  onPressed: () async {
                    Share.share(
                      '${widget.postsUser[index].authorFullname} \n\n${widget.postsUser[index].text} \n\n${widget.postsUser[index].media?.first.image ?? ""} \n\n${widget.postsUser[index].media?.first.file ?? ""} \nhttps://play.google.com/store/apps/details?id=com.mpd.mpdclient',
                      subject: 'Look what I made!',
                    );
                  },
                  icon: AppIcons.moreIcon.svg(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .6,
              width: double.infinity,
              child: widget.postsUser[index].media != null
                  ? UserPostIteam(media: widget.postsUser[index].media!)
                  : const SizedBox(),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    widget.postsUser[index].isLiked ?? false
                        ? AppIcons.liked
                        : AppIcons.unliked,
                    height: 20.h,
                    colorFilter: widget.postsUser[index].isLiked ?? false
                        ? ColorFilter.mode(context.color.red, BlendMode.srcIn)
                        : ColorFilter.mode(context.color.grey, BlendMode.srcIn),
                  ),
                ),
                Text(
                  '${widget.postsUser[index].likesCount} ${context.l10n.lenth_likes}',
                  style: Styles.postTitle.copyWith(
                      color: context.color.grey,
                      fontFamily: Styles.gilroyRegular),
                ),
                IconButton(
                  onPressed: () {},
                  icon: AppIcons.coment.svg(),
                ),
                Text(
                  '${widget.postsUser[index].commentCount} ${context.l10n.lenth_comment.toLowerCase()}',
                  style: Styles.postTitle.copyWith(
                    color: context.color.grey,
                    fontFamily: Styles.gilroyRegular,
                  ),
                ),
              ],
            ),
            if (widget.postsUser[index].text == null ||
                widget.postsUser[index].text!.isEmpty)
              ScreenUtil().setVerticalSpacing(10.h),
            if (widget.postsUser[index].text != null &&
                widget.postsUser[index].text!.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: ReadMoreText(
                  widget.postsUser[index].text!,
                  style: Styles.postTitle.copyWith(
                    fontFeatures: [],
                    color: context.color.black,
                  ),
                  trimLines: 3,
                  moreStyle:
                      Styles.postTitle.copyWith(color: context.color.mainBlue),
                  lessStyle:
                      Styles.postTitle.copyWith(color: context.color.mainBlue),
                  trimMode: TrimMode.Line,
                  trimCollapsedText: context.l10n.lenth_read_more,
                  trimExpandedText: context.l10n.lenth_show_less,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class UserPostIteam extends StatefulWidget {
  const UserPostIteam({
    super.key,
    required this.media,
  });

  final List<Media> media;

  @override
  State<UserPostIteam> createState() => _UserPostIteamState();
}

class _UserPostIteamState extends State<UserPostIteam> {
  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: widget.media.length,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) {
            valueNotifier.value = value;
          },
          itemBuilder: (context, index) => CachedNetworkImage(
            imageUrl: Utils.imageMedieaType(
              widget.media[index],
            ),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 10.h,
          right: 0,
          left: 0,
          child: ValueListenableBuilder(
            valueListenable: valueNotifier,
            builder: (context, value, __) {
              return SwipeIndicator(
                current: value,
                length: widget.media.length,
              );
            },
          ),
        ),
        Positioned(
          top: 12.h,
          right: 12.w,
          child: widget.media.length != 1
              ? ValueListenableBuilder(
                  valueListenable: valueNotifier,
                  builder: (context, value, __) {
                    return Text(
                      '${value + 1}/${widget.media.length}',
                      style: Styles.semiboldTitle.copyWith(
                        color: context.color.white,
                        fontFamily: Styles.gilroyRegular,
                      ),
                    );
                  },
                )
              : const SizedBox(),
        )
      ],
    );
  }
}
