class UpdatePersonalDataModel {
  UpdatePersonalDataModel({
    this.passportScan,
    this.passportSeries,
    this.passportNumber,
    this.passportStir,
    this.user,
  });

  String? passportScan;
  String? passportSeries;
  String? passportNumber;
  String? passportStir;
  int? user;

  factory UpdatePersonalDataModel.fromJson(Map<String, dynamic> json) =>
      UpdatePersonalDataModel(
        passportScan: json["passport_scan"],
        passportSeries: json["passport_series"],
        passportNumber: json["passport_number"],
        passportStir: json["passport_stir"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "passport_scan": passportScan,
        "passport_stir": passportStir,
      };
}
