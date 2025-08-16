import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:mpd_client/app/app_export.dart';

class DioConnectivityRequestRetrier {
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({required this.connectivity});

  final dio = locator.get<Dio>();

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen((
      connectivityResult,
    ) async {
      if (!connectivityResult.contains(ConnectivityResult.none)) {
        streamSubscription.cancel();
        // Complete the completer instead of returning
        responseCompleter.complete(
          await dio.request(
            requestOptions.path,
            cancelToken: requestOptions.cancelToken,
            data: requestOptions.data,
            onReceiveProgress: requestOptions.onReceiveProgress,
            onSendProgress: requestOptions.onSendProgress,
            queryParameters: requestOptions.queryParameters,
            options: Options(
              contentType: requestOptions.contentType,
              headers: requestOptions.headers,
              receiveTimeout: requestOptions.receiveTimeout,
              sendTimeout: requestOptions.sendTimeout,
              responseType: requestOptions.responseType,
              validateStatus: requestOptions.validateStatus,
              extra: requestOptions.extra,
              method: requestOptions.method,
            ),
          ),
        );
      } else {}
    });

    return responseCompleter.future;
  }
}
