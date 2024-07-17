import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/entity/auth/data_entity.dart';

part 'user.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UserModel extends Equatable {
  const UserModel({
    this.username = '',
    this.name = '',
    this.surname = '',
    this.lastname = '',
    this.email = '',
    this.phone = '',
    this.publicPhone = '',
    this.pinfl = '',
    this.birthday = '',
    this.gender = '',
    this.bio = '',
    this.lang = '',
    this.status = 0,
    this.isRelated = false,
    this.login = '',
    this.region = const DataEntity(),
    this.mainCat = const DataEntity(),
    this.avatar = '',
    this.qrcode = '',
    this.hasPassword = false,
    this.backgroundImage = '',
  });

  final String username;
  final String name;
  final String surname;
  final String lastname;
  final String email;
  final String phone;
  final String publicPhone;
  final String pinfl;
  final String birthday;
  final String gender;
  final String bio;
  final String lang;
  final int status;
  final bool isRelated;
  final String login;
  @DataEntityConverter()
  final DataEntity region;
  @DataEntityConverter()
  final DataEntity mainCat;
  @JsonKey(includeToJson: false)
  final String avatar;
  final String qrcode;
  final bool hasPassword;
  final String backgroundImage;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        if (username.isNotEmpty) 'username': username,
        if (name.isNotEmpty) 'name': name,
        if (surname.isNotEmpty) 'surname': surname,
        if (lastname.isNotEmpty) 'lastname': lastname,
        if (email.isNotEmpty) 'email': email,
        if (phone.isNotEmpty) 'phone': phone,
        if (publicPhone.trim().isNotEmpty) 'public_phone': publicPhone,
        if (pinfl.isNotEmpty) 'pinfl': pinfl,
        if (birthday.isNotEmpty) 'birthday': birthday,
        if (gender.isNotEmpty) 'gender': gender,
        if (bio.isNotEmpty) 'bio': bio,
        if (lang.isNotEmpty) 'lang': lang,
        if (status != -10) 'status': status,
        'is_related': isRelated,
        if (login.isNotEmpty) 'login': login,
        if (region.name.isNotEmpty)
          'region': const DataEntityConverter().toJson(region),
        if (mainCat.name.isNotEmpty)
          'main_cat': const DataEntityConverter().toJson(mainCat),
        if (qrcode.isNotEmpty) 'qrcode': qrcode,
        'has_password': hasPassword,
        if (backgroundImage.isNotEmpty) 'background_image': backgroundImage,
      };

  @override
  List<Object?> get props => [
        username,
        name,
        surname,
        lastname,
        email,
        phone,
        publicPhone,
        pinfl,
        birthday,
        gender,
        bio,
        lang,
        status,
        isRelated,
        login,
        region,
        mainCat,
        avatar,
        qrcode,
        hasPassword,
        backgroundImage,
      ];

  UserModel copyWith({
    String? username,
    String? name,
    String? surname,
    String? lastname,
    String? email,
    String? phone,
    String? publicPhone,
    String? pinfl,
    String? birthday,
    String? gender,
    String? bio,
    String? lang,
    int? status,
    bool? isRelated,
    String? login,
    DataEntity? region,
    DataEntity? mainCat,
    String? avatar,
    String? qrcode,
    bool? hasPassword,
    String? backgroundImage,
  }) {
    return UserModel(
      username: username ?? this.username,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      publicPhone: publicPhone ?? this.publicPhone,
      pinfl: pinfl ?? this.pinfl,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      bio: bio ?? this.bio,
      lang: lang ?? this.lang,
      status: status ?? this.status,
      isRelated: isRelated ?? this.isRelated,
      login: login ?? this.login,
      region: region ?? this.region,
      mainCat: mainCat ?? this.mainCat,
      avatar: avatar ?? this.avatar,
      qrcode: qrcode ?? this.qrcode,
      hasPassword: hasPassword ?? this.hasPassword,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }
}
