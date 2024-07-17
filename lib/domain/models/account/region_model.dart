import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/entity/account/region_entity.dart';

part 'region_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegionModel extends RegionEntity {
  const RegionModel({
    super.id,
    super.name,
    super.isParent,
    // super.type,
    // super.userCount,
    super.parent,
  });
  static const fromJsonFactory = fromList;

  static List<RegionModel> fromList(List<Map<String, dynamic>> json) => json.map((e) => RegionModel.fromJson(e)).toList();

  factory RegionModel.fromJson(Map<String, dynamic> json) => _$RegionModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegionModelToJson(this);
}
