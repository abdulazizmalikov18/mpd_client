class GetGroupChatEntity {
  final int? limit;
  final int? offset;
  final String? ordering;
  final String? pinfl;
  final String? search;
  final String? username;

  const GetGroupChatEntity({
    this.limit,
    this.offset,
    this.ordering,
    this.pinfl,
    this.search,
    this.username,
  });

  Map<String, Object?> toJson() {
    return {
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
      if (ordering != null) 'ordering': ordering,
      if (pinfl != null) 'pinfl': pinfl,
      if (search != null) 'search': search,
      if (username != null) 'username': username,
    };
  }
}
