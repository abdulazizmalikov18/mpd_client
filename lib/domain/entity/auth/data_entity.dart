import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/models/auth/data.dart';

class DataEntity extends Equatable {
  const DataEntity({
    this.id = 0,
    this.name = '',
  });

  final int id;
  final String name;

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

class DataEntityConverter implements JsonConverter<DataEntity, Map<String, dynamic>?> {
  const DataEntityConverter();

  @override
  DataEntity fromJson(Map<String, dynamic>? json) => DataModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(DataEntity object) => {};
}
