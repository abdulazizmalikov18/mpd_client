import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/extension/context_ext.dart';
import 'package:mpd_client/core/presentation/paginator_pageview.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/components/no_appointment.dart';
import 'package:mpd_client/features/home/domain/inherited/post_inhereted.dart';
import 'package:mpd_client/features/home/domain/service/flick_multi_manger.dart';
import 'package:mpd_client/features/home/presentation/pages/home_page.dart';
import 'package:mpd_client/features/home/presentation/widgets/loading_post.dart';
import 'package:mpd_client/features/home/presentation/widgets/post_widget_user.dart';
import 'package:mpd_client/src/widgets/error_type_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class UserPostInfoView extends StatefulWidget {
  final String username;
  final String avatar;
  final int index;
  const UserPostInfoView({
    super.key,
    required this.username,
    required this.avatar,
    required this.index,
  });

  @override
  State<UserPostInfoView> createState() => _UserPostInfoViewState();
}

class _UserPostInfoViewState extends State<UserPostInfoView> {
  late FlickMultiManager flickMultiManager;
  late final PageController controller;
  @override
  void initState() {
    controller = PageController(initialPage: widget.index);
    super.initState();
    flickMultiManager = FlickMultiManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: SafeArea(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            switch (state.statusUser) {
              case PostStatus.failure:
                return Center(
                  child: ErrorTypeWidget(
                    errorIcon: AppIcons.serverError,
                    errorSubtitle: context.l10n.error_internal_server_subtitle,
                    errorTitle: context.l10n.error_internal_server_title,
                    hasReturnButton: false,
                    tryAgainPressed: () {
                      context.read<PostBloc>().add(
                            PostFetched(true),
                          );
                    },
                  ),
                );
              case PostStatus.success:
                if (state.postsUser.isEmpty) {
                  return NoAppointment(
                    title: "No Posts",
                    subtitle: "No Posts",
                    buttonName: "Refresh",
                    onPressed: () {
                      context
                          .read<PostBloc>()
                          .add(PostFetchedUser(username: widget.username));
                    },
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<PostBloc>().add(PostFetched(true));
                    flickMultiManager.clearAll();
                    return Future<void>.delayed(const Duration(seconds: 1));
                  },
                  child: VisibilityDetector(
                    key: ObjectKey(flickMultiManager),
                    onVisibilityChanged: (visibility) {
                      if (visibility.visibleFraction == 0 &&
                          mounted &&
                          !isComentRoute) {
                        flickMultiManager.pause();
                      }
                    },
                    child: PaginatorPageview(
                      controller: controller,
                      itemCount: state.postsUser.length,
                      itemBuilder: (BuildContext context, int index) {
                        final post = state.postsUser[index];
                        PostInheritedNotifier.of(context).notifier!.setPost =
                            post;
                        return PostWidgetUser(
                          post: post,
                          baseIndex: index,
                          flickMultiManager: flickMultiManager,
                          isMyPost: true,
                          avatra: widget.avatar,
                        );
                      },
                      paginatorStatus: FormzSubmissionStatus.success,
                      fetchMoreFunction: () {
                        context.read<PostBloc>().add(PostFetchedUser(
                              username: widget.username,
                              isMore: true,
                            ));
                      },
                      hasMoreToFetch: state.count > state.postsUser.length,
                    ),
                  ),
                );
              case PostStatus.initial:
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) => const LoadingPost(),
                );
              case PostStatus.inProgress:
                return const Center(
                    child: CircularProgressIndicator.adaptive());
            }
          },
        ),
      ),
    );
  }
}
