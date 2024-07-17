class CreateUserModel {
  CreateUserModel({
    this.access,
    this.refresh,
    this.user,
  });

  String? access;
  String? refresh;
  CreateUser? user;

  factory CreateUserModel.fromJson(Map<String, dynamic> json) =>
      CreateUserModel(
        access: json["access"],
        refresh: json["refresh"],
        user: CreateUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "access": access,
        "refresh": refresh,
        "user": user!.toJson(),
      };
}

class CreateUser {
  CreateUser({
    this.phone,
    this.login,
    this.username,
    this.password,
    this.name,
    this.lastname,
    this.surname,
    this.birthday,
    this.gender,
    this.region,
    this.specialist,
  });

  String? phone;
  String? login;
  String? username;
  String? password;
  String? name;
  String? lastname;
  String? surname;
  String? birthday;
  String? gender;
  int? region;
  int? specialist;

  factory CreateUser.fromJson(Map<String, dynamic> json) => CreateUser(
        login: json["login"],
        username: json["username"],
        name: json["name"],
        lastname: json["lastname"],
        surname: json["surname"],
        phone: json["phone"],
        gender: json["gender"],
        birthday: json["birthday"],
        region: json["region"],
        password: json["password"],
        specialist: json["specialist"],
      );

  Map<String, dynamic> toJson() {
    final birthDayFormated = birthday!.split('.').reversed.join('-');
    final phoneFormatted = phone!
        .replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll(' ', '');
    return {
      "password": password,
      "name": name,
      "lastname": lastname,
      "surname": surname,
      "phone": phoneFormatted,
      "gender": gender,
      "birthday": birthDayFormated,
      "region": region,
      "specialist": specialist,
    };
  }

  @override
  String toString() {
    return "password $password ,name $name,lastname $lastname,surname $surname,phone $phone,gender $gender,birthday $birthday,region $region,specialist $specialist,";
  }
}
