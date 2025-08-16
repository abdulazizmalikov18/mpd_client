part of 'send_coment_bloc.dart';

abstract class SendComentState extends Equatable {
  final Coment? coment;
  final String comentText;
  final bool emojiShowing;
  const SendComentState(
    this.coment, {
    this.comentText = '',
    this.emojiShowing = false,
  });

  @override
  List<Object?> get props => [coment, comentText, emojiShowing];
}

class SendComentInitial extends SendComentState {
  const SendComentInitial(super.coment, {super.comentText, super.emojiShowing});
}

class SendComentLoading extends SendComentState {
  const SendComentLoading(super.coment);
}

class SendComentSuccess extends SendComentState {
  const SendComentSuccess(super.coment);
}

class SendComentFailure extends SendComentState {
  final String failure;
  const SendComentFailure(this.failure, super.coment);
}
