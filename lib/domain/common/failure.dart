import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
abstract class ResponseFailure with _$ResponseFailure {
  const factory ResponseFailure.invalidCredential({
    required String message,
  }) = InvalidCredentials;

  const factory ResponseFailure.noAdminAccess({
    required String message,
  }) = NoAdminAccess;

  const factory ResponseFailure.networkFailure({
    required String message,
  }) = NetworkFailure;

  const factory ResponseFailure.unknown({
    required String message,
  }) = Unknown;
}
