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
          json["results"].map((x) => Subscription.fromJson(x)),
        ),
      );
}

class Subscription {
  final int? id;
  /// API: `to_user`
  final String? username;
  final String? followerUser;
  final String? name;
  final String? lastname;
  final String? avatar;
  final SubscriptionJob? job;

  Subscription({
    this.id,
    this.username,
    this.followerUser,
    this.name,
    this.lastname,
    this.avatar,
    this.job,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: json["id"],
    // Backward-compat with old field name used in UI
    username: json["to_user"] ?? json["username"],
    followerUser: json["follower_user"],
    name: json["name"],
    lastname: json["lastname"],
    avatar: json["avatar"],
    job: json["job"] == null
        ? null
        : SubscriptionJob.fromJson(json["job"] as Map<String, dynamic>),
  );

  /// Backward-compat with old UI usage (`mainCat` shown as job).
  String? get mainCat => job?.name;

  /// API does not currently provide region; keep for old UI.
  String? get region => null;
}

class SubscriptionJob {
  final String? id;
  final String? name;
  final String? image;
  final int? status;
  final String? description;
  final int? firstLevelScore;
  final int? levelProgressBy;

  SubscriptionJob({
    this.id,
    this.name,
    this.image,
    this.status,
    this.description,
    this.firstLevelScore,
    this.levelProgressBy,
  });

  factory SubscriptionJob.fromJson(Map<String, dynamic> json) => SubscriptionJob(
    id: json["id"]?.toString(),
    name: json["name"],
    image: json["image"],
    status: json["status"],
    description: json["description"],
    firstLevelScore: json["first_level_score"],
    levelProgressBy: json["level_progress_by"],
  );
}
