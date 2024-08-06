class UserSubscriptionsModel {
  final int? count;
  final dynamic next;
  final int? nextOffset;
  final int? previousOffset;
  final dynamic previous;
  final List<Subscription>? results;

  UserSubscriptionsModel({
    this.count,
    this.next,
    this.nextOffset,
    this.previousOffset,
    this.previous,
    this.results,
  });

  factory UserSubscriptionsModel.fromJson(Map<String, dynamic> json) =>
      UserSubscriptionsModel(
        count: json["count"],
        next: json["next"],
        nextOffset: json["next_offset"],
        previousOffset: json["previous_offset"],
        previous: json["previous"],
        results: List<Subscription>.from(
            json["results"].map((x) => Subscription.fromJson(x))),
      );
}

class Subscription {
  final int? id;
  final String? username;
  final String? name;
  final String? lastname;
  final String? phone;
  final dynamic avatar;
  final String? mainCat;
  final String? region;

  Subscription({
    this.id,
    this.username,
    this.name,
    this.lastname,
    this.phone,
    this.avatar,
    this.mainCat,
    this.region,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        avatar: json["avatar"],
        mainCat: json["main_cat"],
        region: json["region"],
      );

  getException() {}
}
