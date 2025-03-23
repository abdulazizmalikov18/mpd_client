part of 'banner_bloc.dart';

abstract class BannerEvent extends Equatable {
  const BannerEvent();

  @override
  List<Object> get props => [];
}

class GetBannersEvent extends BannerEvent {
  final bool isRefresh;
  const GetBannersEvent(this.isRefresh);
}

class BannerIndexChangedEvent extends BannerEvent {
  final int index;
  const BannerIndexChangedEvent(this.index);
}

class PostIndexChangedEvent extends BannerEvent {
  final int mediaIndex;
  final int postIndex;
  const PostIndexChangedEvent(this.postIndex, this.mediaIndex);
}

class InsertComentToPost extends BannerEvent {
  final int postId;
  const InsertComentToPost(this.postId);
}

class LikeToPost extends BannerEvent {
  final int postId;
  const LikeToPost(this.postId);
}

class ComentPostImageChange extends BannerEvent {
  final int index;
  const ComentPostImageChange(this.index);
}
