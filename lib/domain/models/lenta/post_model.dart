import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/entity/lenta/media_entity.dart';
import 'package:mpd_client/domain/entity/lenta/post_entity.dart';
part 'post_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PostModel extends PostEntity {
  const PostModel({
    super.id,
    super.text,
    super.commentCount,
    super.likesCount,
    super.isLiked,
    super.isMine,
    super.date,
    super.medias,
    super.repost,
    super.products,
    super.authorUser,
    super.username,
    super.authorFullname,
    super.authorAvatar,
    super.mainCat,
    super.selectedIndex,
    super.authorJob,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
