// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialistModel _$SpecialistModelFromJson(Map<String, dynamic> json) =>
    SpecialistModel(
      id: json['id'] as String? ?? '',
      org: json['org'] == null
          ? const Org()
          : Org.fromJson(json['org'] as Map<String, dynamic>),
      specCat: json['spec_cat'] == null
          ? const Job()
          : Job.fromJson(json['spec_cat'] as Map<String, dynamic>),
      name: json['name'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      job: json['job'] == null
          ? const Job()
          : Job.fromJson(json['job'] as Map<String, dynamic>),
      role: json['role'] as String?,
      status: json['status'] as String?,
      auto: json['auto'] as bool? ?? false,
      avatar: json['avatar'] as String? ?? '',
      locationDesc: json['location_desc'] as String? ?? '',
      location: json['location'] ?? "",
    );

Map<String, dynamic> _$SpecialistModelToJson(SpecialistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'org': instance.org,
      'spec_cat': instance.specCat,
      'name': instance.name,
      'lastname': instance.lastname,
      'job': instance.job,
      'role': instance.role,
      'status': instance.status,
      'auto': instance.auto,
      'avatar': instance.avatar,
      'location_desc': instance.locationDesc,
      'location': instance.location,
    };

Job _$JobFromJson(Map<String, dynamic> json) =>
    Job(id: json['id'] as String? ?? "", name: json['name'] as String? ?? "");

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

Org _$OrgFromJson(Map<String, dynamic> json) => Org(
  id: json['id'] as String? ?? "",
  name: json['name'] as String? ?? "",
  slugName: json['slug_name'] as String? ?? "",
  logo: json['logo'] as String? ?? "",
  operationType: json['operation_type'] as String? ?? "",
  address: json['address'] as String? ?? "",
  phone: json['phone'] as String? ?? "",
  faceId: json['face_id'] as bool? ?? false,
  workRadius: (json['work_radius'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$OrgToJson(Org instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug_name': instance.slugName,
  'logo': instance.logo,
  'operation_type': instance.operationType,
  'address': instance.address,
  'phone': instance.phone,
  'face_id': instance.faceId,
  'work_radius': instance.workRadius,
};
