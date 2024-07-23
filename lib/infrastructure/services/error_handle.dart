
import 'package:dio/dio.dart';
import 'package:mpd_client/infrastructure/core/exceptions.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';
import 'package:mpd_client/infrastructure/services/api_service.dart';
import 'package:mpd_client/infrastructure/services/service_locator.dart';

class ErrorHandle {
   ErrorHandle();
  final DioSettings dioSettings = serviceLocator<DioSettings>();
  Future<R> apiCantrol<T, R>(
      {required Future<Response<T>?> Function(Dio client) request,
      required R Function(T response) body}) async {
    dioSettings.setBaseOptions();
    try {
      final response = await request(dioSettings.dio);
      if (response!.statusCode! >= 200 && response.statusCode! < 300) {
        return body(response.data as T);
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
