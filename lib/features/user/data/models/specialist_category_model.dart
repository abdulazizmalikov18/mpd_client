// To parse this JSON data, do
//
//     final specialistCategoryModel = specialistCategoryModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'specialist_category_model.g.dart';

SpecialistCategoryModel specialistCategoryModelFromJson(String str) =>
    SpecialistCategoryModel.fromJson(json.decode(str));

String specialistCategoryModelToJson(SpecialistCategoryModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SpecialistCategoryModel {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "hide_from_orgs")
  final bool hideFromOrgs;
  @JsonKey(name: "hide_from_users")
  final bool hideFromUsers;
  @JsonKey(name: "image")
  final String image;
  @JsonKey(name: "status")
  final bool status;
  @JsonKey(name: "first_level_score")
  final int firstLevelScore;
  @JsonKey(name: "level_progress_by")
  final int levelProgressBy;
  @JsonKey(name: "creator")
  final dynamic creator;
  @JsonKey(name: "parent")
  final int parent;

  const SpecialistCategoryModel({
    this.id = 0,
    this.name = "",
    this.description = "",
    this.hideFromOrgs = false,
    this.hideFromUsers = false,
    this.image = "",
    this.status = false,
    this.firstLevelScore = 0,
    this.levelProgressBy = 0,
    this.creator = 0,
    this.parent = 0,
  });

  factory SpecialistCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialistCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialistCategoryModelToJson(this);
}
