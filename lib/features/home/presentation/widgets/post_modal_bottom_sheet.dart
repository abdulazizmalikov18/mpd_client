import 'package:flutter/cupertino.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/core/utils/log_service.dart';
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
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
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
                  title: const Text("Share"),
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
                  title: const Text("About this account"),
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
                  title: const Text("Report", style: TextStyle(color: red)),
                  leading: AppIcons.messageCircleWarning.svg(color: red),
                  onTap: () async {
                    await ReportMessageDialog.show(
                      context,
                      onReportSubmitted: (reason) async {
                        if (context.mounted) {
                          try {
                            final postBloc = context.read<PostBloc>();
                            postBloc.add(
                              ReportPostEvent(
                                postId: post.id?.toString() ?? '',
                                reason: reason,
                                onSuccess: () {
                                  Navigator.pop(context);
                                  ReportConfirmationDialog.show(context);
                                },
                                onError: (error) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $error')),
                                  );
                                },
                              ),
                            );
                          } catch (e) {
                            Log.e(e);
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to report post'),
                                ),
                              );
                            }
                          }
                        }
                      },
                    );
                  },
                ),
                if (post.authorUser != null)
                  CupertinoListTile(
                    backgroundColor: white,
                    title: const Text("Block User", style: TextStyle(color: red)),
                    leading: AppIcons.userMinus.svg(color: red),
                    onTap: () async {
                      Navigator.pop(context);
                      final shouldBlock = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Block User'),
                          content: Text(
                            'Are you sure you want to block ${post.authorFullname ?? post.authorUser}? You will no longer see their posts or messages.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: TextButton.styleFrom(
                                foregroundColor: red,
                              ),
                              child: const Text('Block'),
                            ),
                          ],
                        ),
                      );

                      if (shouldBlock == true && context.mounted) {
                        try {
                          final postBloc = context.read<PostBloc>();
                          postBloc.add(
                            BlockUserEvent(
                              username: post.authorUser!,
                              onSuccess: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('User blocked successfully'),
                                  ),
                                );
                              },
                              onError: (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $error')),
                                );
                              },
                            ),
                          );
                        } catch (e) {
                          Log.e(e);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to block user'),
                              ),
                            );
                          }
                        }
                      }
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
