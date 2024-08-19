part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {
  const PostFetched();
}

class GetMyPostEvent extends PostEvent {
  
}

class PostMoreFetched extends PostEvent {
  const PostMoreFetched();
}

class PostLikeEvent extends PostEvent {
  final bool isLike;
  final int postId;

  const PostLikeEvent(this.isLike, this.postId);
}

class PostCreateEvent extends PostEvent {
  final CreatePostParam param;
  final void Function() onSuccess;
  final void Function() onError;

  const PostCreateEvent({
    required this.onSuccess,
    required this.onError,
    required this.param,
  });
}

class GetUserPostsEvent extends PostEvent {
  final String username;
  const GetUserPostsEvent(this.username);
}