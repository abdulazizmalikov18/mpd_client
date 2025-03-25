import 'package:json_annotation/json_annotation.dart';

part 'author_job_model.g.dart';

@JsonSerializable()
class AuthorJob {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "image")
  final String image;
  @JsonKey(name: "status")
  final int status;
  @JsonKey(name: "description")
  final dynamic description;
  @JsonKey(name: "first_level_score")
  final int firstLevelScore;
  @JsonKey(name: "level_progress_by")
  final int levelProgressBy;

  const AuthorJob({
    this.id = '',
    this.name = '',
    this.image = '',
    this.status = 0,
    this.description = 0,
    this.firstLevelScore = 0,
    this.levelProgressBy = 0,
  });

  factory AuthorJob.fromJson(Map<String, dynamic> json) =>
      _$AuthorJobFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorJobToJson(this);
}
