import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/bloc_logger.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/network/fcm_service.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/app.dart';
// import 'package:workmanager/workmanager.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

const String $baseUrlHttp = "https://api.t-med.uz/";
const String $baseUrlSocket = "ws://api.t-med.uz";

void main() async {
  await runZonedGuarded(() async {
    // EquatableConfig.stringify = kDebugMode;
    // AndroidYandexMap.useAndroidViewSurface = false;
    WidgetsFlutterBinding.ensureInitialized();
    await StorageRepository.getInstance();
    await FcmService.init();

    setupLocator();
    if (kDebugMode) {
      Bloc.observer = LogBlocObserver();
    }
    HttpOverrides.global = MyHttpOverrides();

    // if (Platform.isAndroid) {
    //   Workmanager().initialize(
    //     callbackDispatcher,
    //     isInDebugMode: true,
    //   );
    //   Workmanager().registerOneOffTask("task-identifier", "nimadir");
    // }

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    debugRepaintRainbowEnabled = false;
    runApp(const MyApp());
  }, (error, stack) {
    Log.e(error);
    Log.e(stack);
  });
}

// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     await FLNService.show(
//       title: "Socket Kuzatilmoqda ...",
//       body: "Listening Socker",
//     );
//     await StorageRepository.getInstance();

//     final socketURl = Uri.parse(
//       "ws://82.215.78.34/OMS/ws/work/?specialist_id=942&org_slug=mpd&lang=ru",
//     );

//     IOWebSocketChannel socketChannel = IOWebSocketChannel.connect(socketURl);

//     final stream = socketChannel.stream.asBroadcastStream();
//     stream.listen(
//       (event) async {
//         await FLNService.show(
//           title: "Socket Kuzatilmoqda ...",
//           body: "$event",
//         );
//         final data = jsonDecode(event);
//         switch (data['type']) {
//           case 'order-create':
//             {
//               OrdersStreamModel order = OrdersStreamModel.fromJson(data);
//               await FLNService.show(
//                 title: "Order Created",
//                 body: order.toString(),
//               );

//               break;
//             }
//           case 'order-update':
//             {
//               OrdersStreamModel order = OrdersStreamModel.fromJson(data);
//               await FLNService.show(
//                 title: "Order Updated",
//                 body: order.toString(),
//               );

//               break;
//             }
//         }
//       },
//       onError: (e) async {
//         await FLNService.show(
//           title: "Socket Kuzatilmoqda ...",
//           body: "ERROR",
//         );
//         socketChannel = IOWebSocketChannel.connect(socketURl);
//       },
//       onDone: () async {
//         await FLNService.show(
//           title: "Socket Kuzatilmoqda ...",
//           body: "Done",
//         );
//       },
//     );

//     return Future.value(true);
//   });
// }
