class GenericEntity<T> {
  final T? data;
  final int? limit;
  final int? offset;
  final String? ordering;
  final String? search;

  const GenericEntity({
    this.data,
    this.limit,
    this.offset,
    this.ordering,
    this.search,
  });

  Map<String, Object?> query({
    bool limit = true,
    bool offset = true,
    bool ordering = true,
    bool search = true,
    Map<String, Object?> additional = const {},
  }) =>
      {
        if (limit && this.limit != null) "limit": this.limit,
        if (offset && this.offset != null) "offset": this.offset,
        if (ordering && this.ordering != null) "ordering": this.ordering,
        if (search && this.search != null) "search": this.search,
        ...additional,
      };
}
