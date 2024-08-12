part of 'post_bloc.dart';

class PostState extends Equatable {
  const PostState({
    this.status = FormzSubmissionStatus.initial,
    this.refreshStatus = FormzSubmissionStatus.initial,
    this.posts = const <PostEntity>[],
    this.myPost = const <PostEntity>[],
    this.hasReachedMax = false,
    this.offset = 0,
    this.myPostoffset = 0,
    this.count = 0,
    this.myPostCount = 0,
    this.updateLike = '',
  });

  final FormzSubmissionStatus status;
  final FormzSubmissionStatus refreshStatus;
  final List<PostEntity> posts;
  final List<PostEntity> myPost;
  final bool hasReachedMax;
  final int offset;
  final int myPostoffset;
  final int count;
  final int myPostCount;
  final String updateLike;

  @override
  List<Object> get props => [
        status,
        posts,
        myPost,
        hasReachedMax,
        offset,
        myPostoffset,
        refreshStatus,
        count,
        myPostCount,
        updateLike,
      
      ];

  PostState copyWith({
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? refreshStatus,
    List<PostEntity>? posts,
    List<PostEntity>? myPost,
    bool? hasReachedMax,
    int? offset,
    int? myPostoffset,
    int? count,
    int? myPostCount,
    String? updateLike,
  }) {
    return PostState(
      status: status ?? this.status,
      refreshStatus: refreshStatus ?? this.refreshStatus,
      posts: posts ?? this.posts,
      myPost: myPost ?? this.myPost,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      offset: offset ?? this.offset,
      myPostoffset: myPostoffset ?? this.myPostoffset,
      count: count ?? this.count,
      myPostCount: myPostCount ?? this.myPostCount,
      updateLike: updateLike ?? this.updateLike,
    );
  }
}
