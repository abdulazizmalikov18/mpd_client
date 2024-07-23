import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/entity/lenta/media_entity.dart';

part 'media_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MediaModel extends MediaEntity {
  const MediaModel({
    super.id,
    super.image,
    super.file,
    super.screenshot,
    super.main,
    super.type,
    super.post,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) => _$MediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MediaModelToJson(this);
}
