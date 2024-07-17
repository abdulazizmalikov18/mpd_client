import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TokenModel {
  @JsonKey(name: 'access', defaultValue: '')
  final String access;
  @JsonKey(name: 'username', defaultValue: '')
  final String username;
  @JsonKey(name: 'refresh', defaultValue: '')
  final String refresh;

  TokenModel({
    required this.access,
    required this.refresh,
    required this.username,
  });

  factory TokenModel.fromJson(Map<String, Object?> json) => TokenModel(
        access: json['access'] as String? ?? '',
        refresh: json['refresh'] as String? ?? '',
        username: json['username'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'access': access,
        'refresh': refresh,
        'username': username,
      };
}
