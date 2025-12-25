import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';

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
    on<BlockUserEvent>(_onBlockUserEvent);
    on<PostFetchedUser>((event, emit) async {
      if (!event.isMore) {
        emit(state.copyWith(statusUser: PostStatus.inProgress));
      }
      final result = await _homeRepository.getBanners(
        offset: event.isMore ? state.postsUser.length : 0,
        username: event.username,
      );
      if (result.isRight) {
        final filteredPosts = _filterBlockedUsers(result.right.results);
        emit(
          state.copyWith(
            statusUser: PostStatus.success,
            postsUser: event.isMore
                ? [...state.postsUser, ...(filteredPosts ?? [])]
                : filteredPosts,
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

  // Helper method to filter out blocked users' posts
  List<Post>? _filterBlockedUsers(List<Post>? posts) {
    if (posts == null) return null;
    try {
      final blockedUsersStr = StorageRepository.getString(StorageKeys.BLOCKED_USERS);
      if (blockedUsersStr.isEmpty) return posts;
      final blockedUsers = blockedUsersStr.split(',').toSet();
      return posts.where((post) => 
        post.authorUser == null || !blockedUsers.contains(post.authorUser)
      ).toList();
    } catch (e) {
      Log.e('Error filtering blocked users: $e');
      return posts;
    }
  }

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
        final filteredPosts = _filterBlockedUsers(result.right.results);
        emit(
          state.copyWith(
            status: PostStatus.success,
            posts: filteredPosts,
            hasReachedMax:
                (filteredPosts?.length ?? 0) >=
                (result.right.count ?? 0),
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
        final filteredPosts = _filterBlockedUsers(result.right.results);
        emit(
          (filteredPosts?.isEmpty ?? true)
              ? state.copyWith(hasReachedMax: true)
              : state.copyWith(
                  status: PostStatus.success,
                  posts: event.isRefresh
                      ? filteredPosts!
                      : [...state.posts, ...filteredPosts!],
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
    final postId = int.tryParse(event.postId);
    if (postId == null) {
      event.onError?.call('Invalid post ID');
      return;
    }

    final result = await _homeRepository.reportPost(
      postId: postId,
      reason: event.reason,
    );

    if (result.isRight) {
      // Save reported post id to storage so it will be hidden on next builds
      try {
        final current = StorageRepository.getString(
          StorageKeys.REPORTED_POSTS,
        );
        final reported = current.isEmpty
            ? <String>{}
            : current.split(',').toSet();
        reported.add(event.postId);
        await StorageRepository.putString(
          StorageKeys.REPORTED_POSTS,
          reported.where((e) => e.isNotEmpty).join(','),
        );
      } catch (e) {
        Log.e('Error saving reported post: $e');
      }

      // Remove reported post from current state immediately
      final posts = state.posts.where((p) => p.id?.toString() != event.postId).toList();
      emit(state.copyWith(posts: posts, refresh: !state.refresh));
      event.onSuccess?.call();
    } else {
      event.onError?.call(result.left.message.isNotEmpty 
          ? result.left.message 
          : 'Failed to report post');
    }
  }

  Future<void> _onBlockUserEvent(
    BlockUserEvent event,
    Emitter<PostState> emit,
  ) async {
    final result = await _homeRepository.blockUser(username: event.username);

    if (result.isRight) {
      // Save blocked user to storage
      try {
        final current = StorageRepository.getString(StorageKeys.BLOCKED_USERS);
        final blocked = current.isEmpty
            ? <String>{}
            : current.split(',').toSet();
        blocked.add(event.username);
        await StorageRepository.putString(
          StorageKeys.BLOCKED_USERS,
          blocked.where((e) => e.isNotEmpty).join(','),
        );
      } catch (e) {
        Log.e('Error saving blocked user: $e');
      }

      // Remove blocked user's posts from current state immediately
      final posts = state.posts.where((p) => p.authorUser != event.username).toList();
      final userPosts = state.postsUser.where((p) => p.authorUser != event.username).toList();
      emit(state.copyWith(
        posts: posts,
        postsUser: userPosts,
        refresh: !state.refresh,
      ));
      event.onSuccess?.call();
    } else {
      event.onError?.call(result.left.message.isNotEmpty 
          ? result.left.message 
          : 'Failed to block user');
    }
  }
}
