// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorJob _$AuthorJobFromJson(Map<String, dynamic> json) => AuthorJob(
      id: json['id'] ?? '',
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
      description: json['description'] ?? 0,
      firstLevelScore: (json['first_level_score'] as num?)?.toInt() ?? 0,
      levelProgressBy: (json['level_progress_by'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AuthorJobToJson(AuthorJob instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'status': instance.status,
      'description': instance.description,
      'first_level_score': instance.firstLevelScore,
      'level_progress_by': instance.levelProgressBy,
    };
