import 'package:json_annotation/json_annotation.dart';

part 'json_serializable.g.dart';

@JsonSerializable()
class Resource {
  final String id;
  final String name;

  Resource(this.id, this.name);

  static const fromJsonFactory = _$ResourceFromJson;

  Map<String, dynamic> toJson() => _$ResourceToJson(this);

  @override
  String toString() => 'Resource{id: $id, name: $name}';
}

@JsonSerializable()
class ResourceError {
  final String type;
  final String message;

  ResourceError(this.type, this.message);

  static const fromJsonFactory = _$ResourceErrorFromJson;

  Map<String, dynamic> toJson() => _$ResourceErrorToJson(this);
}
