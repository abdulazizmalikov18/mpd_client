part of 'post_bloc.dart';

abstract class PostEvent {}

class PostFetched extends PostEvent {
  final bool isRefresh;

  PostFetched([this.isRefresh = false]);
}

class MediaLikePressedUser extends PostEvent {
  final int index;

  MediaLikePressedUser({required this.index});
}

class DeletePostEvent extends PostEvent {
  final int id;
  final int index;
  final Function() onSucces;

  DeletePostEvent({
    required this.id,
    required this.index,
    required this.onSucces,
  });
}

class PostFetchedUser extends PostEvent {
  final bool isMore;
  final String username;

  PostFetchedUser({this.isMore = false, required this.username});
}

class ReportPostEvent extends PostEvent {
  final String postId;
  final String reason;
  final Function()? onSuccess;
  final Function(String)? onError;
  ReportPostEvent({
    required this.postId,
    required this.reason,
    this.onSuccess,
    this.onError,
  });
}

class BlockUserEvent extends PostEvent {
  final String username;
  final Function()? onSuccess;
  final Function(String)? onError;
  BlockUserEvent({
    required this.username,
    this.onSuccess,
    this.onError,
  });
}
