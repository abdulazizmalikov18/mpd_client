import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/pages/core/app_widget.dart';

import 'domain/common/app_init.dart';

Future<void> main() async {
  await AppInit.create;

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('uz', 'UZ'), Locale('ru', 'RU')],
      path: 'assets/translation',
      startLocale: const Locale('ru', 'RU'),
      fallbackLocale: const Locale('uz', 'UZ'),
      child: MyApp(
        dbService: AppInit.dbService!,
        connectivityX: AppInit.connectivityX!,
      ),
    ),
  );
}
