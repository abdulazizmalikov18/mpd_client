class SpecialistProductModel {
  final int count;
  final String next;
  final int nextOffset;
  final int previousOffset;
  final dynamic previous;
  final List<SpecialistProduct> results;

  SpecialistProductModel({
    this.count = 0,
    this.next = "",
    this.nextOffset = 0,
    this.previousOffset = 0,
    this.previous = 0,
    this.results = const [],
  });

  factory SpecialistProductModel.fromJson(Map<String, dynamic> json) =>
      SpecialistProductModel(
        count: json["count"],
        next: json["next"],
        nextOffset: json["next_offset"],
        previousOffset: json["previous_offset"],
        previous: json["previous"],
        results: List<SpecialistProduct>.from(
            json["results"].map((x) => SpecialistProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "next_offset": nextOffset,
    "previous_offset": previousOffset,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class SpecialistProduct {
  final int id;
  final Product product;
  final int status;
  final int remains;
  final String createDate;
  final String updateDate;
  final int cashback;
  final int cancelFine;
  final int recCashback;
  final String org;
  final List<Price> price;
  final dynamic duration;
  final String description;
  final dynamic placeDesc;
  final int vat;
  final List<Specialist> specialists;

  SpecialistProduct({
    this.id = 0,
    this.product = const Product(),
    this.status = 0,
    this.remains = 0,
    this.createDate = "",
    this.updateDate = "",
    this.cashback = 0,
    this.cancelFine = 0,
    this.recCashback = 0,
    this.org = "",
    this.price = const [],
    this.duration = "",
    this.description = "",
    this.placeDesc = "",
    this.vat = 0,
    this.specialists = const [],
  });

  factory SpecialistProduct.fromJson(Map<String, dynamic> json) =>
      SpecialistProduct(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        status: json["status"],
        remains: json["remains"] ?? 0,
        createDate: json["create_date"],
        updateDate: json["update_date"],
        cashback: json["cashback"],
        cancelFine: json["cancel_fine"],
        recCashback: json["rec_cashback"],
        org: json["org"],
        price: List<Price>.from(json["price"].map((x) => Price.fromJson(x))),
        duration: json["duration"],
        description: json["description"],
        placeDesc: json["place_desc"],
        vat: json["vat"],
        specialists: List<Specialist>.from(
            json["specialists"].map((x) => Specialist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product.toJson(),
    "status": status,
    "remains": remains,
    "create_date": createDate,
    "update_date": updateDate,
    "cashback": cashback,
    "cancel_fine": cancelFine,
    "rec_cashback": recCashback,
    "org": org,
    "price": List<dynamic>.from(price.map((x) => x.toJson())),
    "duration": duration,
    "description": description,
    "place_desc": placeDesc,
    "vat": vat,
    "specialists": List<dynamic>.from(specialists.map((x) => x.toJson())),
  };
}

class Price {
  final int id;
  final double value;
  final String currency;
  final int discount;
  final bool active;
  final String createDate;
  final String updateDate;
  final int maxQty;
  final int minQty;

  Price({
    this.id = 0,
    this.value = 0,
    this.currency = "",
    this.discount = 0,
    this.active = false,
    this.createDate = "",
    this.updateDate = "",
    this.maxQty = 0,
    this.minQty = 0,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    id: json["id"],
    value: json["value"],
    currency: json["currency"],
    discount: json["discount"],
    active: json["active"],
    createDate: json["create_date"],
    updateDate: json["update_date"],
    maxQty: json["max_qty"],
    minQty: json["min_qty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "currency": currency,
    "discount": discount,
    "active": active,
    "create_date": createDate,
    "update_date": updateDate,
    "max_qty": maxQty,
    "min_qty": minQty,
  };
}

class Product {
  final int id;
  final String code;
  final String name;
  final String description;
  final int status;
  final dynamic manufacturer;
  final TypeModel type;
  final Category category;
  final String createDate;
  final String updateDate;
  final TypeModel unit;
  final dynamic barCode;

  const Product({
    this.id = 0,
    this.code = '',
    this.name = '',
    this.description = '',
    this.status = 0,
    this.manufacturer = '',
    this.type = const TypeModel(),
    this.category = const Category(),
    this.createDate = '',
    this.updateDate = '',
    this.unit = const TypeModel(),
    this.barCode = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    description: json["description"],
    status: json["status"],
    manufacturer: json["manufacturer"],
    type: TypeModel.fromJson(json["type"]),
    category: Category.fromJson(json["category"]),
    createDate: json["create_date"],
    updateDate: json["update_date"],
    unit: TypeModel.fromJson(json["unit"]),
    barCode: json["bar_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "description": description,
    "status": status,
    "manufacturer": manufacturer,
    "type": type.toJson(),
    "category": category.toJson(),
    "create_date": createDate,
    "update_date": updateDate,
    "unit": unit.toJson(),
    "bar_code": barCode,
  };
}

class Category {
  final int id;
  final String name;
  final List<TypeModel> units;
  final List<TypeModel> productTypes;

  const Category({
    this.id = 0,
    this.name = "",
    this.units = const [],
    this.productTypes = const [],
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    units: List<TypeModel>.from(json["units"].map((x) => TypeModel.fromJson(x))),
    productTypes:
    List<TypeModel>.from(json["product_types"].map((x) => TypeModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "units": List<dynamic>.from(units.map((x) => x.toJson())),
    "product_types":
    List<dynamic>.from(productTypes.map((x) => x.toJson())),
  };
}

class TypeModel {
  final String name;
  final int id;

  const TypeModel({
    this.name = "",
    this.id = 0,
  });

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}

class Specialist {
  final int id;
  final String firstName;
  final String lastName;
  final dynamic avatar;
  final String orgSlug;
  final String category;
  final String job;

  Specialist({
    this.id = 0,
    this.firstName = "",
    this.lastName = "",
    this.avatar = "",
    this.orgSlug = "",
    this.category = "",
    this.job = "",
  });

  factory Specialist.fromJson(Map<String, dynamic> json) => Specialist(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
    orgSlug: json["org_slug"],
    category: json["category"],
    job: json["job"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
    "org_slug": orgSlug,
    "category": category,
    "job": job,
  };
}
