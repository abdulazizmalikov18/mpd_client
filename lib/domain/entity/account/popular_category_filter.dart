class Filter {
  String? search;
  int? limit;
  int? offset;
  int? id;
  int? parent;
  String? timestamp;

  Filter({
    this.id,
    this.search,
    this.limit = 100,
    this.offset,
    this.parent,
  });

  Filter.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    parent = json['parent'];
    offset = json['offset'];
    search = json['search'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    data['parent'] = parent;
    data['offset'] = offset;
    data['limit'] = limit;
    data['timestamp'] = timestamp;
    return data;
  }
}
