// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      username: json['username'] as String? ?? '',
      name: json['name'] as String? ?? '',
      surname: json['surname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      publicPhone: json['public_phone'] as String? ?? '',
      pinfl: json['pinfl'] as String? ?? '',
      birthday: json['birthday'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      lang: json['lang'] as String? ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
      isRelated: json['is_related'] as bool? ?? false,
      login: json['login'] as String? ?? '',
      region: json['region'] == null
          ? const DataEntity()
          : const DataEntityConverter()
              .fromJson(json['region'] as Map<String, dynamic>?),
      mainCat: json['main_cat'] == null
          ? const DataEntity()
          : const DataEntityConverter()
              .fromJson(json['main_cat'] as Map<String, dynamic>?),
      avatar: json['avatar'] as String? ?? '',
      qrcode: json['qrcode'] as String? ?? '',
      hasPassword: json['has_password'] as bool? ?? false,
      backgroundImage: json['background_image'] as String? ?? '',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'surname': instance.surname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phone': instance.phone,
      'public_phone': instance.publicPhone,
      'pinfl': instance.pinfl,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'bio': instance.bio,
      'lang': instance.lang,
      'status': instance.status,
      'is_related': instance.isRelated,
      'login': instance.login,
      'region': const DataEntityConverter().toJson(instance.region),
      'main_cat': const DataEntityConverter().toJson(instance.mainCat),
      'qrcode': instance.qrcode,
      'has_password': instance.hasPassword,
      'background_image': instance.backgroundImage,
    };
