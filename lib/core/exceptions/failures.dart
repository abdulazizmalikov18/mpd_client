import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [];

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  final num statusCode;

  const ServerFailure({required this.statusCode, required super.message});
}

class DioFailure extends Failure {
  final List<({String title, List<String> message})> errorMessage;

  const DioFailure({this.errorMessage = const [], super.message = ""});
}

class ParsingFailure extends Failure {
  const ParsingFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class ParsingException implements Exception {
  final String message;

  const ParsingException({required this.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}
