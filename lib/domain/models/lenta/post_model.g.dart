// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      text: json['text'] as String? ?? '',
      commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
      likesCount: (json['likes_count'] as num?)?.toInt() ?? 0,
      isLiked: json['is_liked'] as bool? ?? false,
      isMine: json['is_mine'] as bool? ?? false,
      date: json['date'] as String? ?? '',
      medias: (json['medias'] as List<dynamic>?)
              ?.map((e) =>
                  const MediaConverter().fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      repost: json['repost'] ?? '',
      products: json['products'] as List<dynamic>? ?? const [],
      authorUser: json['author_user'] as String? ?? '',
      username: json['username'] as String? ?? '',
      authorFullname: json['author_fullname'] as String? ?? '',
      authorAvatar: json['author_avatar'] as String? ?? '',
      mainCat: json['main_cat'] as String? ?? '',
      selectedIndex: (json['selected_index'] as num?)?.toInt() ?? 0,
      authorJob: json['author_job'] as String? ?? '',
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'comment_count': instance.commentCount,
      'likes_count': instance.likesCount,
      'is_liked': instance.isLiked,
      'is_mine': instance.isMine,
      'date': instance.date,
      'medias': instance.medias.map(const MediaConverter().toJson).toList(),
      'repost': instance.repost,
      'products': instance.products,
      'author_user': instance.authorUser,
      'username': instance.username,
      'author_fullname': instance.authorFullname,
      'author_avatar': instance.authorAvatar,
      'author_job': instance.authorJob,
      'main_cat': instance.mainCat,
      'selected_index': instance.selectedIndex,
    };
