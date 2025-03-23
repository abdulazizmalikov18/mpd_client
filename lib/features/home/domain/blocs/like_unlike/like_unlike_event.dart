part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeEvent extends Equatable {
  const LikeUnlikeEvent();

  @override
  List<Object> get props => [];
}

class LikeUnlikePressed extends LikeUnlikeEvent {
  final int postId;
  final bool isLiked;
  const LikeUnlikePressed({required this.postId, required this.isLiked});
}
