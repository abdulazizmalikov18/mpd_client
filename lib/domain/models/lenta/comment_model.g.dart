// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      user: json['user'] as String? ?? '',
      org: json['org'] as Object? ?? '',
      text: json['text'] as String? ?? '',
      date: json['date'] as String? ?? '',
      post: (json['post'] as num?)?.toInt() ?? 0,
      replyTo: json['reply_to'] as Object? ?? '',
      username: json['username'] as String? ?? '',
      name: json['name'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'org': instance.org,
      'text': instance.text,
      'date': instance.date,
      'post': instance.post,
      'reply_to': instance.replyTo,
      'username': instance.username,
      'name': instance.name,
      'lastname': instance.lastname,
      'avatar': instance.avatar,
    };
