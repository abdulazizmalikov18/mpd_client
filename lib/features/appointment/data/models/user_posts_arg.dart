import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';

class UserPostsArg {
  final List<Post> postsUser;
  final int index;
  final String name;
  final String avatar;
  final PostBloc bloc;

  const UserPostsArg({
    required this.postsUser,
    required this.index,
    required this.name,
    required this.avatar,
    required this.bloc,
  });
}
