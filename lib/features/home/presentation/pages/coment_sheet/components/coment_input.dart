import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/home/data/models/coment_model.dart';
import 'package:mpd_client/features/home/domain/blocs/media_control/media_control_bloc.dart';
import 'package:mpd_client/features/home/domain/blocs/post_coment/post_coment_bloc.dart';
import 'package:mpd_client/features/home/domain/blocs/send_coment/send_coment_bloc.dart';
import 'package:mpd_client/features/user/domain/blocs/user_info/user_info_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/icon_circle_button.dart';
import 'package:mpd_client/src/widgets/pinned_sheet.dart';

class ComentInput extends StatelessWidget {
  final int postId, postIndex;
  const ComentInput({super.key, required this.postId, required this.postIndex});

  @override
  Widget build(BuildContext context) {
    return PinnedSheet(
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocListener<SendComentBloc, SendComentState>(
            listener: (context, state) {
              if (state is SendComentSuccess) {
                context
                    .read<PostComentBloc>()
                    .add(InsertNewComent(state.coment!, isSuccess: true));
                context
                    .read<MediaControlBloc>()
                    .add(MediaComentCount(postIndex));
              }
            },
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: context.read<SendComentBloc>().comentController,
                    onTap: () => context
                        .read<SendComentBloc>()
                        .add(const EmojiShowing(false)),
                    onChanged: (coment) => context
                        .read<SendComentBloc>()
                        .add(ComentTextChanged(coment)),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                        left: 12.w,
                        top: 12.h,
                        bottom: 12.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: context.l10n.lenth_write_comment,
                      hintStyle: Styles.postTitle
                          .copyWith(fontFamily: Styles.gilroyRegular),
                      fillColor: context.color.fillColor,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                BlocSelector<SendComentBloc, SendComentState, String>(
                  selector: (state) => state.comentText,
                  builder: (context, coment) {
                    return AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child: coment.isNotEmpty
                          ? IconCircleButton(
                              size: const Size(44, 44),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                final userInfo =
                                    context.read<UserInfoBloc>().state.userInfo;
                                final coment = Coment(
                                  id: -1,
                                  text: context
                                      .read<SendComentBloc>()
                                      .comentController
                                      .text,
                                  avatar: userInfo!.avatar,
                                  name: userInfo.name,
                                  lastname: userInfo.lastname,
                                  username: userInfo.username,
                                );
                                context
                                    .read<SendComentBloc>()
                                    .add(SendComment(postId, coment));
                                context.read<PostComentBloc>().add(
                                    InsertNewComent(coment, isSuccess: false));
                              },
                              icon: AppIcons.send,
                              iconColor: context.color.white,
                              color: context.color.mainBlue,
                            )
                              .animate()
                              .fadeIn(
                                  duration: const Duration(milliseconds: 200))
                              .scale(
                                  duration: const Duration(milliseconds: 200))
                          : const SizedBox().animate().fadeOut(
                                duration: const Duration(milliseconds: 150),
                              ),
                    );
                  },
                )
              ],
            ),
          ),
          BlocSelector<SendComentBloc, SendComentState, bool>(
            selector: (state) => state.emojiShowing,
            builder: (context, emojiShowing) {
              if (emojiShowing) FocusScope.of(context).unfocus();
              return AnimatedCrossFade(
                firstChild: const SizedBox(
                  height: 250,
                  // child: EmojiPicker(
                  //   onEmojiSelected: (category, emoji) => context
                  //       .read<SendComentBloc>()
                  //       .add(ComentTextChanged(emoji.emoji)),
                  //   textEditingController:
                  //       context.read<SendComentBloc>().comentController,
                  // ),
                ),
                secondChild: const SizedBox(width: double.maxFinite),
                crossFadeState: emojiShowing
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 400),
              );
            },
          ),
        ],
      ),
    );
  }
}
