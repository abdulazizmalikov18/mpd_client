import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/entity/lenta/comment_entity.dart';

part 'comment_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CommentModel extends CommentEntity {
  const CommentModel({
    super.id,
    super.user,
    super.org,
    super.text,
    super.date,
    super.post,
    super.replyTo,
    super.username,
    super.name,
    super.lastname,
    super.avatar,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
