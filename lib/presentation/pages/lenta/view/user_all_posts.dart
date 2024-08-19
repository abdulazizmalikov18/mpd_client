import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/application/post/post_bloc.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/components/no_appointment.dart';
import 'package:mpd_client/presentation/pages/lenta/view/user_posts_view.dart';
import 'package:mpd_client/presentation/widgets/cached_image_widget.dart';
import 'package:mpd_client/presentation/widgets/w_pagination.dart';
import 'package:mpd_client/presentation/widgets/w_shimmer.dart';
import 'package:mpd_client/utils/utils.dart';

class UserAllPosts extends StatelessWidget {
  const UserAllPosts({
    super.key,
    required this.username,
    required this.name,
    required this.avatar,
  });
  final String username;
  final String avatar;
  final String name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state.userPostStatus.isInProgress) {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: 20,
            itemBuilder: (context, index) => const WShimmer(width: 118, height: 21),
          );
        } else if (state.userPostStatus.isSuccess) {
          if (state.postUser.isNotEmpty) {
            return Paginator(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: state.postUser.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserPostsView(
                      postsUser: state.postUser,
                      index: index,
                      name: name,
                      avatar: avatar,
                    ),
                  ));
                },
                child: CachedImageWidget(
                  url: Utils.imageMediea(state.postUser[index].medias),
                  size: 20,
                ),
              ),
              paginatorStatus: FormzSubmissionStatus.success,
              fetchMoreFunction: () {
                // context.read<PostBloc>().add(PostFetchedUser(
                //       username: username,
                //       isMore: true,
                //     ));
              },
              hasMoreToFetch: state.count > state.postUser.length,
            );
          }
          return NoAppointment(
            title: "No Posts",
            subtitle: "No Posts",
            buttonName: "Refresh",
            onPressed: () {
              // context.read<PostBloc>().add(PostFetchedUser(username: username));
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
