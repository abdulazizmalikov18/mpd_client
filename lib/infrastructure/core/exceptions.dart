class NetworkException implements Exception {
  final message = 'Please check your internet connection';

  @override
  String toString() => message;
}

class BackendException implements Exception {
  final message = 'Cannot connect to database.';

  @override
  String toString() => message;
}


class ServerException implements Exception {
  final String errorMessage;
  final num statusCode;
  const ServerException({required this.statusCode, required this.errorMessage});

  @override
  String toString() {
    return 'ServerException(statusCode: $statusCode, errorMessage: $errorMessage)';
  }
}

class DioExceptions implements Exception {}
