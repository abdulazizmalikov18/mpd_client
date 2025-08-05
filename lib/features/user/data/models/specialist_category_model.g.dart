// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialist_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialistCategoryModel _$SpecialistCategoryModelFromJson(
  Map<String, dynamic> json,
) => SpecialistCategoryModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? "",
  description: json['description'] as String? ?? "",
  hideFromOrgs: json['hide_from_orgs'] as bool? ?? false,
  hideFromUsers: json['hide_from_users'] as bool? ?? false,
  image: json['image'] as String? ?? "",
  status: json['status'] as bool? ?? false,
  firstLevelScore: (json['first_level_score'] as num?)?.toInt() ?? 0,
  levelProgressBy: (json['level_progress_by'] as num?)?.toInt() ?? 0,
  creator: json['creator'] ?? 0,
  parent: (json['parent'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$SpecialistCategoryModelToJson(
  SpecialistCategoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'hide_from_orgs': instance.hideFromOrgs,
  'hide_from_users': instance.hideFromUsers,
  'image': instance.image,
  'status': instance.status,
  'first_level_score': instance.firstLevelScore,
  'level_progress_by': instance.levelProgressBy,
  'creator': instance.creator,
  'parent': instance.parent,
};
