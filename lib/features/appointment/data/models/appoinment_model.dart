// To parse this JSON data, do
//
//     final appointmentModel = appointmentModelFromJson(jsonString);

class AppointmentModel {
  final int count;
  final dynamic next;
  final int nextOffset;
  final int previousOffset;
  final dynamic previous;
  final List<Appointment> results;

  AppointmentModel({
    required this.count,
    required this.next,
    required this.nextOffset,
    required this.previousOffset,
    required this.previous,
    required this.results,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) => AppointmentModel(
        count: json["count"],
        next: json["next"],
        nextOffset: json["next_offset"],
        previousOffset: json["previous_offset"],
        previous: json["previous"],
        results: List<Appointment>.from(json["results"].map((x) => Appointment.fromJson(x))),
      );
}

class Appointment {
  final int? id;
  final String? orderId;
  final String? name;
  final String? meetDate;
  final int? product;
  final int? qty;
  final double? cost;
  final double? surcharge;
  final String? image;
  final Responsible? responsible;
  final CurrentWorkState? currentWorkState;
  final int? vat;

  Appointment({
    this.id,
    this.orderId,
    this.name,
    this.meetDate,
    this.product,
    this.qty,
    this.cost,
    this.surcharge,
    this.image,
    this.responsible,
    this.currentWorkState,
    this.vat,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        orderId: json["order_id"],
        name: json["name"],
        meetDate: json["meet_date"],
        product: json["product"],
        qty: json["qty"],
        cost: json["cost"].toDouble(),
        surcharge: json["surcharge"].toDouble(),
        image: json["image"],
        responsible: json["responsible"] == null ? null : Responsible.fromJson(json["responsible"]),
        currentWorkState:
            json["current_work_state"] == null ? null : CurrentWorkState.fromMap(json["current_work_state"]),
        vat: json["vat"],
      );
}

class Responsible {
  final int? id;
  final String? username;
  final String? name;
  final String? lastname;
  final dynamic avatar;
  final String? job;
  final String? org;
  final Location? location;

  Responsible({
    this.id,
    this.username,
    this.name,
    this.lastname,
    this.avatar,
    this.job,
    this.org,
    this.location,
  });

  factory Responsible.fromJson(Map<String, dynamic> json) => Responsible(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        lastname: json["lastname"],
        avatar: json["avatar"],
        job: json["job"],
        org: json["org"],
        location: json["location"] == null ? null : Location.fromMap(json["location"]),
      );
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    this.latitude = 0,
    this.longitude = 0,
  });

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class CurrentWorkState {
  final int id;
  final Status status;
  final Specialist specialist;
  final Conclusion conclusion;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? createDate;
  final bool isCurrent;
  final int product;

  CurrentWorkState({
    this.id = 0,
    this.status = const Status(),
    this.specialist = const Specialist(),
    this.conclusion = const Conclusion(),
    this.startTime,
    this.endTime,
    this.createDate,
    this.isCurrent = false,
    this.product = 0,
  });

  factory CurrentWorkState.fromMap(Map<String, dynamic> json) => CurrentWorkState(
        id: json["id"],
        status: json["status"] == null ? const Status() : Status.fromMap(json["status"]),
        specialist: json["specialist"] == null ? const Specialist() : Specialist.fromMap(json["specialist"]),
        conclusion: json["conclusion"] == null ? const Conclusion() : Conclusion.fromMap(json["conclusion"]),
        startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
        endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        createDate: json["create_date"] == null ? null : DateTime.parse(json["create_date"]),
        isCurrent: json["is_current"],
        product: json["product"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status.toMap(),
        "specialist": specialist.toMap(),
        "conclusion": conclusion.toMap(),
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "create_date": createDate?.toIso8601String(),
        "is_current": isCurrent,
        "product": product,
      };
}

class Conclusion {
  final int id;
  final dynamic title;
  final String conclusion;
  final String conclusionFile;
  final int publicConclusion;
  final DateTime? edited;
  final DateTime? date;
  final bool userVisible;
  final List<dynamic> templateValues;
  final int orderProduct;
  final int writer;
  final int workState;

  const Conclusion({
    this.id = 0,
    this.title,
    this.conclusion = '',
    this.conclusionFile = '',
    this.publicConclusion = 0,
    this.edited,
    this.date,
    this.userVisible = false,
    this.templateValues = const [],
    this.orderProduct = 0,
    this.writer = 0,
    this.workState = 0,
  });

  factory Conclusion.fromMap(Map<String, dynamic> json) => Conclusion(
        id: json["id"],
        title: json["title"],
        conclusion: json["conclusion"],
        publicConclusion: json["public_conclusion"],
        edited: json["edited"] == null ? null : DateTime.parse(json["edited"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        userVisible: json["user_visible"],
        templateValues: List<dynamic>.from(json["template_values"].map((x) => x)),
        orderProduct: json["order_product"],
        writer: json["writer"],
        workState: json["work_state"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "conclusion": conclusion,
        "conclusion_file": conclusionFile,
        "public_conclusion": publicConclusion,
        "edited": edited?.toIso8601String(),
        "date": date?.toIso8601String(),
        "user_visible": userVisible,
        "template_values": List<dynamic>.from(templateValues.map((x) => x)),
        "order_product": orderProduct,
        "writer": writer,
        "work_state": workState,
      };
}

class Specialist {
  final int id;
  final String username;
  final String name;
  final String lastname;
  final String avatar;
  final String job;
  final String org;
  final Location? location;

  const Specialist({
    this.id = 0,
    this.username = "",
    this.name = "",
    this.lastname = "",
    this.avatar = "",
    this.job = "",
    this.org = "",
    this.location,
  });

  factory Specialist.fromMap(Map<String, dynamic> json) => Specialist(
        id: json["id"],
        username: json["username"] ?? "",
        name: json["name"] ?? "",
        lastname: json["lastname"] ?? "",
        avatar: json["avatar"] ?? "",
        job: json["job"] ?? "",
        org: json["org"] ?? "",
        location: json["location"] == null ? null : Location.fromMap(json["location"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "name": name,
        "lastname": lastname,
        "avatar": avatar,
        "job": job,
        "org": org,
        "location": location?.toMap(),
      };
}

class Status {
  final int id;
  final String name;

  const Status({
    this.id = 0,
    this.name = "",
  });

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
