import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/application/post/post_bloc.dart';
import 'package:mpd_client/domain/entity/lenta/post_entity.dart';
import 'package:mpd_client/domain/models/appointment/specialist_info_model.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/w_activity_dot.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/w_post_media.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_bottom_sheet_clipper.dart';
import 'package:mpd_client/presentation/widgets/w_long_button.dart';
import 'package:mpd_client/presentation/widgets/w_network_image.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';
import 'package:share_plus/share_plus.dart';

class PostWidget extends StatefulWidget {
  final PostEntity post;
  final bool isLentaView;
  final bool isMyPost;

  const PostWidget({
    super.key,
    required this.post,
    this.isLentaView = true,
    this.isMyPost = false,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget>
    with AutomaticKeepAliveClientMixin {
  late ValueNotifier<bool> isLike = ValueNotifier(widget.post.isLiked);
  ValueNotifier<bool> isMore = ValueNotifier(false);
  ValueNotifier<int> activeIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        decoration: const BoxDecoration(color: white),
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRouteNames.drProfilebyid, extra: {
                      "specialist": SpecialistInfoModel(
                        id: int.tryParse(widget.post.authorJob.id) ?? 0,
                        username: widget.post.authorUser,
                        avatar: widget.post.authorAvatar,
                        fullname: widget.post.authorFullname,
                        job: widget.post.authorJob.name,
                      ),
                    });
                  },
                  child: Row(
                    children: [
                      WNetworkImage(
                        image: widget.post.authorAvatar,
                        height: 40,
                        width: 40,
                        borderRadius: 12,
                        defaultWidget: Image.asset(
                          AppImages.userAvatar,
                          height: 40,
                          width: 40,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.authorFullname,
                            style: AppTheme.displayLarge,
                          ),
                          Text(
                            widget.post.date.differentCurrentDate,
                            style: AppTheme.labelLarge.copyWith(
                              color: black.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (widget.isMyPost) {
                            final bloc = context.read<PostBloc>();
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => BottomSheetWidget(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 16,
                                ),
                                children: [
                                  const SizedBox(height: 12),
                                  const Text(
                                    "Options",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: black,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  LongButton(
                                    onPress: () {
                                      Share.share(
                                        '${widget.post.authorFullname} \n\n${widget.post.text} \n\n${widget.post.medias.first.image} \n\n${widget.post.medias.first.file} \nhttps://play.google.com/store/apps/details?id=com.mpd.mpdclient',
                                        subject: widget.post.authorFullname,
                                      );
                                    },
                                    widget: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AppIcons.share.svg(), // share,
                                        const SizedBox(width: 12),
                                        const Text(
                                          "Share",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  LongButton(
                                    onPress: () {},
                                    color: white,
                                    border: Border.all(color: mainBlue),
                                    widget: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AppIcons.edit.svg(),
                                        const SizedBox(width: 12),
                                        const Text(
                                          "Edit",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  BlocBuilder<PostBloc, PostState>(
                                    bloc: bloc,
                                    builder: (context, state) {
                                      return LongButton(
                                        color: const Color(0xFFEB5757),
                                        // loading: bloc.state.deleteStatus == PostStatus.inProgress,
                                        onPress: () {
                                          // bloc.add(DeletePostEvent(
                                          //   id: widget.post.id ?? 0,
                                          //   index: widget.baseIndex,
                                          //   onSucces: () {
                                          //     Navigator.pop(context);
                                          //   },
                                          // ));
                                        },
                                        widget: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AppIcons.trash.svg(),
                                            const SizedBox(width: 12),
                                            const Text(
                                              "Delete",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: white,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            );
                          } else {
                            Share.share(
                              '${widget.post.authorFullname} \n\n${widget.post.text} \n\n${widget.post.medias.first.image} \n\n${widget.post.medias.first.file} \nhttps://play.google.com/store/apps/details?id=com.mpd.mpdclient',
                              subject: 'Look what I made!',
                            );
                          }
                        },
                        child: AppIcons.share.svg(color: black),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 450,
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: widget.post.medias.length,
                      onPageChanged: (value) {
                        activeIndex.value = value;
                      },
                      itemBuilder: (context, index) {
                        return WPostMedia(
                          media: widget.post.medias[index],
                        );
                      },
                    ),
                    Align(
                      alignment: const Alignment(0.9, -0.9),
                      child: ValueListenableBuilder(
                        valueListenable: activeIndex,
                        builder:
                            (BuildContext context, int value, Widget? child) {
                          return WActivityDotted(
                            dotCount: widget.post.medias.length,
                            active: value,
                            type: 1,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    WPostButton(
                      onPress: onPressLike,
                      icon: widget.post.isLiked
                          ? AppIcons.liked.svg(
                              color: red,
                            )
                          : AppIcons.unliked.svg(
                              color: grey,
                            ),
                      label: '${widget.post.likesCount} likes',
                      isActive: widget.post.isLiked,
                    ),
                    const SizedBox(width: 8),
                    WPostButton(
                      onPress: onPressGoComment,
                      icon: AppIcons.coment.svg(),
                      label: '${widget.post.commentCount} comment',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ValueListenableBuilder(
                  valueListenable: isMore,
                  builder: (BuildContext context, bool isMore, Widget? child) {
                    return RichText(
                      text: TextSpan(
                        style: AppTheme.labelLarge.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                        children: [
                          TextSpan(
                            text: (widget.post.text).length > 100
                                ? (isMore
                                    ? widget.post.text
                                    : widget.post.text.substring(0, 100))
                                : widget.post.text,
                          ),
                          if ((widget.post.text).length > 100 && !isMore)
                            TextSpan(
                              text: " more",
                              style: AppTheme.bodySmall.copyWith(
                                color: gray,
                                fontWeight: FontWeight.w400,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = onPressMore,
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPressGoComment({String? text}) {
    if (widget.isLentaView) {
      context.pushNamed(AppRouteNames.comment, extra: {
        'post': widget.post,
        'message': text,
      }).then((value) {
        isLike.value = widget.post.isLiked;
      });
    }
  }

  void onPressMore() {
    isMore.value = true;
  }

  void onPressLike() {
    isLike.value = !isLike.value;
    context.read<PostBloc>().add(PostLikeEvent(isLike.value, widget.post.id));
  }

  @override
  bool get wantKeepAlive => true;
}

class WPostButton extends StatelessWidget {
  final void Function() onPress;
  final Widget icon;
  final String label;
  final bool isActive;

  const WPostButton({
    super.key,
    required this.onPress,
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 8),
              Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.labelLarge.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
