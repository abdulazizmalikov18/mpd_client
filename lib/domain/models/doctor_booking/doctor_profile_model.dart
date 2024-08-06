class DoctorProfileModel {
  final int id;
  final String name;
  final String lastname;
  final dynamic avatar;
  final dynamic phone;
  final List<dynamic> currentWorkplace;
  final String user;
  final Job job;
  final SpecCat specCat;
  final List<SpecialistOrder> specialistOrders;
  final bool isWorking;
  final bool isCatHead;
  final String operatingMode;
  final dynamic position;
  final bool autoMode;
  final bool accepted;
  final TodayTimetable todayTimetable;
  final dynamic experience;
  final dynamic bio;
  final dynamic location;
  final int orderCount;
  final dynamic lastLocation;

  DoctorProfileModel({
    this.id = 0,
    this.name = "",
    this.lastname = "",
    this.avatar = "",
    this.phone = "",
    this.currentWorkplace = const [],
    this.user = "",
    this.job = const Job(),
    this.specCat = const SpecCat(),
    this.specialistOrders = const [],
    this.isWorking = false,
    this.isCatHead = false,
    this.operatingMode = "",
    this.position,
    this.autoMode = false,
    this.accepted = false,
    this.todayTimetable = const TodayTimetable(),
    this.experience,
    this.bio,
    this.location,
    this.orderCount = 0,
    this.lastLocation,
  });

  factory DoctorProfileModel.fromMap(Map<String, dynamic> json) =>
      DoctorProfileModel(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
        avatar: json["avatar"],
        phone: json["phone"],
        currentWorkplace:
            List<dynamic>.from(json["current_workplace"].map((x) => x)),
        user: json["user"],
        job: json["job"] == null ? const Job() : Job.fromMap(json["job"]),
        specCat: SpecCat.fromMap(json["spec_cat"]),
        specialistOrders: List<SpecialistOrder>.from(
            json["specialist_orders"].map((x) => SpecialistOrder.fromMap(x))),
        isWorking: json["is_working"],
        isCatHead: json["is_cat_head"],
        operatingMode: json["operating_mode"],
        position: json["position"],
        autoMode: json["auto_mode"],
        accepted: json["accepted"],
        todayTimetable: json["today_timetable"] != null
            ? TodayTimetable.fromMap(json["today_timetable"])
            : const TodayTimetable(),
        experience: json["experience"],
        bio: json["bio"],
        location: json["location"],
        orderCount: json["order_count"],
        lastLocation: json["last_location"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "avatar": avatar,
        "phone": phone,
        "current_workplace": List<dynamic>.from(currentWorkplace.map((x) => x)),
        "user": user,
        "job": job.toMap(),
        "spec_cat": specCat.toMap(),
        "specialist_orders": List<dynamic>.from(specialistOrders.map((x) => x)),
        "is_working": isWorking,
        "is_cat_head": isCatHead,
        "operating_mode": operatingMode,
        "position": position,
        "auto_mode": autoMode,
        "accepted": accepted,
        "today_timetable": todayTimetable.toMap(),
        "experience": experience,
        "bio": bio,
        "location": location,
        "order_count": orderCount,
        "last_location": lastLocation,
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

  factory Job.fromMap(Map<String, dynamic> json) => Job(
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

  Map<String, dynamic> toMap() => {
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

  factory SpecCat.fromMap(Map<String, dynamic> json) => SpecCat(
        id: json["id"],
        name: json["name"],
        specialistCount: json["specialist_count"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "specialist_count": specialistCount,
      };
}

class TodayTimetable {
  final int id;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final bool isWorking;
  final int repeatDayOff;
  final double procInterval;
  final int spec;

  const TodayTimetable({
    this.id = 0,
    this.dayOfWeek = "",
    this.startTime = "",
    this.endTime = "",
    this.isWorking = false,
    this.repeatDayOff = 0,
    this.procInterval = 0,
    this.spec = 0,
  });

  factory TodayTimetable.fromMap(Map<String, dynamic> json) => TodayTimetable(
        id: json["id"],
        dayOfWeek: json["day_of_week"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        isWorking: json["is_working"],
        repeatDayOff: json["repeat_day_off"],
        procInterval: json["proc_interval"],
        spec: json["spec"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "day_of_week": dayOfWeek,
        "start_time": startTime,
        "end_time": endTime,
        "is_working": isWorking,
        "repeat_day_off": repeatDayOff,
        "proc_interval": procInterval,
        "spec": spec,
      };
}

class SpecialistOrder {
  final int id;
  final int orderNumber;
  final int lastOrderNumber;
  final int patientNumber;
  final int lastPatientNumber;
  final int specialist;

  const SpecialistOrder({
    this.id = 0,
    this.orderNumber = 0,
    this.lastOrderNumber = 0,
    this.patientNumber = 0,
    this.lastPatientNumber = 0,
    this.specialist = 0,
  });

  factory SpecialistOrder.fromMap(Map<String, dynamic> json) => SpecialistOrder(
        id: json["id"],
        orderNumber: json["order_number"],
        lastOrderNumber: json["last_order_number"],
        patientNumber: json["patient_number"],
        lastPatientNumber: json["last_patient_number"],
        specialist: json["specialist"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order_number": orderNumber,
        "last_order_number": lastOrderNumber,
        "patient_number": patientNumber,
        "last_patient_number": lastPatientNumber,
        "specialist": specialist,
      };
}
