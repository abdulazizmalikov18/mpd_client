// To parse this JSON data, do
//
//     final cartRemoteModel = cartRemoteModelFromJson(jsonString);

class CartRemoteModel {
  CartRemoteModel({
    this.id,
    this.product,
    this.responsible,
    this.qty,
    this.meetDate,
    this.subscription,
    this.date,
    this.surchargeIds,
    this.user,
  });

  int? id;
  int? product;
  int? responsible;
  int? qty;
  DateTime? meetDate;
  dynamic subscription;
  DateTime? date;
  List<dynamic>? surchargeIds;
  String? user;

  factory CartRemoteModel.fromJson(Map<String, dynamic> json) =>
      CartRemoteModel(
        id: json["id"],
        product: json["product"],
        responsible: json["responsible"],
        qty: json["qty"],
        meetDate: json["meet_date"] == null
            ? null
            : DateTime.parse(json["meet_date"]),
        subscription: json["subscription"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        surchargeIds: json["surcharge_ids"] == null
            ? []
            : List<dynamic>.from(json["surcharge_ids"]!.map((x) => x)),
        user: json["user"],
      );
}
