part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeState extends Equatable {
  final bool isLiked;
  const LikeUnlikeState(this.isLiked);

  @override
  List<Object> get props => [isLiked];
}

class LikeUnlikeInitial extends LikeUnlikeState {
  const LikeUnlikeInitial(super.isLiked);
}

class LikeUnlikeLoading extends LikeUnlikeState {
  const LikeUnlikeLoading(super.isLiked);
}

class LikeUnlikeSuccess extends LikeUnlikeState {
  const LikeUnlikeSuccess(super.isLiked);
}

class LikeUnlikeFailure extends LikeUnlikeState {
  final String failure;
  const LikeUnlikeFailure(this.failure, super.isLiked);
}
