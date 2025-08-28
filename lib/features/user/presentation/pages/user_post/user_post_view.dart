import 'package:cached_network_image/cached_network_image.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/pagination/presentation/paginator.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/components/no_appointment.dart';
import 'package:mpd_client/features/home/domain/service/flick_multi_manger.dart';
import 'package:mpd_client/features/home/presentation/pages/home_page.dart';
import 'package:mpd_client/features/home/presentation/widgets/loading_post.dart';
import 'package:mpd_client/src/widgets/error_type_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class UserPostView extends StatefulWidget {
  final String username;
  final String avatar;
  const UserPostView({super.key, required this.username, required this.avatar});

  @override
  State<UserPostView> createState() => _UserPostViewState();
}

class _UserPostViewState extends State<UserPostView> {
  late FlickMultiManager flickMultiManager;
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(PostFetchedUser(username: widget.username));
    flickMultiManager = FlickMultiManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.personalPosts)),
      body: BlocBuilder<PostBloc, PostState>(
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
                    context.read<PostBloc>().add(PostFetched(true));
                  },
                ),
              );
            case PostStatus.success:
              if (state.postsUser.isEmpty) {
                return NoAppointment(
                  title: context.l10n.no_posts,
                  subtitle: context.l10n.no_posts,
                  buttonName: context.l10n.refresh,
                  onPressed: () {
                    context.read<PostBloc>().add(
                      PostFetchedUser(username: widget.username),
                    );
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
                  child: Paginator(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewPadding.bottom,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: 3 / 4,
                    ),
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemCount: state.postsUser.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.postUserInfo,
                          arguments: {
                            'index': index,
                            'username': widget.username,
                            'avatar': widget.avatar,
                          },
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            (state.postsUser[index].media?.isNotEmpty ?? false)
                            ? (state.postsUser[index].media?.first.image ??
                                      state
                                          .postsUser[index]
                                          .media
                                          ?.first
                                          .screenshot) ??
                                  "https://avatars.mds.yandex.net/i?id=e002a4f0a9bf62b531dc38e481d078dcb0ff2ed3-4011696-images-thumbs&n=13"
                            : "https://avatars.mds.yandex.net/i?id=e002a4f0a9bf62b531dc38e481d078dcb0ff2ed3-4011696-images-thumbs&n=13",
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    paginatorStatus: FormzSubmissionStatus.success,
                    fetchMoreFunction: () {
                      context.read<PostBloc>().add(
                        PostFetchedUser(
                          username: widget.username,
                          isMore: true,
                        ),
                      );
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
              return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
