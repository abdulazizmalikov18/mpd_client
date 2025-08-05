import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/features/app.dart';
import 'package:mpd_client/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:mpd_client/main.dart';
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
      if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
        'Authorization':
            'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
    },
    validateStatus: (status) => status != null && status <= 500,
  );

  void setBaseOptions({String? lang}) {
    _dioBaseOptions = BaseOptions(
      baseUrl: $baseUrlHttp,
      connectTimeout: const Duration(milliseconds: 35000),
      receiveTimeout: const Duration(milliseconds: 35000),
      headers: <String, dynamic>{
        'Accept-Language': lang ??
            StorageRepository.getString(
              StorageKeys.LANGUAGE,
              defValue: 'uz',
            ),
        if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
          'Authorization':
              'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
      },
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
      'Accept-Language':
          StorageRepository.getString(StorageKeys.LANGUAGE, defValue: 'uz'),
      // if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
      //   'Authorization':
      //       'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
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

  bool get chuck =>
      StorageRepository.getBool(StorageKeys.CHUCK, defValue: false);

  Dio get dio {
    return Dio(_dioBaseOptions)
      ..interceptors.addAll([
        PrettyDioLogger(
          requestBody: kDebugMode,
          request: kDebugMode,
          requestHeader: kDebugMode,
          responseBody: kDebugMode,
          responseHeader: kDebugMode,
          error: kDebugMode,
        ),
        // interceptor,
        ErrorHandlerInterceptor()
      ]);
  }

  Dio get dioForAuth => Dio(_dioBaseOptionsForAuth)
    ..interceptors.addAll(
      [
        PrettyDioLogger(
          requestBody: kDebugMode,
          request: kDebugMode,
          requestHeader: kDebugMode,
          responseBody: kDebugMode,
          responseHeader: kDebugMode,
          error: kDebugMode,
        ),
      ],
    );

// get interceptor => DioInterceptors(AuthRemoteDataSource(), DioConnectivityRequestRetrier(connectivity: locator<Connectivity>()));
}

class ErrorHandlerInterceptor implements Interceptor {
  ErrorHandlerInterceptor._();

  static final _instance = ErrorHandlerInterceptor._();

  factory ErrorHandlerInterceptor() => _instance;
  static String appName = "#MPD_CLIENT";

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 401) {
      final result = await AuthRepository(
        remoteDataSource: locator<AuthRemoteDataSource>(),
        // connectionInfo: locator<ConnectionInfo>(),
      ).refreshToken();

      if (result.isRight) {
        await StorageRepository.putString(
            StorageKeys.TOKEN, result.right.access ?? "");
        await StorageRepository.putString(
            StorageKeys.REFRESH, result.right.refresh ?? "");
        return handler.resolve(
          await locator<DioSettings>().dio.fetch(
                response.requestOptions
                  ..headers = {
                    "Authorization": "Bearer ${result.right.access}",
                  },
              ),
        );
      } else {
        $navigatorKey.currentState!.pushReplacementNamed(AppRoutes.auth);
        return handler.next(response);
      }
    }
    handler.next(response);
  }
}
