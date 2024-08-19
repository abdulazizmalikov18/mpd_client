part of 'post_bloc.dart';

class PostState extends Equatable {
  const PostState({
    this.status = FormzSubmissionStatus.initial,
    this.refreshStatus = FormzSubmissionStatus.initial,
    this.userPostStatus = FormzSubmissionStatus.initial,
    this.posts = const <PostEntity>[],
    this.myPost = const <PostEntity>[],
    this.postUser = const <PostEntity>[],
    this.hasReachedMax = false,
    this.offset = 0,
    this.myPostoffset = 0,
    this.count = 0,
    this.userPostCount = 0,
    this.myPostCount = 0,
    this.updateLike = '',
  });

  final FormzSubmissionStatus status;
  final FormzSubmissionStatus refreshStatus;
  final FormzSubmissionStatus userPostStatus;
  final List<PostEntity> posts;
  final List<PostEntity> myPost;
  final List<PostEntity> postUser;
  final bool hasReachedMax;
  final int offset;
  final int myPostoffset;
  final int count;
  final int userPostCount;
  final int myPostCount;
  final String updateLike;

  @override
  List<Object> get props => [
        status,
        userPostStatus,
        posts,
        myPost,
        postUser,
        hasReachedMax,
        offset,
        myPostoffset,
        refreshStatus,
        count,
        userPostCount,
        myPostCount,
        updateLike,
      
      ];

  PostState copyWith({
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? refreshStatus,
    FormzSubmissionStatus? userPostStatus,
    List<PostEntity>? posts,
    List<PostEntity>? myPost,
    List<PostEntity>? postUser,
    bool? hasReachedMax,
    int? offset,
    int? myPostoffset,
    int? count,
    int? userPostCount,
    int? myPostCount,
    String? updateLike,
  }) {
    return PostState(
      status: status ?? this.status,
      refreshStatus: refreshStatus ?? this.refreshStatus,
      userPostStatus: userPostStatus ?? this.userPostStatus,
      posts: posts ?? this.posts,
      myPost: myPost ?? this.myPost,
      postUser: postUser ?? this.postUser,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      offset: offset ?? this.offset,
      myPostoffset: myPostoffset ?? this.myPostoffset,
      count: count ?? this.count,
      userPostCount: userPostCount ?? this.userPostCount,
      myPostCount: myPostCount ?? this.myPostCount,
      updateLike: updateLike ?? this.updateLike,
    );
  }
}
