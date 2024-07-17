import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/entity/auth/data_entity.dart';
part 'data.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class DataModel extends DataEntity {
  const DataModel({
    super.id,
    super.name,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}
