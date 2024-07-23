part of 'comment_bloc.dart';

class CommentState extends Equatable {
  final FormzSubmissionStatus status;
  final List<CommentEntity> comments;

  const CommentState({
    this.status = FormzSubmissionStatus.initial,
    this.comments = const [],
  });

  CommentState copyWith({
    FormzSubmissionStatus? status,
    List<CommentEntity>? comments,
  }) {
    return CommentState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object?> get props => [
        comments,
        status,
      ];
}
