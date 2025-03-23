part of 'media_control_bloc.dart';

abstract class MediaControlEvent extends Equatable {
  const MediaControlEvent();

  @override
  List<Object> get props => [];
}

class GetFetchedPosts extends MediaControlEvent {
  final List<Post> posts;
  const GetFetchedPosts(this.posts);
}

class PostViewChanged extends MediaControlEvent {
  final int selectedViewIndex;
  const PostViewChanged(this.selectedViewIndex);
}

class VideoControlEvent extends MediaControlEvent {
  final FlickManager? flickManager;
  const VideoControlEvent(this.flickManager);
}

class MediaLikePressed extends MediaControlEvent {
  final int index;
  const MediaLikePressed(this.index);
}

class MediaComentCount extends MediaControlEvent {
  final int index;
  const MediaComentCount(this.index);
}
