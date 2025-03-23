// To parse this JSON data, do
//
//     final professionModel = professionModelFromJson(jsonString);

import 'dart:convert';

ProfessionModel? professionModelFromJson(String str) => ProfessionModel.fromJson(json.decode(str));

class ProfessionModel {
  ProfessionModel({
    this.count,
    this.next,
    this.nextOffset,
    this.previousOffset,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  int? nextOffset;
  dynamic previousOffset;
  dynamic previous;
  List<Profession>? results;

  factory ProfessionModel.fromJson(Map<String, dynamic> json) => ProfessionModel(
        count: json["count"],
        next: json["next"],
        nextOffset: json["next_offset"],
        previousOffset: json["previous_offset"],
        previous: json["previous"],
        results: json["results"] == null ? [] : (json["results"] as List).map<Profession>((x) => Profession.fromJson(x)).toList(),
      );
}

class Profession {
  Profession({
    this.id,
    this.isParent,
    this.childNumber,
    this.name,
    this.hideFromOrgs,
    this.hideFromUsers,
    this.image,
    this.status,
    this.description,
    this.firstLevelScore,
    this.levelProgressBy,
    this.parent,
  });

  int? id;
  bool? isParent;
  int? childNumber;
  String? name;
  bool? hideFromOrgs;
  bool? hideFromUsers;
  String? image;
  int? status;
  String? description;
  int? firstLevelScore;
  int? levelProgressBy;
  int? parent;

  factory Profession.fromJson(Map<String, dynamic> json) => Profession(
        id: json["id"],
        isParent: json["is_parent"],
        childNumber: json["child_number"],
        name: json["name"],
        hideFromOrgs: json["hide_from_orgs"],
        hideFromUsers: json["hide_from_users"],
        image: json["image"],
        status: json["status"],
        description: json["description"],
        firstLevelScore: json["first_level_score"],
        levelProgressBy: json["level_progress_by"],
        parent: json["parent"],
      );
}
