import 'dart:convert';

import 'package:data/models/local_token_info.dart';
import 'package:data/models/models.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'token_services.dart';

class LocalNotificationServices {
  static LocalNotificationServices? _instance;

  LocalNotificationServices._();

  static Future<LocalNotificationServices> getInstance() async {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = LocalNotificationServices._();
      await _instance!._init();
      return _instance!;
    }
  }

  Future<void> _init() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
// initialize the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launcher_icon');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {});
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (NotificationResponse res) {
        onMessageOpen(res.payload);
      },
      onDidReceiveNotificationResponse: (NotificationResponse res) {
        onMessageOpen(res.payload);
      },
    );
  }

  Future<void> showNotification(
    int id,
    String? title,
    String? body, {
    Map<String, dynamic>? payload,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const DarwinNotificationDetails iosPlatformChannelSpecification =
        DarwinNotificationDetails(presentSound: true, presentAlert: true);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecification,
    );
    await FlutterLocalNotificationsPlugin().show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload == null ? null : json.encode(payload),
    );
  }

  Future<void> onMessageOpen(String? payload) async {
    if (payload != null) {
      Map<String, dynamic> resData = json.decode(payload);
      LocalTokenInfo? token = await TokenServices().restoreToken();
      if (token == null) {
        return;
      }
    }
  }
}
