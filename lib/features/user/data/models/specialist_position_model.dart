// To parse this JSON data, do
//
//     final specialistPositionModel = specialistPositionModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'specialist_position_model.g.dart';

SpecialistPositionModel specialistPositionModelFromJson(String str) =>
    SpecialistPositionModel.fromJson(json.decode(str));

String specialistPositionModelToJson(SpecialistPositionModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SpecialistPositionModel {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "org")
  final Org org;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "status")
  final bool status;
  @JsonKey(name: "create_date")
  final String createDate;
  @JsonKey(name: "update_date")
  final String updateDate;

  const SpecialistPositionModel({
    this.id = 0,
    this.org = const Org(),
    this.name = "",
    this.status = false,
    this.createDate = "",
    this.updateDate = "",
  });

  factory SpecialistPositionModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialistPositionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialistPositionModelToJson(this);
}

@JsonSerializable()
class Org {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;

  const Org({
    this.id = 0,
    this.name = "",
  });

  factory Org.fromJson(Map<String, dynamic> json) => _$OrgFromJson(json);

  Map<String, dynamic> toJson() => _$OrgToJson(this);
}
