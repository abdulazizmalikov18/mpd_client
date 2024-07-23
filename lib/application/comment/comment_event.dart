part of 'comment_bloc.dart';

sealed class CommentEvent {
  const CommentEvent();
}

class GetCommentEvent extends CommentEvent {
  final int postId;

  const GetCommentEvent({required this.postId});
}

class CommentLikeEvent extends CommentEvent {
  final bool isLike;

  const CommentLikeEvent(this.isLike);
}

class CommentSendEvent extends CommentEvent {
  final void Function() onSuccess;
  final void Function(String errorMessage) onError;
  final String message;
  final int postId;

  const CommentSendEvent({required this.message, required this.postId, required this.onSuccess, required this.onError});
}
