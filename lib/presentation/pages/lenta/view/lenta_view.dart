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
import 'package:mpd_client/presentation/widgets/w_paginator.dart';

class LentaView extends StatefulWidget {
  const LentaView({super.key});

  @override
  State<LentaView> createState() => _LentaViewState();
}

class _LentaViewState extends State<LentaView> {
  @override
  void initState() {
    context.read<PostBloc>().add(const PostFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      backgroundColor: Colors.transparent,
      // leadingScrollIndicatorVisible: true,

      elevation: 0,
      onRefresh: () async {
        context.read<PostBloc>().add(const PostFetched());
        await Future.delayed(const Duration(seconds: 1));
      },
      indicatorBuilder: (BuildContext context, IndicatorController controller) {
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
          if (state.posts.isEmpty && (state.status.isFailure || state.status.isSuccess)) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImages.chatNotFound,
                ),
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
                    color: gray
                  ),
                ),
              ],
            ),
          );
          }

          // Post Viewer
          return PaginatorList(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.posts.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(bottom: index + 1 == state.posts.length ? 30 : 0),
                child: PostWidget(post: state.posts[index]),
              );
            },
            paginatorStatus: state.refreshStatus,
            fetchMoreFunction: () {
              context.read<PostBloc>().add(const PostMoreFetched());
            },
            hasMoreToFetch: state.count != state.posts.length,
          );
        },
      ),
    );
  }
}
