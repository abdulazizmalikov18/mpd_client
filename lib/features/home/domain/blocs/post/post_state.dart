// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

enum PostStatus { initial, success, failure, inProgress }

class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = true,
    this.postsUser = const [],
    this.statusUser = PostStatus.initial,
    this.deleteStatus = PostStatus.initial,
    this.count = 0,
    this.refresh = false,
  });

  final PostStatus status;
  final List<Post> posts;
  final List<Post> postsUser;
  final PostStatus statusUser;
  final PostStatus deleteStatus;
  final int count;
  final bool hasReachedMax;
  final bool refresh;

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    List<Post>? postsUser,
    PostStatus? statusUser,
    PostStatus? deleteStatus,
    int? count,
    bool? hasReachedMax,
    bool? refresh,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      postsUser: postsUser ?? this.postsUser,
      statusUser: statusUser ?? this.statusUser,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      count: count ?? this.count,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      refresh: refresh ?? this.refresh,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }''';
  }

  @override
  List<Object> get props => [
    status,
    posts,
    hasReachedMax,
    postsUser,
    statusUser,
    count,
    deleteStatus,
    refresh,
  ];
}
