import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/extension/context_ext.dart';
import 'package:mpd_client/features/home/domain/inherited/post_inhereted.dart';
import 'package:mpd_client/features/home/domain/service/flick_multi_manger.dart';
import 'package:mpd_client/features/home/presentation/widgets/home_appbar_component.dart';
import 'package:mpd_client/features/home/presentation/widgets/loading_post.dart';
import 'package:mpd_client/features/home/presentation/widgets/post_widget.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/loading/loading_platform.dart';
import 'package:mpd_client/src/widgets/error_type_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../domain/blocs/post/post_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
PersistentBottomSheetController? controller;
bool isComentRoute = false;

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  late FlickMultiManager flickMultiManager;

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(PostFetched());
    _scrollController.addListener(_onScroll);
    flickMultiManager = FlickMultiManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: context.color.white,
      appBar: HomeAppbarComponent(flickMultiManager: flickMultiManager),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.status) {
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
              if (state.posts.isEmpty) {
                return const Center(child: Text('no posts'));
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
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: state.hasReachedMax
                        ? state.posts.length
                        : state.posts.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= state.posts.length) {
                        return Padding(
                          padding: EdgeInsets.only(top: 5.h, bottom: 15.h),
                          child: const Center(child: LoadingPlatform()),
                        );
                      }
                      final post = state.posts[index];
                      PostInheritedNotifier.of(context).notifier!.setPost =
                          post;

                      return PostWidget(
                        post: post,
                        baseIndex: index,
                        flickMultiManager: flickMultiManager,
                      );
                    },
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
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PostBloc>().add(PostFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
