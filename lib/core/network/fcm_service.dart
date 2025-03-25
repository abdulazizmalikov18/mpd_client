import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/app.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../../firebase_options.dart';

ValueNotifier<List<RemoteMessage>> $notificationList = ValueNotifier(
    StorageRepository.getList(StorageKeys.NOTIFICATIONS)
        .map((e) => RemoteMessage.fromMap(jsonDecode(e)))
        .toList());

Future<void> notificationSaveAndLoad(RemoteMessage message) async {
  List<RemoteMessage> notificationsLocal =
      StorageRepository.getList(StorageKeys.NOTIFICATIONS)
          .map((e) => RemoteMessage.fromMap(jsonDecode(e)))
          .toList();
  notificationsLocal.add(message);
  $notificationList.value = notificationsLocal;

  await StorageRepository.putList(StorageKeys.NOTIFICATIONS,
      notificationsLocal.map((e) => jsonEncode(e.toMap())).toList());
}

// Notification Navigate
void onNavigate(NotificationResponse notificationResponse) async {
  Navigator.push(
    $navigatorKey.currentContext!,
    MaterialPageRoute(
      builder: (context) => const NotificationPage(),
    ),
  );
}

void onLocalNavigate(
    int id, String? title, String? body, String? payload) async {
  Navigator.push(
    $navigatorKey.currentContext!,
    MaterialPageRoute(
      builder: (context) => const NotificationPage(),
    ),
  );
}

// Notification Handler
Future<void> _onBackgroundMessageHandler(RemoteMessage message) async {
  await notificationSaveAndLoad(message);

  Log.e("Not");
  Log.wtf('New Messaging coming From Background !');
  Log.i(message.notification?.title);
  Log.i(message.notification?.body);
  await FLNService.show(
    title: message.notification?.title,
    body: message.notification?.body,
  );
}

Future<void> _onMessageHandler(RemoteMessage message) async {
  await notificationSaveAndLoad(message);
  Log.wtf('New Messaging coming From On Message!');
  Log.i(message.notification?.title);
  Log.i(message.notification?.body);
  await FLNService.show(
    title: message.notification?.title,
    body: message.notification?.body,
  );
}

Future<void> _onInAppMessageHandler(RemoteMessage message) async {
  await notificationSaveAndLoad(message);

  Log.wtf('New Messaging coming From In App Message!');
  Log.i(message.notification?.title);
  Log.i(message.notification?.body);
  await FLNService.show(
      title: message.notification?.title,
      body: message.notification?.body,
      payload: 'xxxx');
}

// Notification Service - Firebase Cloud Messaging Service
class FcmService {
  FcmService();

  static final messaging = FirebaseMessaging.instance;
  static Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FLNService.initLocalNotification();
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    await messaging.setAutoInitEnabled(true);
    await messaging.setForegroundNotificationPresentationOptions();

    final token = await messaging.getToken() ?? "";
    await StorageRepository.putString(StorageKeys.FCMTOKEN, token);
    print('token : $token');
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onInAppMessageHandler);
  }
}

// Notification  - Flutter Local Notification Service
class FLNService {
  static int id = 0;

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initLocalNotification() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsDarwin = DarwinInitializationSettings(
        // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
        );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    final androidRequestResponse = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    print('Adnroid Request Option : $androidRequestResponse');
  }

  static Future<List<ActiveNotification>> getActiveNotifications() async {
    return await _flutterLocalNotificationsPlugin.getActiveNotifications();
  }

  static Future<List<PendingNotificationRequest>>
      pendingNotificationRequests() async {
    return await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  static Future<void> onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final payload = notificationResponse.payload;
    Log.w(payload);
    if (notificationResponse.payload != null) {
      onNavigate(notificationResponse);
    }
  }

  static Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    onLocalNavigate(id, title, body, payload);
  }

  /// Notifications type

  static Future<void> show({
    String? title,
    String? body,
    String? payload,
  }) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
    );
    const iosNotificationDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
        id++, title, body, notificationDetails);
  }

  Future<void> showNotificationWithNoBody() async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
      id++,
      'plain title',
      null,
      notificationDetails,
      payload: 'item x',
    );
  }

  Future<void> showNotificationWithNoTitle() async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin
        .show(id++, null, 'plain body', notificationDetails, payload: 'item x');
  }

  Future<void> cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(--id);
  }

  Future<void> cancelNotificationWithTag() async {
    await _flutterLocalNotificationsPlugin.cancel(--id, tag: 'tag');
  }

  Future<void> showNotificationCustomSound() async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      channelDescription: 'your other channel description',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
    );
    const darwinNotificationDetails = DarwinNotificationDetails(
      sound: 'slow_spring_board.aiff',
    );
    final linuxPlatformChannelSpecifics = LinuxNotificationDetails(
      sound: AssetsLinuxSound('sound/slow_spring_board.mp3'),
    );
    final notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
      macOS: darwinNotificationDetails,
      linux: linuxPlatformChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.show(
      id++,
      'custom sound notification title',
      'custom sound notification body',
      notificationDetails,
    );
  }

  Future<void> showNotificationCustomVibrationIconLed() async {
    final vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    final androidNotificationDetails = AndroidNotificationDetails(
      'other custom channel id',
      'other custom channel name',
      channelDescription: 'other custom channel description',
      icon: 'secondary_icon',
      largeIcon: const DrawableResourceAndroidBitmap('sample_large_icon'),
      vibrationPattern: vibrationPattern,
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
    );

    final notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
        id++,
        'title of notification with custom vibration pattern, LED and icon',
        'body of notification with custom vibration pattern, LED and icon',
        notificationDetails);
  }

  Future<void> zonedScheduleNotification() async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'scheduled title',
      'scheduled body',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // uiLocalNotificationDateInterpretation:
      // UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> zonedScheduleAlarmClockNotification() async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      123,
      'scheduled alarm clock title',
      'scheduled alarm clock body',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_clock_channel',
          'Alarm Clock Channel',
          channelDescription: 'Alarm Clock Notification',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      // uiLocalNotificationDateInterpretation:
      //     UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showNotificationWithNoSound() async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'silent channel id',
      'silent channel name',
      channelDescription: 'silent channel description',
      playSound: false,
      styleInformation: DefaultStyleInformation(true, true),
    );
    const darwinNotificationDetails = DarwinNotificationDetails(
      presentSound: false,
    );
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
      macOS: darwinNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
        id++, '<b>silent</b> title', '<b>silent</b> body', notificationDetails);
  }

  Future<void> showNotificationSilently() async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      silent: true,
    );
    const darwinNotificationDetails = DarwinNotificationDetails(
      presentSound: false,
    );
    const notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
        macOS: darwinNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
        id++, '<b>silent</b> title', '<b>silent</b> body', notificationDetails);
  }

  Future<void> showTimeoutNotification() async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'silent channel id',
      'silent channel name',
      channelDescription: 'silent channel description',
      timeoutAfter: 3000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    const notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(id++, 'timeout notification',
        'Times out after 3 seconds', notificationDetails);
  }

  Future<void> showInsistentNotification() async {
    const insistentFlag = 4;
    final androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      additionalFlags: Int32List.fromList(<int>[insistentFlag]),
    );
    final notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
      id++,
      'insistent title',
      'insistent body',
      notificationDetails,
      payload: 'item x',
    );
  }
}
