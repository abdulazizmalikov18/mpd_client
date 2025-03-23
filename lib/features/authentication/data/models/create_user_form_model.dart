class CreateUserFormModel {
  CreateUserFormModel({
    this.username,
    this.name,
    this.lastname,
    this.surname,
    this.phone,
    this.gender,
    this.birthday,
    this.mainCat,
    this.region,
    this.passportSeries,
    this.passportNumber,
    this.avatar,
    this.password,
  });

  String? username;
  String? name;
  String? lastname;
  String? surname;
  String? phone;
  String? gender;
  String? birthday;
  int? mainCat;
  int? region;
  String? passportSeries;
  String? passportNumber;
  String? avatar;
  String? password;

  Map<String, dynamic> toJson() {
    final birthDayFormated = birthday!.split('.').reversed.join('-');
    final phoneFormatted =
        '998${phone!.replaceAll('-', '').replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '')}';
    return {
      "username": username,
      "name": name,
      "lastname": lastname,
      "surname": surname,
      "phone": phoneFormatted,
      "gender": gender,
      "birthday": birthDayFormated,
      "main_cat": mainCat,
      "region": region,
      "password": password
    };
  }
}
