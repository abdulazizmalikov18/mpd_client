// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kassa_org_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KassaOrgModel _$KassaOrgModelFromJson(Map<String, dynamic> json) =>
    KassaOrgModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slugName: json['slug_name'] as String? ?? '',
      logo: json['logo'] as String? ?? '',
      address: json['address'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      operationType: json['operation_type'] as String? ?? '',
    );

Map<String, dynamic> _$KassaOrgModelToJson(KassaOrgModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug_name': instance.slugName,
      'logo': instance.logo,
      'phone': instance.phone,
      'address': instance.address,
      'operation_type': instance.operationType,
    };
