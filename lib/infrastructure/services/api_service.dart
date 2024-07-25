import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:mpd_client/domain/models/auth/token_model.dart';
import 'package:mpd_client/infrastructure/reopsitories/auth_repository.dart';
import 'package:mpd_client/infrastructure/reopsitories/global_request_repo.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';
import 'package:mpd_client/infrastructure/services/service_locator.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';
import 'package:mpd_client/main.dart';
import 'package:mpd_client/presentation/router/app_routs.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioSettings {
  BaseOptions _dioBaseOptions = BaseOptions(
    baseUrl: $baseUrlHttp,
    connectTimeout: const Duration(milliseconds: 35000),
    receiveTimeout: const Duration(milliseconds: 35000),
    followRedirects: false,
    headers: <String, dynamic>{
      'Accept-Language': StorageRepository.getString(
        StorageKeys.LANGUAGE,
        defValue: 'uz',
      ),
      if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
    },
    validateStatus: (status) => status != null && status <= 500,
  );

  void setBaseOptions({String? lang}) {
    _dioBaseOptions = BaseOptions(
      baseUrl: $baseUrlHttp,
      connectTimeout: const Duration(milliseconds: 35000),
      receiveTimeout: const Duration(milliseconds: 35000),
      headers: <String, dynamic>{'Accept-Language': lang, if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'},
      followRedirects: false,
      validateStatus: (status) => status != null && status <= 500,
    );
  }

  final BaseOptions _dioBaseOptionsForAuth = BaseOptions(
    baseUrl: $baseUrlHttp,
    connectTimeout: const Duration(milliseconds: 35000),
    receiveTimeout: const Duration(milliseconds: 35000),
    followRedirects: false,
    headers: <String, dynamic>{
      'Accept-Language': StorageRepository.getString(StorageKeys.LANGUAGE, defValue: 'uz'),
    },
    validateStatus: (status) => status != null && status <= 500,
  );

  void setBaseOptionsForAuth({String? lang}) {
    _dioBaseOptions = BaseOptions(
      baseUrl: $baseUrlHttp,
      connectTimeout: const Duration(milliseconds: 35000),
      receiveTimeout: const Duration(milliseconds: 35000),
      headers: <String, dynamic>{
        'Accept-Language': lang,
      },
      followRedirects: false,
      validateStatus: (status) => status != null && status <= 500,
    );
  }

  BaseOptions get dioBaseOptions => _dioBaseOptions;

  BaseOptions get dioBaseOptionsForAuth => _dioBaseOptionsForAuth;

  bool get chuck => StorageRepository.getBool(StorageKeys.CHUCK, defValue: false);

  Dio get dio => Dio(_dioBaseOptions)
    ..interceptors.addAll([
      PrettyDioLogger(
        requestBody: kDebugMode,
        request: kDebugMode,
        requestHeader: kDebugMode,
        responseBody: kDebugMode,
        responseHeader: kDebugMode,
        error: kDebugMode,
      ),
      ErrorHandlerInterceptor()
    ]);

  Dio get dioForAuth => Dio(_dioBaseOptionsForAuth)
    ..interceptors.addAll([
      LogInterceptor(
        requestBody: kDebugMode,
        request: kDebugMode,
        requestHeader: kDebugMode,
        responseBody: kDebugMode,
        responseHeader: kDebugMode,
        error: kDebugMode,
      ),
      ErrorHandlerInterceptor(),
      // CustomInterceptor()
    ]);
}

//
class ErrorHandlerInterceptor implements Interceptor {
  ErrorHandlerInterceptor._();
  static bool refreshIsActive = true;

  static final _instance = ErrorHandlerInterceptor._();

  factory ErrorHandlerInterceptor() => _instance;
  static String appName = "#MPD_CLIENT";

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if ((err.response?.statusCode ?? 500) == 401) {
      Log.e("refresh Error");

    }
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (!refreshIsActive) {
       Log.e("refresh Response IS Not Active");
      AppRouts.router.goNamed(AppRouteNames.login);
    }
    if (response.statusCode == 401 && refreshIsActive) {
       Log.e("refresh Response");
      final result = await serviceLocator<AuthRepository>().refreshToken();
      if (result.isRight) {
        refreshIsActive = false;
        return handler.resolve(await _retry(response.requestOptions));

      } else {
       Log.e("refresh Response IS LEFT");

        AppRouts.router.goNamed(AppRouteNames.login);

        refreshIsActive = false;
        return handler.next(response);
      }
    }
    handler.next(response);
  }

  static Future<Response<T>> _retry<T>(RequestOptions requestOptions) async => serviceLocator<DioSettings>().dio.request<T>(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: Options(
          method: requestOptions.method,
          headers: requestOptions.headers
            ..addAll(
              <String, String>{
                'Authorization': StorageRepository.getString(StorageKeys.TOKEN),
              },
            ),
        ),
      );
}
