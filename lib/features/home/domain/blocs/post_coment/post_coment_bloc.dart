import 'package:equatable/equatable.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/home/data/models/coment_model.dart';

part 'post_coment_event.dart';
part 'post_coment_state.dart';

class PostComentBloc extends Bloc<PostComentEvent, PostComentState> {
  PostComentBloc(this._homeRepository) : super(const PostComentInitial([])) {
    on<GetComentPostEvent>(_onGetComents);
    on<InsertNewComent>(_onInsertComent);
    on<UpdateOldComent>(_onUpdateOldComent);
  }

  final HomeRepository _homeRepository;

  final List<Coment> _coments = [];
  final int _limit = 20;
  int _offset = 0;

  void _onInsertComent(InsertNewComent event, Emitter<PostComentState> emit) {
    if (event.isSuccess) {
      final lastIndex = _coments.lastIndexWhere(
        (element) => element.date == null,
      );

      _coments[lastIndex].date = event.coment.date;
      _coments[lastIndex].id = event.coment.id;
    } else {
      if (event.coment.text!.isNotEmpty) {
        _coments.insert(0, event.coment);
      }
    }
    emit(
      PostComentSuccess([..._coments], isEnd: state.isEnd, oldId: state.oldId),
    );
  }

  void _onUpdateOldComent(
    UpdateOldComent event,
    Emitter<PostComentState> emit,
  ) {
    if (event.isSuccess) {
      final lastIndex = _coments.lastIndexWhere(
        (element) => element.date == null,
      );

      _coments[lastIndex].date = event.coment.date;
      _coments[lastIndex].id = event.coment.id;
    }
    emit(
      PostComentSuccess([..._coments], isEnd: state.isEnd, oldId: state.oldId),
    );
  }

  Future<void> _onGetComents(
    GetComentPostEvent event,
    Emitter<PostComentState> emit,
  ) async {
    if (event.postId == state.oldId && state.isEnd) return;

    if (event.postId == state.oldId && !event.pagination) return;

    if (event.postId == state.oldId && state is PostComentLoading) return;

    if (event.postId != state.oldId) {
      _coments.clear();
      _offset = 0;
    }
    emit(PostComentLoading(_coments, oldId: event.postId));
    final result = await _homeRepository.getPostComents(
      limit: _limit,
      offset: _offset,
      postId: event.postId,
    );
    if (result.isRight) {
      _addOffset(result.right);
      emit(
        PostComentSuccess(
          _coments,
          isEnd: _coments.length < _offset,
          oldId: event.postId,
        ),
      );
    } else {
      emit(PostComentFailure(state.coments, failure: result.left.message));
    }
  }

  void _addOffset(ComentModel r) {
    _offset += 20;
    _coments.addAll(r.results);
  }
}
