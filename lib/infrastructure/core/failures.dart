import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure({required this.errorMessage});

  @override
  List<Object> get props => [];

  @override
  String toString() => errorMessage;

}

class ServerFailure extends Failure {
  final num statusCode;

  const ServerFailure({required super.errorMessage, required this.statusCode});
}

class DioFailure extends Failure {
  const DioFailure({super.errorMessage = "Dio Exception"});
}

class ParsingFailure extends Failure {
  const ParsingFailure({required super.errorMessage});
}

class CacheFailure extends Failure {
  const CacheFailure({super.errorMessage = ""});
}

class ParsingException implements Exception {
  final String errorMessage;

  const ParsingException({required this.errorMessage});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.errorMessage});
}

class ServerTimeOutFailure extends Failure {
  const ServerTimeOutFailure({required super.errorMessage});
}

class ServerNotFoundFailure extends Failure {
  const ServerNotFoundFailure({required super.errorMessage});
}

class ServerUnknownFailure extends Failure {
  const ServerUnknownFailure({required super.errorMessage});
}

class ServerCancelFailure extends Failure {
  const ServerCancelFailure({required super.errorMessage});
}

class LocalFailure extends Failure {
  const LocalFailure({required super.errorMessage});
}
