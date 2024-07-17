// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profession_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfessionModel _$ProfessionModelFromJson(Map<String, dynamic> json) =>
    ProfessionModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      isParent: json['is_parent'] as bool? ?? false,
      childNumber: (json['child_number'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
      hideFromOrgs: json['hide_from_orgs'] as bool? ?? false,
      hideFromUsers: json['hide_from_users'] as bool? ?? false,
      image: json['image'] as String? ?? "",
      status: (json['status'] as num?)?.toInt() ?? 0,
      description: json['description'] as String? ?? "",
      firstLevelScore: (json['first_level_score'] as num?)?.toInt() ?? 0,
      levelProgressBy: (json['level_progress_by'] as num?)?.toInt() ?? 0,
      parent: json['parent'] ?? 0,
    );

Map<String, dynamic> _$ProfessionModelToJson(ProfessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_parent': instance.isParent,
      'child_number': instance.childNumber,
      'name': instance.name,
      'hide_from_orgs': instance.hideFromOrgs,
      'hide_from_users': instance.hideFromUsers,
      'image': instance.image,
      'status': instance.status,
      'description': instance.description,
      'first_level_score': instance.firstLevelScore,
      'level_progress_by': instance.levelProgressBy,
      'parent': instance.parent,
    };
