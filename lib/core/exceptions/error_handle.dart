import 'package:dio/dio.dart';
import 'package:mpd_client/core/exceptions/exceptions.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/utils/log_service.dart';

class ErrorHandle {
  Future<R> apiControl<T, R>({
    required Future<Response<T>?> Function() request,
    required R Function(T response) body,
  }) async {
    try {
      final response = await request();
      if (response!.statusCode! >= 200 && response.statusCode! < 300) {
        return body(response.data as T);
      }
      // if (response.statusCode == 401) {
      //   locator<RefreshtokenBloc>().add(GetRefreshToken());
      // }
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        message: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      Log.e(e);
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      Log.e(e);
      throw ParsingException(message: e.toString());
    }
  }
}
