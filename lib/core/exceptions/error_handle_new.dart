import 'package:dio/dio.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/core/exceptions/exceptions.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/network/dio_settings.dart';

class ErrorHandleNew {
  ErrorHandleNew();
  final DioSettings dioSettings = locator<DioSettings>();
  Future<R> apiCantrol<T, R>({
    required Future<Response<T>?> Function(Dio client) request,
    required R Function(T response) body,
  }) async {
    dioSettings.setBaseOptions();
    try {
      final response = await request(dioSettings.dio);
      if (response!.statusCode! >= 200 && response.statusCode! < 300) {
        return body(response.data as T);
      }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        message: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(message: e.toString());
    }
  }
}
