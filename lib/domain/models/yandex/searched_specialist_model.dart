class MapSpecialistModel {
  final int? count;
  final dynamic next;
  final dynamic nextOffset;
  final dynamic previousOffset;
  final dynamic previous;
  final List<MapSpecialist>? results;

  MapSpecialistModel({
    this.count,
    this.next,
    this.nextOffset,
    this.previousOffset,
    this.previous,
    this.results,
  });

  factory MapSpecialistModel.fromJson(Map<String, dynamic> json) => MapSpecialistModel(
        count: json["count"],
        next: json["next"],
        nextOffset: json["next_offset"],
        previousOffset: json["previous_offset"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<MapSpecialist>.from(json["results"]!.map((x) => MapSpecialist.fromJson(x))),
      );
}

class MapSpecialist {
  final int? id;
  final String? name;
  final String? lastname;
  final String? avatar;
  final String? user;
  final JobModel? job;
  final bool? isWorking;
  final LocationModel? location;
  final double? minPrice;
  final String? currencyCode;
  final String? locationDesc;

  MapSpecialist(
      {this.id,
      this.name,
      this.lastname,
      this.avatar,
      this.user,
      this.job,
      this.isWorking,
      this.location,
      this.currencyCode,
      this.minPrice,
      this.locationDesc});

  factory MapSpecialist.fromJson(Map<String, dynamic> json) => MapSpecialist(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
        avatar: json["avatar"],
        user: json["user"],
        job: json["job"] == null ? null : JobModel.fromJson(json["job"]),
        isWorking: json["is_working"],
        location: json["location"] == null ? null : LocationModel.fromJson(json["location"]),
        minPrice: json["min_price"],
        currencyCode: json["currency_code"],
        locationDesc: json["location_desc"],
      );
}

class JobModel {
  final int? id;
  final String? name;
  final String? description;
  final bool? hideFromOrgs;
  final bool? hideFromUsers;
  final dynamic image;
  final bool? status;
  final int? firstLevelScore;
  final int? levelProgressBy;
  final int? parent;

  JobModel({
    this.id,
    this.name,
    this.description,
    this.hideFromOrgs,
    this.hideFromUsers,
    this.image,
    this.status,
    this.firstLevelScore,
    this.levelProgressBy,
    this.parent,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
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

class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({
    this.latitude = 41.311015,
    this.longitude = 69.279760,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );
}
