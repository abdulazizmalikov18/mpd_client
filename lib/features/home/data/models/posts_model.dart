class PostsModel {
  PostsModel({
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
  int? previousOffset;
  dynamic previous;
  List<Post>? results;

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        count: json["count"],
        next: json["next"],
        nextOffset: json["next_offset"],
        previousOffset: json["previous_offset"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Post>.from(json["results"]!.map((x) => Post.fromJson(x))),
      );
}

class Post {
  Post({
    this.id,
    this.text,
    this.commentCount,
    this.likesCount,
    this.isLiked,
    this.isMine,
    this.date,
    this.media,
    this.repost,
    this.products,
    this.authorUser,
    this.username,
    this.authorFullname,
    this.authorAvatar,
    this.mainCat,
    this.selectedIndex,
    this.authorJob,
  });

  int? id;
  String? text;
  int? commentCount;
  int? likesCount;
  bool? isLiked;
  bool? isMine;
  DateTime? date;
  List<Media>? media;
  dynamic repost;
  List<dynamic>? products;
  String? authorUser;
  String? username;
  String? authorFullname;
  String? authorAvatar;
  Map<String, dynamic>? authorJob;
  String? mainCat;
  int? selectedIndex;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        selectedIndex: 0,
        text: json["text"],
        commentCount: json["comment_count"],
        likesCount: json["likes_count"],
        isLiked: json["is_liked"],
        isMine: json["is_mine"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        media: json["medias"] == null
            ? []
            : List<Media>.from(json["medias"]!.map((x) => Media.fromJson(x))),
        repost: json["repost"],
        products: json["products"] == null
            ? []
            : List<dynamic>.from(json["products"]!.map((x) => x)),
        authorUser: json["author_user"],
        username: json["username"],
        authorFullname: json["author_fullname"],
        authorJob: json["author_job"],
        authorAvatar: json["author_avatar"] ?? '',
        mainCat: json["main_cat"],
      );
}

class Media {
  final int? id;
  final String? image;
  final String? file;
  final String? screenshot;
  final bool? main;
  final String? type;
  final int? post;

  Media({
    this.id,
    this.image,
    this.file,
    this.screenshot,
    this.main,
    this.type,
    this.post,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        image: json["image"],
        file: json["file"],
        screenshot: json["screenshot"],
        main: json["main"],
        type: json["type"],
        post: json["post"],
      );
}
