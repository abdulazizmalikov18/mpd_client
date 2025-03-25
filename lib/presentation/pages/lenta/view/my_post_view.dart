import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/application/post/post_bloc.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/post_widget.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/w_post_shimmer.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

class MyPostView extends StatefulWidget {
  const MyPostView({super.key});

  @override
  State<MyPostView> createState() => _MyPostViewState();
}

class _MyPostViewState extends State<MyPostView> {
  @override
  void initState() {
    context.read<PostBloc>().add(GetMyPostEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldSecondaryBackground,
      appBar: WAppBar(
        back: true,
        title: Text(
          context.l10n.personal_posts,
          style: AppTheme.headlineSmall.copyWith(fontSize: 22),
        ),
      ),
      body: Expanded(
        child: CustomMaterialIndicator(
          backgroundColor: Colors.transparent,
          // leadingScrollIndicatorVisible: true,

          elevation: 0,
          onRefresh: () async {
            // context.read<PostBloc>().add(const PostFetched());
            // await Future.delayed(const Duration(seconds: 1));
          },
          indicatorBuilder:
              (BuildContext context, IndicatorController controller) {
            return const CupertinoActivityIndicator(
              color: black,
            );
          },
          child: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              // Shimmer is when post coming that show !
              if (state.status.isInProgress) {
                return ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return const WPostShimmer();
                  },
                );
              }
              // Posts Is Empty
              if (state.posts.isEmpty &&
                  (state.status.isFailure || state.status.isSuccess)) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(AppImages.chatNotFound),
                      Text(
                        'Post Not Found',
                        style: AppTheme.bodyLarge.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'The page you are looking\nfor doesn’t exits',
                        textAlign: TextAlign.center,
                        style: AppTheme.bodyLarge.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: gray),
                      ),
                    ],
                  ),
                );
              }

              // Post Viewer
              return PageView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index + 1 == state.posts.length ? 30 : 0,
                    ),
                    child: PostWidget(
                      post: state.myPost[index],
                      isMyPost: true,
                    ),
                  );
                },
                itemCount: state.myPost.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
