part of 'media_control_bloc.dart';

class MediaControlState {
  List<Post> posts;
  final int postViewIndex;
  final FlickManager? flickManager;
  MediaControlState(
      {this.posts = const <Post>[], this.postViewIndex = 0, this.flickManager});

  MediaControlState copyWith(
      {List<Post>? posts, int? postViewIndex, FlickManager? flickManager}) {
    return MediaControlState(
        posts: posts ?? this.posts,
        postViewIndex: postViewIndex ?? this.postViewIndex,
        flickManager: flickManager ?? this.flickManager);
  }
}
