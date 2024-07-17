// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MySpecialistModel _$MySpecialistModelFromJson(Map<String, dynamic> json) =>
    MySpecialistModel(
      id: json['id'] as String? ?? "",
      org: json['org'] == null
          ? const KassaOrgEntity()
          : const KassaOrgConverter()
              .fromJson(json['org'] as Map<String, dynamic>?),
      specCat: json['spec_cat'] == null
          ? const MyJobEntity()
          : const MyJobConverter()
              .fromJson(json['spec_cat'] as Map<String, dynamic>?),
      name: json['name'] as String? ?? "",
      lastname: json['lastname'] as String? ?? "",
      job: json['job'] == null
          ? const MyJobEntity()
          : const MyJobConverter()
              .fromJson(json['job'] as Map<String, dynamic>?),
      auto: json['auto'] as bool? ?? false,
      avatar: json['avatar'] as String? ?? "",
      locationDesc: json['location_desc'] as String? ?? "",
    );

Map<String, dynamic> _$MySpecialistModelToJson(MySpecialistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'org': const KassaOrgConverter().toJson(instance.org),
      'spec_cat': const MyJobConverter().toJson(instance.specCat),
      'name': instance.name,
      'lastname': instance.lastname,
      'job': const MyJobConverter().toJson(instance.job),
      'auto': instance.auto,
      'avatar': instance.avatar,
      'location_desc': instance.locationDesc,
    };
