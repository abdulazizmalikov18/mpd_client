class ProductFilterModel {
  String? search;
  String? org;
  int? limit;
  int? offset;
  int? specialist;
  int? productType;

  ProductFilterModel({
    this.search,
    this.org,
    this.limit = 100,
    this.offset,
    this.specialist,
    this.productType,
  });

  ProductFilterModel.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    specialist = json['specialist'];
    org = json['org'];
    productType = json['product__type'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    data['product__type'] = productType;
    data['org'] = org;
    data['specialist'] = specialist;
    data['offset'] = offset;
    data['limit'] = limit;
    return data;
  }
}
