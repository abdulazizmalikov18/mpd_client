// To parse this JSON data, do
//
//     final comentModel = comentModelFromJson(jsonString);

class ComentModel {
  final int count;
  final dynamic next;
  final int nextOffset;
  final int previousOffset;
  final dynamic previous;
  final List<Coment> results;

  ComentModel({
    required this.count,
    required this.next,
    required this.nextOffset,
    required this.previousOffset,
    required this.previous,
    required this.results,
  });

  factory ComentModel.fromJson(Map<String, dynamic> json) => ComentModel(
        count: json["count"],
        next: json["next"],
        nextOffset: json["next_offset"],
        previousOffset: json["previous_offset"],
        previous: json["previous"],
        results:
            List<Coment>.from(json["results"].map((x) => Coment.fromJson(x))),
      );
}

class Coment {
  int? id;
  String? user;
  Object? org;
  String? text;
  DateTime? date;
  int? post;
  Object? replyTo;
  String? username;
  String? name;
  String? lastname;
  String? avatar;

  Coment({
    this.id,
    this.user,
    this.org,
    this.text,
    this.date,
    this.post,
    this.replyTo,
    this.username,
    this.name,
    this.lastname,
    this.avatar,
  });

  factory Coment.fromJson(Map<String, dynamic> json) => Coment(
        id: json["id"],
        user: json["user"],
        org: json["org"],
        text: json["text"],
        date: DateTime.parse(json["date"]),
        post: json["post"],
        replyTo: json["reply_to"],
        username: json["username"],
        name: json["name"],
        lastname: json["lastname"],
        avatar: json["avatar"],
      );
}
