import 'package:flutter/cupertino.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:mpd_client/features/chat/presentation/widgets/report_message_dialog.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';
import 'package:mpd_client/features/home/domain/blocs/bloc/user_profile_bloc.dart';
import 'package:mpd_client/features/home/presentation/pages/user_account/user_account_view.dart';
import 'package:share_plus/share_plus.dart';

class PostModalBottomSheet extends StatelessWidget {
  final Post post;
  const PostModalBottomSheet({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: grey,
            ),
          ),
          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                CupertinoListTile(
                  backgroundColor: white,
                  title: Text("Share"),
                  leading: AppIcons.share2.svg(),
                  onTap: () async {
                    await SharePlus.instance.share(
                      ShareParams(
                        text:
                            '${post.authorFullname} \n\n${post.text} \n\n${post.media?.first.image ?? ""} \n\n${post.media?.first.file ?? ""} \nhttps://play.google.com/store/apps/details?id=com.mpd.mpdclient',
                        subject: post.authorFullname ?? "Mpd Client",
                      ),
                    );
                  },
                ),
                CupertinoListTile(
                  backgroundColor: white,
                  title: Text("About this account"),
                  leading: AppIcons.circleUserRound.svg(),
                  onTap: () {
                    final sendComentBloc = context.read<SendComentBloc>();
                    final postComentBloc = context.read<PostComentBloc>();
                    final userInfoBloc = context.read<UserInfoBloc>();
                    final chatBloc = context.read<ChatBloc>();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => UserProfileBloc(
                                locator.get<HomeRepository>(),
                              ),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  PostBloc(locator.get<HomeRepository>()),
                            ),
                            BlocProvider.value(value: sendComentBloc),
                            BlocProvider.value(value: postComentBloc),
                            BlocProvider.value(value: userInfoBloc),
                            BlocProvider.value(value: chatBloc),
                          ],
                          child: UserAccountView(
                            username: post.authorUser ?? "kabulov",
                            name: post.authorFullname ?? "Фарход Кабулов",
                            avatar:
                                post.authorAvatar ??
                                "https://dwed.fra1.digitaloceanspaces.com/SMMS/media/PostMedia/image/a651706c-f6a0-45fe-9d40-46e9fb37271b.jpeg",
                            specialistId:
                                int.tryParse(post.authorJob?.id ?? "0") ?? 0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                CupertinoListTile(
                  backgroundColor: white,
                  title: Text("Report", style: TextStyle(color: red)),
                  leading: AppIcons.messageCircleWarning.svg(color: red),
                  onTap: () async {
                    await ReportMessageDialog.show(
                      context,
                      onReportSubmitted: (reason) async {
                        // Here you can handle the report submission
                        // For example, you can call an API to report the message
                        // await context.read<ChatMessageBloc>().add(ReportMessage(
                        //   messageId: message?.id ?? '',
                        //   reason: reason,
                        // ));

                        // Show confirmation dialog

                        Navigator.pop(context);
                        await ReportConfirmationDialog.show(context);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
