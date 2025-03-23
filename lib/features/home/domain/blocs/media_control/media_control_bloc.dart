import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:mpd_client/features/home/domain/blocs/post/post_bloc.dart';

import '../../../data/models/posts_model.dart';

part 'media_control_event.dart';
part 'media_control_state.dart';

class MediaControlBloc extends Bloc<MediaControlEvent, MediaControlState> {
  MediaControlBloc(this._postBloc)
      : super(_postBloc.state.status == PostStatus.success
            ? MediaControlState(posts: _postBloc.state.posts)
            : MediaControlState()) {
    postSubscription = _postBloc.stream.listen((state) {
      if (state.status == PostStatus.success) add(GetFetchedPosts(state.posts));
    });
    on<GetFetchedPosts>(_onGetFetchedPosts);
    on<PostViewChanged>(_onPostViewChanged);
    on<VideoControlEvent>(_onVideoControl);
    on<MediaLikePressed>(_onLikeUnlikePressed);
    on<MediaComentCount>(_onComentAdded);
  }

  final PostBloc _postBloc;
  late StreamSubscription postSubscription;

  void _onVideoControl(VideoControlEvent event, Emitter<MediaControlState> emit) {
    emit(state.copyWith(flickManager: event.flickManager));
  }

  void _onGetFetchedPosts(GetFetchedPosts event, Emitter<MediaControlState> emit) {
    emit(state.copyWith(posts: event.posts));
  }

  void _onPostViewChanged(PostViewChanged event, Emitter<MediaControlState> emit) {
    emit(state.copyWith(postViewIndex: event.selectedViewIndex));
  }

  void _onComentAdded(MediaComentCount event, Emitter<MediaControlState> emit) {
    final post = state.posts[event.index];
    post.commentCount = post.commentCount! + 1;
    emit(state.copyWith(posts: [...state.posts]));
  }

  void _onLikeUnlikePressed(MediaLikePressed event, Emitter<MediaControlState> emit) {
    final post = state.posts[event.index];
    post.isLiked = !post.isLiked!;
    if (post.isLiked!) {
      post.likesCount = post.likesCount! + 1;
    } else {
      post.likesCount = post.likesCount! - 1;
    }

    emit(state.copyWith(posts: [...state.posts]));
  }
}
