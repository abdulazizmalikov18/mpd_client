
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/models/lenta/comment_model.dart';

class CommentEntity extends Equatable {
  final int id;
  final String user;
  final Object org;
  final String text;
  final String date;
  final int post;
  final Object replyTo;
  final String username;
  final String name;
  final String lastname;
  final String avatar;

  const CommentEntity({
    this.id = 0,
    this.user = '',
    this.org = '',
    this.text = '',
    this.date = '',
    this.post = 0,
    this.replyTo = '',
    this.username = '',
    this.name = '',
    this.lastname = '',
    this.avatar = '',
  });

  @override
  List<Object?> get props => [
        id,
        user,
        org,
        text,
        date,
        post,
        replyTo,
        username,
        name,
        lastname,
        avatar,
      ];
}

class CommentConverter implements JsonConverter<CommentEntity, Map<String, dynamic>?> {
  const CommentConverter();

  @override
  CommentEntity fromJson(Map<String, dynamic>? json) => CommentModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(CommentEntity object) => {};
}
