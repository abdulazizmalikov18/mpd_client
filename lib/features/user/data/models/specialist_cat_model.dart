// To parse this JSON data, do
//
//     final specialistCatModel = specialistCatModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'specialist_cat_model.g.dart';

SpecialistCatModel specialistCatModelFromJson(String str) =>
    SpecialistCatModel.fromJson(json.decode(str));

String specialistCatModelToJson(SpecialistCatModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SpecialistCatModel {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "specialist_count")
  final int specialistCount;

  const SpecialistCatModel({
    this.id = 0,
    this.name = "",
    this.specialistCount = 0,
  });

  factory SpecialistCatModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialistCatModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialistCatModelToJson(this);
}
