part of 'post_bloc.dart';

abstract class PostEvent {}

class PostFetched extends PostEvent {
  final bool isRefresh;

  PostFetched([this.isRefresh = false]);
}

class DeletePostEvent extends PostEvent {
  final int id;
  final int index;
  final Function() onSucces;

  DeletePostEvent({
    required this.id,
    required this.index,
    required this.onSucces,
  });
}

class PostFetchedUser extends PostEvent {
  final bool isMore;
  final String username;

  PostFetchedUser({this.isMore = false, required this.username});
}
