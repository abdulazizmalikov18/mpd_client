class SpecialistOfferModel {
  final int? count;
  final dynamic next;
  final int? nextOffset;
  final int? previousOffset;
  final dynamic previous;
  final List<SpecialistOffer>? results;

  SpecialistOfferModel({
    this.count,
    this.next,
    this.nextOffset,
    this.previousOffset,
    this.previous,
    this.results,
  });

  factory SpecialistOfferModel.fromJson(Map<String, dynamic> json) =>
      SpecialistOfferModel(
        count: json["count"],
        next: json["next"],
        nextOffset: json["next_offset"],
        previousOffset: json["previous_offset"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<SpecialistOffer>.from(
                json["results"]!.map((x) => SpecialistOffer.fromJson(x)),
              ),
      );
}

class SpecialistOffer {
  final int? id;
  final String? name;
  final int? flow;
  final String? key;
  final int? order;
  bool? isVisible;
  final String? image;
  final bool? isDefault;
  final bool? isAssigned;
  int? productCount;
  int? totalProductCount;

  SpecialistOffer({
    this.id,
    this.name,
    this.flow,
    this.key,
    this.order,
    this.isVisible = false,
    this.image,
    this.isDefault,
    this.productCount,
    this.totalProductCount,
    this.isAssigned = false,
  });

  factory SpecialistOffer.fromJson(Map<String, dynamic> json) =>
      SpecialistOffer(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        flow: json["flow"] ?? 0,
        key: json["key"] ?? '',
        order: json["order"] ?? 0,
        isVisible: json["is_visible"] ?? false,
        image: json["image"] ?? '',
        isDefault: json["is_default"] ?? false,
        isAssigned: json["is_assigned"] ?? false,
        productCount: json["product_count"] ?? 0,
        totalProductCount: json["total_product_count"] ?? 0,
      );
}
