import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/domain/abstract_repo/lenta_repository.dart';
import 'package:mpd_client/domain/entity/generic_entity.dart';
import 'package:mpd_client/domain/entity/lenta/comment_entity.dart';
import 'package:mpd_client/domain/entity/lenta/send_comment_post_entity.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc(this._repo) : super(const CommentState()) {
    on<GetCommentEvent>(_getComments);
    on<CommentSendEvent>(_sendComment);
  }

  final LentaRepository _repo;

  void _getComments(GetCommentEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await _repo.getPostComments(GenericEntity<int>(data: event.postId, limit: 1000, offset: 0));
    if (result.isRight) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        comments: result.right.results,
      ));
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.failure));
  }

  void _sendComment(CommentSendEvent event, Emitter emit) async {
    final result = await _repo.sendPostComment(SendCommentPostEntity(message: event.message, postId: event.postId));
    if (result.isRight) {
      emit(state.copyWith(comments: [result.right, ...state.comments]));
      event.onSuccess();
      return;
    }

    event.onError("Jo'natishni imkoni bo'lmadi");
  }
}
