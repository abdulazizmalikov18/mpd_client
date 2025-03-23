part of 'post_coment_bloc.dart';

abstract class PostComentEvent extends Equatable {
  const PostComentEvent();

  @override
  List<Object> get props => [];
}

class GetComentPostEvent extends PostComentEvent {
  final int postId;
  final bool pagination;
  const GetComentPostEvent(this.postId, this.pagination);
}

class InsertNewComent extends PostComentEvent {
  final Coment coment;
  final bool isSuccess;
  const InsertNewComent(this.coment, {required this.isSuccess});
}

class UpdateOldComent extends PostComentEvent {
  final Coment coment;
  final bool isSuccess;
  const UpdateOldComent(this.coment, {required this.isSuccess});
}
