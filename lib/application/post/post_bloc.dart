import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/domain/abstract_repo/lenta_repository.dart';
import 'package:mpd_client/domain/entity/generic_entity.dart';
import 'package:mpd_client/domain/entity/lenta/create_post_param.dart';
import 'package:mpd_client/domain/entity/lenta/post_entity.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this._repo) : super(const PostState()) {
    on<PostFetched>(_onPostFetched);
    on<PostMoreFetched>(_onPostMoreFetched);
    on<PostLikeEvent>(_onLikePost);
    on<PostCreateEvent>(_onCreatePost);
  }

  final LentaRepository _repo;

  Future<void> _onPostFetched(PostFetched event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await _repo.getBanners(const GenericEntity(limit: 4, offset: 0));
    if (result.isRight) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          posts: result.right.results,
          hasReachedMax: result.right.nextOffset != null,
          offset: result.right.nextOffset,
          count: result.right.count,
        ),
      );
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.failure));
  }

  Future<void> _onPostMoreFetched(PostMoreFetched event, Emitter<PostState> emit) async {
    if (!state.hasReachedMax) return;
    final result = await _repo.getBanners(GenericEntity(limit: 4, offset: state.offset));
    if (result.isRight) {
      await Future.delayed(const Duration(seconds: 2));
      emit(
        state.copyWith(
          refreshStatus: FormzSubmissionStatus.success,
          posts: [...state.posts, ...result.right.results],
          hasReachedMax: result.right.nextOffset != null,
          offset: result.right.nextOffset,
          count: result.right.count,
        ),
      );
      return;
    }
    emit(state.copyWith(refreshStatus: FormzSubmissionStatus.failure));
  }

  void _onLikePost(PostLikeEvent event, Emitter emit) async {
    for (int i = 0; i < state.posts.length; i++) {
      if (state.posts[i].id == event.postId) {
        state.posts[i] = state.posts[i].copyWith(
          likesCount: !state.posts[i].isLiked ? state.posts[i].likesCount + 1 : state.posts[i].likesCount - 1,
          isLiked: !state.posts[i].isLiked,
        );
        break;
      }
    }
    emit(state.copyWith(
      posts: [...state.posts],
      updateLike: '${Random().nextInt(1000)}',
    ));

    await _repo.sendLikeOrUnlike(postId: event.postId);
  }

  void _onCreatePost(PostCreateEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await _repo.createPost(event.param);
    if (result.isRight) {
      emit(state.copyWith(status: FormzSubmissionStatus.success, posts: [result.right, ...state.posts]));
      event.onSuccess();
      return;
    }
    event.onError();
    emit(state.copyWith(status: FormzSubmissionStatus.failure));
  }
}
