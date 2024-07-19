import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mpd_client/app.dart';
import 'package:mpd_client/domain/common/app_init.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';
const String $baseUrlHttp = "http://82.215.78.34/";
const String $baseUrlSocket = "ws://82.215.78.34";
Future<void> main() async {
  await runZonedGuarded(() async {
    await AppInit.create;


    runApp(
      const MyApp(),
    );
  }, (error, stack) {
    Log.e("ROOT|Error\nError:$error\nStack:${stack.toString()}");
  });
}
