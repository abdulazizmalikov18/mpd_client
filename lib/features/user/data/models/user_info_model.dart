import 'dart:convert';
import 'package:equatable/equatable.dart';

UserInfoModel? userInfoModelFromJson(String str) =>
    UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel? data) => json.encode(data!.toJson());

// ✅ YECHIM 1: Equatable qo'shish
class UserInfoModel extends Equatable {
  const UserInfoModel({
    this.id,
    this.username,
    this.name,
    this.surname,
    this.lastname,
    this.email,
    this.phone,
    this.birthday,
    this.gender,
    this.bio,
    this.status,
    this.isRelated,
    this.region,
    this.mainCat,
    this.avatar,
    this.qrcode,
    this.hasPassword,
    this.backgroundImage,
  });

  final int? id;
  final String? username;
  final String? name;
  final String? surname;
  final String? lastname;
  final String? email;
  final String? phone;
  final DateTime? birthday;
  final String? gender;
  final String? bio;
  final int? status;
  final bool? isRelated;
  final MainCat? region;
  final MainCat? mainCat;
  final String? avatar;
  final String? qrcode;
  final bool? hasPassword;
  final String? backgroundImage;

  // ✅ MUHIM: Barcha fieldlarni props'ga qo'shish
  @override
  List<Object?> get props => [
    id,
    username,
    name,
    surname,
    lastname,
    email,
    phone,
    birthday,
    gender,
    bio,
    status,
    isRelated,
    region,
    mainCat,
    avatar,
    qrcode,
    hasPassword,
    backgroundImage,
  ];

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    id: json["id"],
    username: json["username"],
    name: json["name"],
    surname: json["surname"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    birthday: json["birthday"] != null
        ? DateTime.parse(json["birthday"])
        : null,
    gender: json["gender"],
    bio: json["bio"],
    status: json["status"],
    isRelated: json["is_related"],
    region: json["region"] != null ? MainCat.fromJson(json["region"]) : null,
    mainCat: json["main_cat"] != null
        ? MainCat.fromJson(json["main_cat"])
        : null,
    avatar: json["avatar"],
    qrcode: json["qrcode"],
    hasPassword: json["has_password"],
    backgroundImage: json["background_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "name": name,
    "surname": surname,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "birthday": birthday != null
        ? "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}"
        : null,
    "gender": gender,
    "bio": bio,
    "status": status,
    "is_related": isRelated,
    "region": region?.toJson(),
    "main_cat": mainCat?.toJson(),
    "avatar": avatar,
    "qrcode": qrcode,
    "has_password": hasPassword,
    "background_image": backgroundImage,
  };

  // ✅ copyWith metodi qo'shish (kerak bo'lsa)
  UserInfoModel copyWith({
    int? id,
    String? username,
    String? name,
    String? surname,
    String? lastname,
    String? email,
    String? phone,
    DateTime? birthday,
    String? gender,
    String? bio,
    int? status,
    bool? isRelated,
    MainCat? region,
    MainCat? mainCat,
    String? avatar,
    String? qrcode,
    bool? hasPassword,
    String? backgroundImage,
  }) {
    return UserInfoModel(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      bio: bio ?? this.bio,
      status: status ?? this.status,
      isRelated: isRelated ?? this.isRelated,
      region: region ?? this.region,
      mainCat: mainCat ?? this.mainCat,
      avatar: avatar ?? this.avatar,
      qrcode: qrcode ?? this.qrcode,
      hasPassword: hasPassword ?? this.hasPassword,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }
}

// ✅ YECHIM 2: MainCat'ga ham Equatable qo'shish
class MainCat extends Equatable {
  const MainCat({this.id, this.name});

  final int? id;
  final String? name;

  @override
  List<Object?> get props => [id, name];

  factory MainCat.fromJson(Map<String, dynamic> json) =>
      MainCat(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};

  MainCat copyWith({int? id, String? name}) {
    return MainCat(id: id ?? this.id, name: name ?? this.name);
  }
}

// ============================================
// BONUS: toString() methodlari debug uchun
// ============================================

extension UserInfoModelDebug on UserInfoModel {
  String get debugInfo =>
      'UserInfoModel(id: $id, name: $name, lastname: $lastname, status: $status)';
}

extension MainCatDebug on MainCat {
  String get debugInfo => 'MainCat(id: $id, name: $name)';
}
