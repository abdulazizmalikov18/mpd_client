import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/entity/lenta/media_entity.dart';
import 'package:mpd_client/domain/models/lenta/post_model.dart';

class PostEntity extends Equatable {
  final int id;
  final String text;
  final int commentCount;
  final int likesCount;
  final bool isLiked;
  final bool isMine;
  final String date;
  @MediaConverter()
  final List<MediaEntity> medias;
  final dynamic repost;
  final List<dynamic>? products;
  final String authorUser;
  final String username;
  final String authorFullname;
  final String authorAvatar;
  final String authorJob;
  final String mainCat;
  final int selectedIndex;

  const PostEntity({
    this.id = 0,
    this.text = '',
    this.commentCount = 0,
    this.likesCount = 0,
    this.isLiked = false,
    this.isMine = false,
    this.date = '',
    this.medias = const [],
    this.repost = '',
    this.products = const [],
    this.authorUser = '',
    this.username = '',
    this.authorFullname = '',
    this.authorAvatar = '',
    this.mainCat = '',
    this.selectedIndex = 0,
    this.authorJob = '',
  });

  @override
  List<Object?> get props => [
        id,
        text,
        commentCount,
        likesCount,
        isLiked,
        isMine,
        date,
        medias,
        repost,
        products,
        authorUser,
        username,
        authorFullname,
        authorAvatar,
        mainCat,
        selectedIndex,
        authorJob,
      ];

  PostEntity copyWith({
    int? id,
    String? text,
    int? commentCount,
    int? likesCount,
    bool? isLiked,
    bool? isMine,
    String? date,
    List<MediaEntity>? medias,
    dynamic? repost,
    List<dynamic>? products,
    String? authorUser,
    String? username,
    String? authorFullname,
    String? authorAvatar,
    String? authorJob,
    String? mainCat,
    int? selectedIndex,
  }) {
    return PostEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      commentCount: commentCount ?? this.commentCount,
      likesCount: likesCount ?? this.likesCount,
      isLiked: isLiked ?? this.isLiked,
      isMine: isMine ?? this.isMine,
      date: date ?? this.date,
      medias: medias ?? this.medias,
      repost: repost ?? this.repost,
      products: products ?? this.products,
      authorUser: authorUser ?? this.authorUser,
      username: username ?? this.username,
      authorFullname: authorFullname ?? this.authorFullname,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      authorJob: authorJob ?? this.authorJob,
      mainCat: mainCat ?? this.mainCat,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

class PostConverter implements JsonConverter<PostEntity, Map<String, dynamic>?> {
  const PostConverter();

  @override
  PostEntity fromJson(Map<String, dynamic>? json) => PostModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(PostEntity object) => {};
}
