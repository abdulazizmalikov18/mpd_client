// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialist_cat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialistCatModel _$SpecialistCatModelFromJson(Map<String, dynamic> json) =>
    SpecialistCatModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
      specialistCount: (json['specialist_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SpecialistCatModelToJson(SpecialistCatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'specialist_count': instance.specialistCount,
    };
