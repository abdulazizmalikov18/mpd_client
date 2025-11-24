import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:mpd_client/core/utils/log_service.dart';

import '../../../data/models/posts_model.dart';
import '../../../data/repositories/home_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this._homeRepository) : super(PostState()) {
    on<PostFetched>(_onPostFetched, transformer: droppable());
    on<DeletePostEvent>(_onDeletePostEvent, transformer: droppable());
    on<MediaLikePressedUser>(_onLikeUnlikePressed);
    on<ReportPostEvent>(_onReportPostEvent);
    on<PostFetchedUser>((event, emit) async {
      if (!event.isMore) {
        emit(state.copyWith(statusUser: PostStatus.inProgress));
      }
      final result = await _homeRepository.getBanners(
        offset: event.isMore ? state.postsUser.length : 0,
        username: event.username,
      );
      if (result.isRight) {
        emit(
          state.copyWith(
            statusUser: PostStatus.success,
            postsUser: event.isMore
                ? [...state.postsUser, ...result.right.results ?? []]
                : result.right.results,
            count: result.right.count,
          ),
        );
      } else {
        emit(state.copyWith(statusUser: PostStatus.failure));
      }
    });
  }

  final HomeRepository _homeRepository;
  final int _limit = 5;

  void _onLikeUnlikePressed(
    MediaLikePressedUser event,
    Emitter<PostState> emit,
  ) {
    final post = state.postsUser[event.index];
    post.isLiked = !post.isLiked!;
    if (post.isLiked!) {
      post.likesCount = post.likesCount! + 1;
    } else {
      post.likesCount = post.likesCount! - 1;
    }
    // state.postsUser[event.index] = post;
    emit(state.copyWith(postsUser: [...state.postsUser]));
  }

  Future<void> _onDeletePostEvent(
    DeletePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(deleteStatus: PostStatus.inProgress));
    final result = await _homeRepository.deletePost(postId: event.id);
    if (result.isRight) {
      List<Post> userPost = List.from(state.postsUser);
      int count = state.count;

      userPost.removeAt(event.index);
      count = count - 1;
      emit(
        state.copyWith(
          postsUser: userPost,
          count: count,
          deleteStatus: PostStatus.success,
        ),
      );
      event.onSucces();
    } else {
      emit(state.copyWith(deleteStatus: PostStatus.failure));
    }
  }

  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.status == PostStatus.initial) {
      Log.e("Nima gap");
      final result = await _homeRepository.getBanners(limit: _limit);
      if (result.isRight) {
        emit(
          state.copyWith(
            status: PostStatus.success,
            posts: result.right.results,
            hasReachedMax:
                (result.right.results?.length ?? 0) < (result.right.count ?? 0),
          ),
        );
      } else {
        emit(state.copyWith(status: PostStatus.failure));
      }
    } else if (!state.hasReachedMax) {
      if (event.isRefresh) emit(state.copyWith(status: PostStatus.initial));
      Log.e("Nima Tuzuk");
      final result = await _homeRepository.getBanners(
        limit: _limit,
        offset: event.isRefresh ? 0 : state.posts.length,
      );
      if (result.isRight) {
        Log.e("Nima Tuzukn 2");
        emit(
          result.right.results!.isEmpty
              ? state.copyWith(hasReachedMax: true)
              : state.copyWith(
                  status: PostStatus.success,
                  posts: event.isRefresh
                      ? [...result.right.results!]
                      : [...state.posts, ...result.right.results!],
                  hasReachedMax: false,
                ),
        );
      } else {
        emit(state.copyWith(status: PostStatus.failure));
      }
    }
  }

  Future<void> _onReportPostEvent(
    ReportPostEvent event,
    Emitter<PostState> emit,
  ) async {
    List<Post>? posts = List.from(state.posts);
    emit(state.copyWith(posts: posts, refresh: !state.refresh));
  }
}
