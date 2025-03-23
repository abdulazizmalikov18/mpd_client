class PopularCategoriesModel {
  PopularCategoriesModel({
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
  List<PopularCategories>? results;

  factory PopularCategoriesModel.fromJson(Map<String, dynamic> json) =>
      PopularCategoriesModel(
        count: json["count"],
        next: json["next"],
        nextOffset: json["next_offset"],
        previousOffset: json["previous_offset"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<PopularCategories>.from(
                json["results"]!.map((x) => PopularCategories.fromJson(x))),
      );
}

class PopularCategories {
  PopularCategories({
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

  int? id;
  String? name;
  String? description;
  bool? hideFromOrgs;
  bool? hideFromUsers;
  String? image;
  bool? status;
  int? firstLevelScore;
  int? levelProgressBy;
  int? parent;

  factory PopularCategories.fromJson(Map<String, dynamic> json) =>
      PopularCategories(
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
