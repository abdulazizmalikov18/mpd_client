class ServerException implements Exception {
  final String message;
  final num statusCode;
  const ServerException({required this.statusCode, required this.message});

  @override
  String toString() {
    return 'ServerException(statusCode: $statusCode, errorMessage: $message)';
  }
}

class DioExceptions implements Exception {}
