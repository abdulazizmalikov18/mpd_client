// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialist_position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialistPositionModel _$SpecialistPositionModelFromJson(
        Map<String, dynamic> json) =>
    SpecialistPositionModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      org: json['org'] == null
          ? const Org()
          : Org.fromJson(json['org'] as Map<String, dynamic>),
      name: json['name'] as String? ?? "",
      status: json['status'] as bool? ?? false,
      createDate: json['create_date'] as String? ?? "",
      updateDate: json['update_date'] as String? ?? "",
    );

Map<String, dynamic> _$SpecialistPositionModelToJson(
        SpecialistPositionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'org': instance.org,
      'name': instance.name,
      'status': instance.status,
      'create_date': instance.createDate,
      'update_date': instance.updateDate,
    };

Org _$OrgFromJson(Map<String, dynamic> json) => Org(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
    );

Map<String, dynamic> _$OrgToJson(Org instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
