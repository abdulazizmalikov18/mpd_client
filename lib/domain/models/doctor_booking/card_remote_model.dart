// To parse this JSON data, do
//
//     final cardRemoteModel = cardRemoteModelFromJson(jsonString);

class CardRemoteModel {
  CardRemoteModel({
    this.id,
    this.name,
    this.cardNumber,
    this.expire,
    this.verified,
  });

  int? id;
  String? name;
  String? cardNumber;
  String? expire;
  bool? verified;

  factory CardRemoteModel.fromJson(Map<String, dynamic> json) =>
      CardRemoteModel(
        id: json["id"],
        name: json["name"],
        cardNumber: json["card_number"],
        expire: json["expire"],
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "card_number": cardNumber,
        "expire": expire,
        "verified": verified,
      };
}
