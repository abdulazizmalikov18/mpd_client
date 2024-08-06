// To parse this JSON data, do
//
//     final cartLocalModel = cartLocalModelFromJson(jsonString);

import 'dart:convert';

List<CartLocalModel> cartLocalModelFromJson(String str) => List<CartLocalModel>.from(json.decode(str).map((x) => CartLocalModel.fromJson(x)));

String cartLocalModelToJson(List<CartLocalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartLocalModel {
    CartLocalModel({
        required this.product,
        required this.responsible,
        required this.qty,
        required this.meetDate,
    });

    int product;
    int responsible;
    int qty;
    DateTime meetDate;

    factory CartLocalModel.fromJson(Map<String, dynamic> json) => CartLocalModel(
        product: json["product"],
        responsible: json["responsible"],
        qty: json["qty"],
        meetDate: DateTime.parse(json["meet_date"]),
    );

    Map<String, dynamic> toJson() => {
        "product": product,
        "responsible": responsible,
        "qty": qty,
        "meet_date": meetDate.toIso8601String(),
    };
}
