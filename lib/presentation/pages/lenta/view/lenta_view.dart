import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lottie/lottie.dart';
import 'package:mpd_client/application/post/post_bloc.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/post_widget.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/w_post_shimmer.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
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
      leadingScrollIndicatorVisible: true,
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
            return const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Lottie.asset('assets/anim/no_data_anim.json'),
                  Text('No Posts'),
                ],
              ),
            );
          }

          // Post Viewer
          return PaginatorList(
            itemCount: state.posts.length,
            itemBuilder: (BuildContext context, int index) {
              if (index + 1 == state.posts.length) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: PostWidget(post: state.posts[index]),
                );
              }
              return PostWidget(post: state.posts[index]);
            },
            paginatorStatus: state.refreshStatus,
            fetchMoreFunction: () {
              context.read<PostBloc>().add(const PostMoreFetched());
            },
            hasMoreToFetch: state.hasReachedMax,
          );
        },
      ),
    );
  }
}
