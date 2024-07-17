class RegionsModel {
  RegionsModel({
    this.count,
    this.next,
    this.nextOffset,
    this.previousOffset,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic nextOffset;
  dynamic previousOffset;
  dynamic previous;
  List<Region>? results;

  factory RegionsModel.fromJson(Map<String, dynamic> json) => RegionsModel(
        count: json["count"],
        next: json["next"],
        nextOffset: json["next_offset"],
        previousOffset: json["previous_offset"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Region>.from(
                json["results"]!.map((x) => Region.fromJson(x))),
      );
}

class Region {
  Region({
    required this.id,
    required this.name,
    this.isParent,
    this.type,
  });

  int id;
  String name;
  bool? isParent;
  RegionType? type;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        name: json["name"],
        isParent: json["is_parent"],
        type: json["type"] == null ? null : RegionType.fromJson(json["type"]),
      );
}

class RegionType {
  RegionType({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory RegionType.fromJson(Map<String, dynamic> json) => RegionType(
        id: json["id"],
        name: json["name"],
      );
}
