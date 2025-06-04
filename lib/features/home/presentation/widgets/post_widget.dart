import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';
import 'package:mpd_client/features/home/domain/blocs/bloc/user_profile_bloc.dart';
import 'package:mpd_client/features/home/domain/service/flick_multi_manger.dart';
import 'package:mpd_client/features/home/presentation/pages/coment_sheet/components/coment_input.dart';
import 'package:mpd_client/features/home/presentation/pages/coment_sheet/components/coments.dart';
import 'package:mpd_client/features/home/presentation/pages/user_account/user_account_view.dart';
import 'package:mpd_client/features/home/presentation/widgets/animated_like.dart';
import 'package:mpd_client/features/home/presentation/pages/coment_sheet/components/coment.dart';
import 'package:mpd_client/features/home/presentation/widgets/post_media.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/cached_image_widget.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final int baseIndex;
  final FlickMultiManager flickMultiManager;

  const PostWidget(
      {super.key,
      required this.post,
      required this.baseIndex,
      required this.flickMultiManager});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.only(top: 12.h),
      decoration: BoxDecoration(
        color: context.color.white,
        boxShadow: [
          BoxShadow(color: context.color.cardShadow, blurRadius: 20.r)
        ],
      ),
      child: PostBody(
        post: widget.post,
        baseIndex: widget.baseIndex,
        flickMultiManager: widget.flickMultiManager,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PostBody extends StatefulWidget {
  final Post post;
  final int baseIndex;
  final FlickMultiManager flickMultiManager;

  const PostBody({
    super.key,
    required this.post,
    required this.baseIndex,
    required this.flickMultiManager,
  });

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ScreenUtil().setHorizontalSpacing(12.w),
            Expanded(
              child: BlocBuilder<UserInfoBloc, UserInfoState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      if (state.userInfo?.username == widget.post.authorUser) {
                        Navigator.of(context).pushNamed(
                          AppRoutes.postUser,
                          arguments: state.userInfo?.username ?? "",
                        );
                      } else {
                        final sendComentBloc = context.read<SendComentBloc>();
                        final postComentBloc = context.read<PostComentBloc>();
                        final userInfoBloc = context.read<UserInfoBloc>();
                        final chatBloc = context.read<ChatBloc>();

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => UserProfileBloc(
                                  locator.get<HomeRepository>(),
                                ),
                              ),
                              BlocProvider(
                                create: (context) => PostBloc(
                                  locator.get<HomeRepository>(),
                                ),
                              ),
                              BlocProvider.value(value: sendComentBloc),
                              BlocProvider.value(value: postComentBloc),
                              BlocProvider.value(value: userInfoBloc),
                              BlocProvider.value(value: chatBloc),
                            ],
                            child: UserAccountView(
                              username: widget.post.authorUser ?? "kabulov",
                              name: widget.post.authorFullname ??
                                  "Фарход Кабулов",
                              avatar: widget.post.authorAvatar ??
                                  "https://dwed.fra1.digitaloceanspaces.com/SMMS/media/PostMedia/image/a651706c-f6a0-45fe-9d40-46e9fb37271b.jpeg",
                              specialistId: int.tryParse(
                                      widget.post.authorJob?.id ?? "0") ??
                                  0,
                            ),
                          ),
                        ));
                      }
                    },
                    child: Row(
                      children: [
                        Builder(builder: (context) {
                          debugPrint(
                              "========>>>>>>> ${widget.post.authorAvatar}");
                          return widget.post.authorAvatar!.isNotEmpty
                              ? CachedImageWidget(
                                  url: widget.post.authorAvatar ??
                                      "https://dwed.fra1.digitaloceanspaces.com/SMMS/media/PostMedia/image/a651706c-f6a0-45fe-9d40-46e9fb37271b.jpeg",
                                  size: 48,
                                )
                              : const DefaultAvatar(
                                  containerSize: 48,
                                  imageSize: 36,
                                );
                        }),
                        ScreenUtil().setHorizontalSpacing(8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.authorFullname ?? "--",
                              style: Styles.postTitle
                                  .copyWith(color: context.color.black),
                            ),
                            // Text(
                            //   widget.post.authorJob ?? "--",
                            //   style: Styles.postSubtitle
                            //       .copyWith(color: context.color.black),
                            // ),
                            Text(
                              Utils.formatPostDate(widget.post.date!, context),
                              overflow: TextOverflow.ellipsis,
                              style: Styles.postTitle.copyWith(
                                  color: context.color.grey,
                                  fontFamily: Styles.gilroyRegular),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: IconButton(
                  onPressed: () async {
                    await SharePlus.instance.share(ShareParams(
                      text:
                          '${widget.post.authorFullname} \n\n${widget.post.text} \n\n${widget.post.media?.first.image ?? ""} \n\n${widget.post.media?.first.file ?? ""} \nhttps://play.google.com/store/apps/details?id=com.mpd.mpdclient',
                      subject: widget.post.authorFullname ?? "Mpd Client",
                    ));
                  },
                  // constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    AppIcons.share,
                    height: 24.h,
                    width: 24.h,
                    colorFilter:
                        ColorFilter.mode(context.color.black, BlendMode.srcIn),
                  ),
                ),
              ),
            )
          ],
        ),
        ScreenUtil().setVerticalSpacing(8.h),
        BlocSelector<MediaControlBloc, MediaControlState, List<Post>>(
          selector: (state) => state.posts,
          builder: (context, state) {
            return PostMedia(
              flickMultiManager: widget.flickMultiManager,
              postMedias: widget.post.media,
              baseIndex: widget.baseIndex,
              post: state[widget.baseIndex],
            );
          },
        ),
        ScreenUtil().setVerticalSpacing(12.h),
        Row(
          children: [
            ScreenUtil().setHorizontalSpacing(12.w),
            BlocSelector<MediaControlBloc, MediaControlState, List<Post>>(
              selector: (state) => state.posts,
              builder: (context, posts) {
                final post = posts[widget.baseIndex];
                return Like(
                  baseIndex: widget.baseIndex,
                  likeCount: post.likesCount,
                  isLiked: post.isLiked!,
                  postId: post.id!,
                );
              },
            ),
            ScreenUtil().setHorizontalSpacing(10.w),
            BlocSelector<MediaControlBloc, MediaControlState, List<Post>>(
              selector: (state) => state.posts,
              builder: (context, posts) {
                return ComentWidget(
                  comentCount: posts[widget.baseIndex].commentCount,
                  onPressed: () async {
                    final sendComentBloc = context.read<SendComentBloc>();
                    final postComentBloc = context.read<PostComentBloc>();
                    final userInfoBloc = context.read<UserInfoBloc>();
                    final mediaControlBloc = context.read<MediaControlBloc>();
                    showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Container(
                        height: MediaQuery.sizeOf(context).height * 0.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: context.color.white,
                        ),
                        padding: EdgeInsets.all(16),
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider.value(value: sendComentBloc),
                            BlocProvider.value(value: postComentBloc),
                            BlocProvider.value(value: userInfoBloc),
                            BlocProvider.value(value: mediaControlBloc),
                          ],
                          child: Column(
                            children: [
                              Container(
                                width: 60.w,
                                height: 2.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: context.color.grey,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Expanded(child: Coments(post: widget.post)),
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom >
                                          0
                                      ? MediaQuery.of(context).viewInsets.bottom
                                      : 32.h,
                                  top: 8,
                                ),
                                child: ComentInput(
                                  postId: widget.post.id!,
                                  postIndex: widget.baseIndex,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const Spacer(),
            ScreenUtil().setHorizontalSpacing(12.w)
          ],
        ),
        if (widget.post.text == null || widget.post.text!.isEmpty)
          ScreenUtil().setVerticalSpacing(10.h),
        if (widget.post.text != null && widget.post.text!.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: ReadMoreText(
              widget.post.text!,
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/*     callback: ((val) {
                    !val
                        ? showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (_) => BottomSheetWidget(children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 32.h,
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          dense: true,
                                          contentPadding: EdgeInsets.zero,
                                          style: ListTileStyle.drawer,
                                          onTap: () {},
                                          trailing: SvgPicture.asset(
                                            AppIcons.moreIcon,
                                            height: 24.h,
                                            width: 24.h,
                                            color: context.color.black,
                                          ),
                                          visualDensity: const VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          horizontalTitleGap: 8.w,
                                          leading: Container(
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: Image.asset(
                                              AppImages.doctor,
                                              height: 32.h,
                                              width: 32.h,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          title: Text(
                                            'Marvin McKinney',
                                            style: Styles.postTitle
                                                .copyWith(color: context.color.black),
                                          ),
                                          subtitle: Text(
                                            'Nephrologist',
                                            style: Styles.postSubtitle
                                                .copyWith(color: context.color.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]))
                        : null;
                  }), */
