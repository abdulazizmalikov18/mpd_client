// To parse this JSON data, do
//
//     final cardLocalModel = cardLocalModelFromJson(jsonString);


class CardLocalModel {
    CardLocalModel({
        required this.name,
        required this.cardNumber,
        required this.expire,
    });

    String name;
    String cardNumber;
    String expire;

    factory CardLocalModel.fromJson(Map<String, dynamic> json) => CardLocalModel(
        name: json["name"],
        cardNumber: json["card_number"],
        expire: json["expire"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "card_number": cardNumber,
        "expire": expire,
    };
}
