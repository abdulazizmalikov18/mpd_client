import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:logging/logging.dart';
import 'package:mpd_client/infrastructure/services/connectivity.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';

class AppInit {
  static bool? connectivityX;

  AppInit._();

  static Future<AppInit> get create async {
    await appInitialized();
    connectivityX ??= await ConnectivityX().create();

    return AppInit._();
  }

  static Future<void> appInitialized() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// LogService Create
    LogService.create;

    /// Easy Localization
    // await EasyLocalization.ensureInitialized();

    /// Device Orientation
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _setupLogging();
    if (kDebugMode) {
      Bloc.observer = LogBlocObserver();
    }
    HttpOverrides.global = MyHttpOverrides();
    // await ScreenUtil.ensureScreenSize();
  }

  static void _setupLogging() => Logger.root
    ..level = kDebugMode ? Level.ALL : Level.WARNING
    ..onRecord.listen((record) => debugPrint(
          '${record.level.name}: '
          '${record.time} '
          '${record.loggerName}: '
          '${record.message}',
        ));
}

/// bloc logger
class LogBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      print("\n----------$bloc Changed-----------\n");
    }
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      print("$bloc closed---------------------");
    }
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      print("$bloc created---------------------");
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      LogService.d('---------Event------------${bloc.runtimeType} $event');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      print('---------Error------------${bloc.runtimeType} $error');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print("--------------$bloc Transition---------------------");
    }
  }
}

/// ssl
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
