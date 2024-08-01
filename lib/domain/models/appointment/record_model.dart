class UserRecordModel {
  final int? count;
  final dynamic next;
  final int? nextOffset;
  final int? previousOffset;
  final dynamic previous;
  final List<RecordModel>? results;

  UserRecordModel({
    this.count,
    this.next,
    this.nextOffset,
    this.previousOffset,
    this.previous,
    this.results,
  });

  factory UserRecordModel.fromJson(Map<String, dynamic> json) => UserRecordModel(
        count: json["count"],
        next: json["next"],
        nextOffset: json["next_offset"],
        previousOffset: json["previous_offset"],
        previous: json["previous"],
        results: json["results"] == null ? [] : List<RecordModel>.from(json["results"]!.map((x) => RecordModel.fromJson(x))),
      );
}

class RecordModel {
  final int? id;
  final String? product;
  final String? title;
  final String? conclusion;
  final String? conclusionFile;
  final Writer? writer;
  final DateTime? date;

  RecordModel({
    this.id,
    this.product,
    this.title,
    this.conclusion,
    this.conclusionFile,
    this.writer,
    this.date,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
        id: json["id"],
        product: json["product"],
        title: json["title"],
        conclusion: json["conclusion"],
        conclusionFile: json["conclusion_file"],
        writer: json["writer"] == null ? null : Writer.fromJson(json["writer"]),
        date: json["date"] == null ? null : DateTime.tryParse(json["date"]),
      );
}

class Writer {
  final int? id;
  final String? username;
  final String? name;
  final String? lastname;
  final String? avatar;
  final String? job;

  Writer({
    this.id,
    this.username,
    this.name,
    this.lastname,
    this.avatar,
    this.job,
  });

  factory Writer.fromJson(Map<String, dynamic> json) => Writer(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        lastname: json["lastname"],
        avatar: json["avatar"],
        job: json["job"],
      );
}
