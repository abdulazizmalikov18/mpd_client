import 'package:intl/intl.dart';

class TopSpecialistsModel {
  TopSpecialistsModel({
    required this.count,
    required this.next,
    required this.nextOffset,
    this.previousOffset,
    this.previous,
    required this.results,
  });

  int? count;
  String? next;
  int? nextOffset;
  dynamic previousOffset;
  dynamic previous;
  List<Specialist>? results;

  factory TopSpecialistsModel.fromJson(Map<String, dynamic> json) =>
      TopSpecialistsModel(
        count: json["count"],
        next: json["next"],
        nextOffset: json["next_offset"],
        previousOffset: json["previous_offset"],
        previous: json["previous"],
        results: List<Specialist>.from(
            json["results"].map((x) => Specialist.fromJson(x))),
      );
}

class Specialist {
  Specialist({
    required this.id,
    required this.name,
    required this.lastname,
    this.avatar,
    required this.currentWorkplace,
    required this.user,
    required this.job,
    required this.specCat,
    required this.isWorking,
    required this.isCatHead,
    this.operatingMode,
    this.position,
    required this.autoMode,
    required this.accepted,
    required this.todayTimetable,
    this.minPrice,
    this.currencyCode,
  });

  int? id;
  String? name;
  String? lastname;
  dynamic avatar;
  List<CurrentWorkplace>? currentWorkplace;
  String? user;
  Job? job;
  SpecCat? specCat;
  bool? isWorking;
  bool? isCatHead;
  dynamic operatingMode;
  Position? position;
  bool? autoMode;
  bool? accepted;
  TodayTimetable? todayTimetable;
  String? minPrice;
  String? currencyCode;

  factory Specialist.fromJson(Map<String, dynamic> json) {
    final currency = json["min_price"] != null
        ? NumberFormat.simpleCurrency(locale: 'uz')
            .format(json["min_price"])
            .split(',')
            .first
        : null;
    return Specialist(
      id: json["id"],
      name: json["name"],
      lastname: json["lastname"],
      avatar: json["avatar"],
      currentWorkplace: List<CurrentWorkplace>.from(
          json["current_workplace"].map((x) => CurrentWorkplace.fromJson(x))),
      user: json["user"],
      job: Job.fromJson(json["job"]),
      specCat: SpecCat.fromJson(json["spec_cat"]),
      isWorking: json["is_working"],
      isCatHead: json["is_cat_head"],
      operatingMode: json["operating_mode"],
      position:
          json["position"] == null ? null : Position.fromJson(json["position"]),
      autoMode: json["auto_mode"],
      accepted: json["accepted"],
      todayTimetable: TodayTimetable.fromJson(json["today_timetable"]),
      minPrice: currency,
      currencyCode: json["currency_code"],
    );
  }
}

class CurrentWorkplace {
  CurrentWorkplace({
    required this.id,
    required this.type,
    required this.value,
    required this.createDate,
    required this.updateDate,
  });

  int? id;
  SpecCat? type;
  String? value;
  DateTime? createDate;
  DateTime? updateDate;

  factory CurrentWorkplace.fromJson(Map<String, dynamic> json) =>
      CurrentWorkplace(
        id: json["id"],
        type: SpecCat.fromJson(json["type"]),
        value: json["value"],
        createDate: DateTime.parse(json["create_date"]),
        updateDate: DateTime.parse(json["update_date"]),
      );
}

class SpecCat {
  SpecCat({
    required this.id,
    required this.name,
  });

  int? id;
  String? name;

  factory SpecCat.fromJson(Map<String, dynamic> json) => SpecCat(
        id: json["id"],
        name: json["name"],
      );
}

class Job {
  Job({
    required this.id,
    required this.name,
    this.description,
    required this.hideFromOrgs,
    required this.hideFromUsers,
    this.image,
    required this.status,
    required this.firstLevelScore,
    required this.levelProgressBy,
    required this.parent,
  });

  int? id;
  String? name;
  String? description;
  bool? hideFromOrgs;
  bool? hideFromUsers;
  dynamic image;
  bool? status;
  int? firstLevelScore;
  int? levelProgressBy;
  int? parent;

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
        parent: json["parent"],
      );
}

class Position {
  Position({
    required this.id,
    required this.name,
    required this.status,
    required this.createDate,
    required this.updateDate,
    required this.org,
  });

  int? id;
  String? name;
  bool? status;
  DateTime? createDate;
  DateTime? updateDate;
  int? org;

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        createDate: DateTime.parse(json["create_date"]),
        updateDate: DateTime.parse(json["update_date"]),
        org: json["org"],
      );
}

class TodayTimetable {
  TodayTimetable({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.isWorking,
    required this.repeatDayOff,
    required this.procInterval,
    required this.spec,
  });

  int? id;
  String? dayOfWeek;
  String? startTime;
  String? endTime;
  bool? isWorking;
  int? repeatDayOff;
  num? procInterval;
  int? spec;

  factory TodayTimetable.fromJson(Map<String, dynamic> json) => TodayTimetable(
        id: json["id"],
        dayOfWeek: json["day_of_week"]!,
        startTime: json["start_time"],
        endTime: json["end_time"],
        isWorking: json["is_working"],
        repeatDayOff: json["repeat_day_off"],
        procInterval: json["proc_interval"],
        spec: json["spec"],
      );
}
