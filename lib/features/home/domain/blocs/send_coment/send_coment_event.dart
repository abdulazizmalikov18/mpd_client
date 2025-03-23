part of 'send_coment_bloc.dart';

abstract class SendComentEvent extends Equatable {
  const SendComentEvent();

  @override
  List<Object> get props => [];
}

class SendComment extends SendComentEvent {
  final int postId;
  final Coment coment;
  const SendComment(this.postId, this.coment);
}

class ComentTextChanged extends SendComentEvent {
  final String comentText;
  const ComentTextChanged(this.comentText);
}

class EmojiShowing extends SendComentEvent {
  final bool emojiShow;
  const EmojiShowing(this.emojiShow);
}
