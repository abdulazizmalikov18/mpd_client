// ignore_for_file: unused_field

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/network/dio_connectivity_request_retrier.dart';
import 'package:mpd_client/features/app.dart';
import 'package:mpd_client/features/authentication/data/datasources/auth_local_datasource.dart';
import 'package:mpd_client/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio addInterceptor(DioInterceptors interceptors) {
  final dio = locator.get<Dio>();
  dio.interceptors.addAll([
    PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
        compact: true),
    interceptors,
  ]);

  return dio;
}

class DioInterceptors extends Interceptor {
  DioInterceptors(this._remoteDataSource, this._connectivityRequestRetrier);

  final AuthRemoteDataSource _remoteDataSource;
  final DioConnectivityRequestRetrier _connectivityRequestRetrier;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (AuthLocalDataSource.loadAccessToken != null) {
      final token = AuthLocalDataSource.loadAccessToken;
      options.headers['Authorization'] = "Bearer ${token!.access}";

      return handler.next(options);
    }
    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('Retrying -----------------------> 🥶🥶🥶🥶🥶🥶🥶🥶🥶');
    if (_shouldRetry(err)) {
      debugPrint('Retrying -----------------------> 🥶🥶🥶🥶🥶🥶🥶🥶🥶');
      try {
        return handler.resolve(await _connectivityRequestRetrier
            .scheduleRequestRetry(err.requestOptions));
      } catch (e) {
        return handler.next(err);
      }
    } else if (err.response!.statusCode! >= 400 &&
        err.response!.statusCode! < 500) {
      debugPrint('Refreshing -----------------------> 😉😉😉😉😉😉😉😉😉 ');
      if ((err.response!.data as List).length != 3) {
        $navigatorKey.currentState!
            .pushNamedAndRemoveUntil(AppRoutes.auth, (route) => false);
        return handler.reject(err);
      }
      final isTokenRefreshed = await _updateToken();
      debugPrint("isTokenRefreshed: $isTokenRefreshed");
      if (isTokenRefreshed) {
        return handler.resolve(
            await _retry(err.requestOptions, _connectivityRequestRetrier.dio));
      } else {
        return handler.reject(err);
      }
    }

    return handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.unknown && err.error != null;
  }

  Future<bool> _updateToken() async {
    try {
      final newToken = await _remoteDataSource.refreshToken();

      debugPrint(
          'New token -----------------------> 😏😏😏😏😏😏😏😏  $newToken');

      if (newToken.statusCode! >= 200 && newToken.statusCode! < 300) {
        await StorageRepository.putString(StorageKeys.TOKEN, newToken.access!);
        await StorageRepository.putString(
            StorageKeys.REFRESH, newToken.refresh!);
      } else if (newToken.statusCode! >= 400 && newToken.statusCode! < 500) {
        $navigatorKey.currentState!.popUntil((route) => false);
        $navigatorKey.currentState!.pushReplacementNamed(AppRoutes.auth);
        return false;
      }

      debugPrint('Return true -----------------------> 🤢🤢🤢🤢🤢🤢🤢🤢');

      return true;
    } catch (e) {
      debugPrint('Errorr -------------------------- 😀😀😀😀😀😀😀😀😀');
      if (e is DioException) {
        debugPrint("Token refresh failed ${e.response}");
      } else {
        debugPrint("Token refresh failed $e");
      }

      return false;
    }
  }

  Future<Response> _retry(RequestOptions requestOptions, Dio dio) async {
    final options = Options(
      contentType: requestOptions.contentType,
      headers: requestOptions.headers,
      receiveTimeout: requestOptions.receiveTimeout,
      sendTimeout: requestOptions.sendTimeout,
      responseType: requestOptions.responseType,
      validateStatus: requestOptions.validateStatus,
      extra: requestOptions.extra,
      method: requestOptions.method,
    );
    debugPrint("dio client options base url is ${dio.options.baseUrl}");
    return await dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
