import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/models/auth/kassa_org_model.dart';

class KassaOrgEntity extends Equatable {
  final String id;
  final String name;
  final String slugName;
  final String logo;
  final String phone;
  final String address;
  final String operationType;

  const KassaOrgEntity({
    this.id = '',
    this.name = '',
    this.slugName = '',
    this.logo = '',
    this.phone = '',
    this.address = '',
    this.operationType = '',
  });

  @override
  List<Object?> get props => [
    id,
    name,
    slugName,
    logo,
    phone,
    address,
    operationType,
  ];
}

class KassaOrgConverter implements JsonConverter<KassaOrgEntity, Map<String, dynamic>?> {
  const KassaOrgConverter();
  @override
  KassaOrgEntity fromJson(Map<String, dynamic>? json) => KassaOrgModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(KassaOrgEntity object) => {};
}
