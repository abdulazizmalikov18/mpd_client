import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/domain/models/auth/my_job_model.dart';

class MyJobEntity extends Equatable {
  final String id;
  final String name;

  const MyJobEntity({
    this.id = "",
    this.name = "",
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

class MyJobConverter implements JsonConverter<MyJobEntity, Map<String, dynamic>?> {
  const MyJobConverter();
  @override
  MyJobEntity fromJson(Map<String, dynamic>? json) => MyJobModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(MyJobEntity object) => {};
}


