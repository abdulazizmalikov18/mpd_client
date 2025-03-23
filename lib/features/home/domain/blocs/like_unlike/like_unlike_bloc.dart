import 'package:equatable/equatable.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/core/utils/utils.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  LikeUnlikeBloc(this._homeRepository) : super(const LikeUnlikeInitial(false)) {
    on<LikeUnlikePressed>(_onLikeAndUnlike);
  }

  final HomeRepository _homeRepository;

  Future<void> _onLikeAndUnlike(
      LikeUnlikePressed event, Emitter<LikeUnlikeState> emit) async {
    emit(LikeUnlikeLoading(event.isLiked));

    final result = await _homeRepository.sendLikeOrUnlike(postId: event.postId);
    if (result.isRight) {
      emit(LikeUnlikeSuccess(state.isLiked));
    } else {
       emit(LikeUnlikeFailure(
            Utils.errorFormat(result.left.message), !state.isLiked));
    }
  }
}
