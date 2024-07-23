class AdvertsModel {
  AdvertsModel({
    this.count,
    this.next,
    this.nextOffset,
    this.previousOffset,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  int? nextOffset;
  int? previousOffset;
  dynamic previous;
  List<Adverticement>? results;

  factory AdvertsModel.fromJson(Map<String, dynamic> json) => AdvertsModel(
    count: json["count"],
    next: json["next"],
    nextOffset: json["next_offset"],
    previousOffset: json["previous_offset"],
    previous: json["previous"],
    results: json["results"] == null
        ? []
        : List<Adverticement>.from(
        json["results"]!.map((x) => Adverticement.fromJson(x))),
  );
}

class Adverticement {
  Adverticement({
    this.id,
    this.post,
    this.active,
    this.base,
    this.redirectUrl,
  });

  int? id;
  AdverticementPost? post;
  bool? active;
  bool? base;
  String? redirectUrl;

  factory Adverticement.fromJson(Map<String, dynamic> json) => Adverticement(
    id: json["id"],
    post: json["post"] == null
        ? null
        : AdverticementPost.fromJson(json["post"]),
    active: json["active"],
    base: json["base"],
    redirectUrl: json["redirect_url"],
  );
}

class AdverticementPost {
  AdverticementPost({
    this.id,
    this.media,
    this.authorUser,
    this.authorOrg,
    this.action,
    this.text,
    this.date,
    this.updated,
    this.repost,
  });

  int? id;
  List<AdverticementMedia>? media;
  String? authorUser;
  dynamic authorOrg;
  dynamic action;
  String? text;
  DateTime? date;
  DateTime? updated;
  dynamic repost;

  factory AdverticementPost.fromJson(Map<String, dynamic> json) =>
      AdverticementPost(
        id: json["id"],
        media: json["media"] == null
            ? []
            : List<AdverticementMedia>.from(
            json["media"]!.map((x) => AdverticementMedia.fromJson(x))),
        authorUser: json["author_user"],
        authorOrg: json["author_org"],
        action: json["action"],
        text: json["text"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        updated:
        json["updated"] == null ? null : DateTime.parse(json["updated"]),
        repost: json["repost"],
      );
}

class AdverticementMedia {
  AdverticementMedia({
    this.id,
    this.image,
    this.file,
    this.main,
    this.post,
  });

  int? id;
  String? image;
  dynamic file;
  bool? main;
  int? post;

  factory AdverticementMedia.fromJson(Map<String, dynamic> json) =>
      AdverticementMedia(
        id: json["id"],
        image: json["image"],
        file: json["file"],
        main: json["main"],
        post: json["post"],
      );
}
