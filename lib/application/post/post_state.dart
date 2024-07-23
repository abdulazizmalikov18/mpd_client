part of 'post_bloc.dart';

class PostState extends Equatable {
  const PostState({
    this.status = FormzSubmissionStatus.initial,
    this.refreshStatus = FormzSubmissionStatus.initial,
    this.posts = const <PostEntity>[],
    this.hasReachedMax = false,
    this.offset = 0,
    this.count = 0,
    this.updateLike = '',
  });

  final FormzSubmissionStatus status;
  final FormzSubmissionStatus refreshStatus;
  final List<PostEntity> posts;
  final bool hasReachedMax;
  final int offset;
  final int count;
  final String updateLike;

  @override
  List<Object> get props => [
        status,
        posts,
        hasReachedMax,
        offset,
        refreshStatus,
        count,
        updateLike,
      ];

  PostState copyWith({
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? refreshStatus,
    List<PostEntity>? posts,
    bool? hasReachedMax,
    int? offset,
    int? count,
    String? updateLike,
  }) {
    return PostState(
      status: status ?? this.status,
      refreshStatus: refreshStatus ?? this.refreshStatus,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      offset: offset ?? this.offset,
      count: count ?? this.count,
      updateLike: updateLike ?? this.updateLike,
    );
  }
}
