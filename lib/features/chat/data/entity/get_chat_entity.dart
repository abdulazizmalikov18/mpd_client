class GetChatEntity {
  final String groupSlug;
  final bool? isStartFromLastSeen;
  final int? limit;
  final int? offset;
  final String? ordering;
  final String? search;


  const GetChatEntity({
    required this.groupSlug,
    this.isStartFromLastSeen,
    this.limit,
    this.offset,
    this.ordering,
    this.search,
  });


  Map<String, Object?> toJson() {
    return {
      if(isStartFromLastSeen!=null)'is_start_from_last_seen': isStartFromLastSeen,
      if(limit!=null)'limit': limit,
      if(offset!=null)'offset': offset,
      if(ordering!=null)'ordering': ordering,
      if(search!=null)'search': search,
    };
  }
}
