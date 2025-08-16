part of 'post_coment_bloc.dart';

abstract class PostComentState {
  final List<Coment> coments;
  final bool isEnd;
  final int oldId;
  const PostComentState(this.coments, {this.isEnd = false, this.oldId = -1});
}

class PostComentInitial extends PostComentState {
  const PostComentInitial(super.coments, {super.isEnd, super.oldId});
}

class PostComentLoading extends PostComentState {
  const PostComentLoading(super.coments, {super.isEnd, super.oldId});
}

class PostComentSuccess extends PostComentState {
  const PostComentSuccess(super.coments, {super.isEnd, super.oldId});
}

class PostComentFailure extends PostComentState {
  final String failure;
  const PostComentFailure(
    super.coments, {
    required this.failure,
    super.isEnd,
    super.oldId,
  });
}
