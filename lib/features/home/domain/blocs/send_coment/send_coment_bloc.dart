import 'package:equatable/equatable.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/home/data/models/coment_model.dart';

part 'send_coment_event.dart';
part 'send_coment_state.dart';

class SendComentBloc extends Bloc<SendComentEvent, SendComentState> {
  SendComentBloc(this._homeRepository, this._comentController)
    : super(const SendComentInitial(null)) {
    on<SendComment>(_onSendComent);
    on<ComentTextChanged>(_onComentChanged);
    on<EmojiShowing>(_onEmojiShowing);
  }

  final HomeRepository _homeRepository;

  final TextEditingController _comentController;
  TextEditingController get comentController => _comentController;

  void _onComentChanged(
    ComentTextChanged event,
    Emitter<SendComentState> emit,
  ) {
    emit(
      SendComentInitial(
        state.coment,
        comentText: event.comentText,
        emojiShowing: state.emojiShowing,
      ),
    );
  }

  void _onEmojiShowing(EmojiShowing event, Emitter<SendComentState> emit) {
    emit(
      SendComentInitial(
        state.coment,
        emojiShowing: event.emojiShow,
        comentText: state.comentText,
      ),
    );
  }

  Future<void> _onSendComent(
    SendComment event,
    Emitter<SendComentState> emit,
  ) async {
    if (event.coment.text!.isEmpty) return;
    _comentController.clear();
    emit(SendComentLoading(event.coment));
    final result = await _homeRepository.sendPostComent(
      postId: event.postId,
      text: event.coment.text!,
    );
    if (result.isRight) {
      emit(SendComentSuccess(result.right));
    } else {
      emit(SendComentFailure(result.left.message, state.coment));
    }
  }
}
