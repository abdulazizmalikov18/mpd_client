// To parse this JSON data, do
//
//     final timetableByDateModel = timetableByDateModelFromJson(jsonString);

import 'dart:convert';

TimetableByDateModel timetableByDateModelFromJson(String str) =>
    TimetableByDateModel.fromJson(json.decode(str));

String timetableByDateModelToJson(TimetableByDateModel data) =>
    json.encode(data.toJson());

class TimetableByDateModel {
  final int id;
  final Spec spec;
  final List<dynamic> breaksList;
  final List<BookedTime> bookedTimes;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final bool isWorking;
  final int repeatDayOff;
  final double procInterval;

  TimetableByDateModel({
    required this.id,
    required this.spec,
    required this.breaksList,
    required this.bookedTimes,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.isWorking,
    required this.repeatDayOff,
    required this.procInterval,
  });

  factory TimetableByDateModel.fromJson(Map<String, dynamic> json) =>
      TimetableByDateModel(
        id: json["id"],
        spec: Spec.fromJson(json["spec"]),
        breaksList: List<dynamic>.from(json["breaks_list"].map((x) => x)),
        bookedTimes: List<BookedTime>.from(
            json["booked_times"].map((x) => BookedTime.fromJson(x))),
        dayOfWeek: json["day_of_week"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        isWorking: json["is_working"],
        repeatDayOff: json["repeat_day_off"],
        procInterval: json["proc_interval"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "spec": spec.toJson(),
        "breaks_list": List<dynamic>.from(breaksList.map((x) => x)),
        "booked_times": List<dynamic>.from(bookedTimes.map((x) => x.toJson())),
        "day_of_week": dayOfWeek,
        "start_time": startTime,
        "end_time": endTime,
        "is_working": isWorking,
        "repeat_day_off": repeatDayOff,
        "proc_interval": procInterval,
      };
}

class BookedTime {
  final DateTime date;
  final String? startTime;
  final String? endTime;

  BookedTime({
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory BookedTime.fromJson(Map<String, dynamic> json) => BookedTime(
        date: DateTime.parse(json["date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
      };
}

class Spec {
  final int id;
  final String user;
  final Job job;
  final SpecCat specCat;
  final dynamic position;
  final dynamic bio;
  final dynamic experience;
  final dynamic location;

  Spec({
    this.id = 0,
    this.user = "",
    this.job = const Job(),
    this.specCat = const SpecCat(),
    this.position = "",
    this.bio = "",
    this.experience = "",
    this.location = "",
  });

  factory Spec.fromJson(Map<String, dynamic> json) => Spec(
        id: json["id"],
        user: json["user"],
        job: Job.fromJson(json["job"]),
        specCat: SpecCat.fromJson(json["spec_cat"]),
        position: json["position"],
        bio: json["bio"],
        experience: json["experience"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "job": job.toJson(),
        "spec_cat": specCat.toJson(),
        "position": position,
        "bio": bio,
        "experience": experience,
        "location": location,
      };
}

class Job {
  final int id;
  final String name;
  final String description;
  final bool hideFromOrgs;
  final bool hideFromUsers;
  final dynamic image;
  final bool status;
  final int firstLevelScore;
  final int levelProgressBy;
  final dynamic creator;
  final int parent;

  const Job({
    this.id = 0,
    this.name = "",
    this.description = "",
    this.hideFromOrgs = false,
    this.hideFromUsers = false,
    this.image = "",
    this.status = false,
    this.firstLevelScore = 0,
    this.levelProgressBy = 0,
    this.creator = "",
    this.parent = 0,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        hideFromOrgs: json["hide_from_orgs"],
        hideFromUsers: json["hide_from_users"],
        image: json["image"],
        status: json["status"],
        firstLevelScore: json["first_level_score"],
        levelProgressBy: json["level_progress_by"],
        creator: json["creator"],
        parent: json["parent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "hide_from_orgs": hideFromOrgs,
        "hide_from_users": hideFromUsers,
        "image": image,
        "status": status,
        "first_level_score": firstLevelScore,
        "level_progress_by": levelProgressBy,
        "creator": creator,
        "parent": parent,
      };
}

class SpecCat {
  final int id;
  final String name;
  final int specialistCount;

  const SpecCat({
    this.id = 0,
    this.name = "",
    this.specialistCount = 0,
  });

  factory SpecCat.fromJson(Map<String, dynamic> json) => SpecCat(
        id: json["id"],
        name: json["name"],
        specialistCount: json["specialist_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "specialist_count": specialistCount,
      };
}
