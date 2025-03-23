// To parse this JSON data, do
//
//     final specialistModel = specialistModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'specialist_model.g.dart';

List<SpecialistModel> specialistModelFromJson(String str) =>
    List<SpecialistModel>.from(
        json.decode(str).map((x) => SpecialistModel.fromJson(x)));

String specialistModelToJson(List<SpecialistModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class SpecialistModel {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "org")
  final Org org;
  @JsonKey(name: "spec_cat")
  final Job specCat;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "lastname")
  final String lastname;
  @JsonKey(name: "job")
  final Job job;
  @JsonKey(name: "auto")
  final bool auto;
  @JsonKey(name: "avatar")
  final String avatar;
  @JsonKey(name: "location_desc")
  final String locationDesc;
  @JsonKey(name: "location")
  final dynamic location;

  const SpecialistModel({
    this.id = '',
    this.org = const Org(),
    this.specCat = const Job(),
    this.name = '',
    this.lastname = '',
    this.job = const Job(),
    this.auto = false,
    this.avatar = '',
    this.locationDesc = '',
    this.location = "",
  });

  factory SpecialistModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialistModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialistModelToJson(this);
}

@JsonSerializable()
class Job {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;

  const Job({
    this.id = "",
    this.name = "",
  });

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  Map<String, dynamic> toJson() => _$JobToJson(this);
}

@JsonSerializable()
class Org {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "slug_name")
  final String slugName;
  @JsonKey(name: "logo")
  final String logo;
  @JsonKey(name: "operation_type")
  final String operationType;
  @JsonKey(name: "address")
  final String address;
  @JsonKey(name: "phone")
  final String phone;
  @JsonKey(name: "face_id")
  final bool faceId;
  @JsonKey(name: "work_radius")
  final int workRadius;

  const Org({
    this.id = "",
    this.name = "",
    this.slugName = "",
    this.logo = "",
    this.operationType = "",
    this.address = "",
    this.phone = "",
    this.faceId = false,
    this.workRadius = 0,
  });

  factory Org.fromJson(Map<String, dynamic> json) => _$OrgFromJson(json);

  Map<String, dynamic> toJson() => _$OrgToJson(this);
}
