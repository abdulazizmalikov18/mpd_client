// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaModel _$MediaModelFromJson(Map<String, dynamic> json) => MediaModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      image: json['image'] as String? ?? '',
      file: json['file'] as String? ?? '',
      screenshot: json['screenshot'] as String? ?? '',
      main: json['main'] as bool? ?? false,
      type: json['type'] as String? ?? '',
      post: (json['post'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MediaModelToJson(MediaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'file': instance.file,
      'screenshot': instance.screenshot,
      'main': instance.main,
      'type': instance.type,
      'post': instance.post,
    };
