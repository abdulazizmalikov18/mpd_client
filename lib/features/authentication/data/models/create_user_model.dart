// To parse this JSON data, do
//
//     final createUserModel = createUserModelFromJson(jsonString);

class CreateUserModel {
  CreateUserModel({this.access, this.refresh, this.user});

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
    this.username,
    this.name,
    this.lastname,
    this.surname,
    this.phone,
    this.gender,
    this.birthday,
    this.mainCat,
    this.region,
    this.hasPassword,
  });

  String? username;
  String? name;
  String? lastname;
  String? surname;
  String? phone;
  String? gender;
  String? birthday;
  MainCat? mainCat;
  MainCat? region;
  bool? hasPassword;

  factory CreateUser.fromJson(Map<String, dynamic> json) => CreateUser(
    username: json["username"],
    name: json["name"],
    lastname: json["lastname"],
    surname: json["surname"],
    phone: json["phone"],
    gender: json["gender"],
    birthday: json["birthday"],
    mainCat: MainCat.fromJson(json["main_cat"]),
    region: MainCat.fromJson(json["region"]),
    hasPassword: json["has_password"],
  );

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
      "main_cat": mainCat!.toJson(),
      "region": region!.toJson(),
    };
  }

  @override
  String toString() {
    return 'Username : $username,  Name : $name,  LastName : $lastname, Surname : $surname,  Phone : $phone,  Gender : $gender,  BirthDay : $birthday, MainCategory : $mainCat,  Region : $region';
  }
}

class MainCat {
  final int? id;
  final String? name;
  final String? image;
  final int? parent;

  MainCat({this.id, this.name, this.image, this.parent});

  factory MainCat.fromJson(Map<String, dynamic> json) => MainCat(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    parent: json["parent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "parent": parent,
  };
}
