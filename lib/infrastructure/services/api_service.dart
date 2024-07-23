import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:mpd_client/domain/models/auth/token_model.dart';
import 'package:mpd_client/infrastructure/reopsitories/global_request_repo.dart';
import 'package:mpd_client/infrastructure/services/service_locator.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';
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
      // ErrorHandlerInterceptor()
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
      // ErrorHandlerInterceptor(),
      // CustomInterceptor()
    ]);
}
//
class ErrorHandlerInterceptor implements Interceptor {
  ErrorHandlerInterceptor._();

  static final _instance = ErrorHandlerInterceptor._();

  factory ErrorHandlerInterceptor() => _instance;
  static String appName = "#TMED_WORK";

//   static void sendMessage(Response response) async {
//     if ((response.statusCode ?? 0) >= 400) {
//       String a = """
// App =>  $appName,
// Version =>  1.0.0,
// UserName =>  ${StorageRepository.getString(StorageKeys.USERNAME)},
// Device =>  ${Platform.localeName},
// Status Code => ${response.statusCode}
// Url => !! ${response.realUri.toString()} !!
// Header => ## ${response.headers} ##
// """;
//       if ("body => @@ ${response.data} @@".length < 100) {
//         a += "\nbody => @@ ${response.data} @@";
//       }
//       TelegramSender.sendMessage(TelegramChannel.logChannel, a);
//     }
//   }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
//     TelegramSender.sendMessage(TelegramChannel.logChannel, """
// #error
// Error ##################
// App => $appName
// Url => !! ${err.requestOptions.uri.toString()} !!
// Header => ## ${err.requestOptions.headers} ##
// body => @@ ${err.requestOptions.data} @@
// error => ${err.error},
// Message => ${err.message},
// """);
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 401 && (response.data as List).isNotEmpty && (response.data as List)[0]['"field"'] != 'refresh') {
      final result = await GlobalRequestRepository().postAndSingle(
        endpoint: 'UMS/api/v1.0/account/refresh-token/',
        fromJson: TokenModel.fromJson,
        sendToken: false,
        data: {
          'refresh': StorageRepository.getString(StorageKeys.REFRESH, defValue: ''),
        },
      );
      if (result.isRight) {
        await StorageRepository.putString(StorageKeys.TOKEN, result.right.access);
        await StorageRepository.putString(StorageKeys.REFRESH, result.right.refresh);
        return handler.resolve(await serviceLocator<DioSettings>().dio.fetch(response.requestOptions
          ..headers = {
            "Authorization": "Bearer ${result.right.access}",
          }));
      } else {
        return handler.next(response);
      }
    }
    // sendMessage(response);
    handler.next(response);
  }
}
