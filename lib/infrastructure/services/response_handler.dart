

import 'package:dio/dio.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

class ResponseHandler<T> {
  ServerError? _error;
  T? data;

  setException(ServerError error) {
    _error = error;
  }

  setData(T data) {
    this.data = data;
  }

  ServerError? getException() => _error;
}




class ServerError implements Exception {
  int? _errorCode;
  Failure? _errorFailure;

  ServerError.withError({DioException? error}) {
    _handleError(error!);
  }

  int getErrorCode() => _errorCode!;

  Failure getErrorFailure() => _errorFailure!;

  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        _errorFailure = const ServerTimeOutFailure(errorMessage: 'Connection timeOut');
        break;
      case DioExceptionType.sendTimeout:
        _errorFailure = const ServerTimeOutFailure(errorMessage: 'Send timeOut');
        break;
      case DioExceptionType.receiveTimeout:
        _errorFailure = const ServerTimeOutFailure(errorMessage: 'Recieve timeOut');
        break;
      case DioExceptionType.badResponse:
        _errorCode = error.response!.statusCode ?? 500;
        {
          if (error.response!.data is List) {
            _errorFailure = ServerNotFoundFailure(
               errorMessage : error.response!.data[0]['message'].toString());
          } else {
            _errorFailure =
                ServerUnknownFailure(errorMessage : error.response!.data.toString());
          }
          break;
        }
      case DioExceptionType.cancel:
        _errorFailure = const ServerCancelFailure(errorMessage: 'Server Canceled');
        break;
      case DioExceptionType.unknown:
        _errorFailure = const ServerUnknownFailure(errorMessage: 'Someting wrong');
        break;
      case DioExceptionType.badCertificate:
        _errorFailure = const ServerUnknownFailure(errorMessage: 'Someting wrong');
        break;
      case DioExceptionType.connectionError:
        _errorFailure = const ServerUnknownFailure(errorMessage: 'Someting wrong');
        break;
    }
    return _errorFailure!;
  }
}
