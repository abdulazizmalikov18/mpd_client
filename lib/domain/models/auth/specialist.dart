import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/entity/auth/kass_org_entity.dart';
import 'package:mpd_client/domain/entity/auth/my_job_entity.dart';
import 'package:mpd_client/domain/entity/auth/specialist_entity.dart';

part 'specialist.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MySpecialistModel extends MySpecialist {
  const MySpecialistModel({
    super.id,
    super.org,
    super.specCat,
    super.name,
    super.lastname,
    super.job,
    super.auto,
    super.avatar,
    super.locationDesc,
    // super.location,
  });

  factory MySpecialistModel.fromJson(Map<String, dynamic> json) => _$MySpecialistModelFromJson(json);

  Map<String, dynamic> toJson() => _$MySpecialistModelToJson(this);
}
