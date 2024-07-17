import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/entity/auth/kass_org_entity.dart';

part 'kassa_org_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class KassaOrgModel extends KassaOrgEntity {
  const KassaOrgModel({
    super.id,
    super.name,
    super.slugName,
    super.logo,
    super.address,
    super.phone,
    super.operationType,
  });

  factory KassaOrgModel.fromJson(Map<String, dynamic> json) => _$KassaOrgModelFromJson(json);

  Map<String, dynamic> toJson() => _$KassaOrgModelToJson(this);
}
