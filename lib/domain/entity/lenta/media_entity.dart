import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/models/lenta/media_model.dart';

class MediaEntity extends Equatable {
  final int id;
  final String image;
  final String file;
  final String screenshot;
  final bool main;
  final String type;
  final int post;

  const MediaEntity({
    this.id = 0,
    this.image = '',
    this.file = '',
    this.screenshot = '',
    this.main = false,
    this.type = '',
    this.post = 0,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        file,
        screenshot,
        main,
        type,
        post,
      ];
}

class MediaConverter implements JsonConverter<MediaEntity, Map<String, dynamic>?> {
  const MediaConverter();

  @override
  MediaEntity fromJson(Map<String, dynamic>? json) => MediaModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(MediaEntity object) => {};
}
