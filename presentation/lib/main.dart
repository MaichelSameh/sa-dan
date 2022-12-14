import 'dart:convert';

import 'package:domain/services/local_notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'config/config.dart';
import 'config/localization.dart';
import 'screens/splash_screen.dart';

Future<void> onBackgroundNotification(RemoteMessage event) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Localization.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage notification) async {
      LocalNotificationServices instance =
          await LocalNotificationServices.getInstance();
      instance.showNotification(
        notification.messageId.hashCode,
        (notification.notification?.title ??
                (notification.data["for"] ?? "").toString().toLowerCase())
            .tr,
        (notification.notification?.body ??
                (notification.data["action"] ?? "").toString().toLowerCase())
            .tr,
        payload: notification.data,
      );
    },
  );
  FirebaseMessaging.onBackgroundMessage(onBackgroundNotification);
  FirebaseMessaging.onMessageOpenedApp
      .listen((RemoteMessage notification) async {
    LocalNotificationServices instance =
        await LocalNotificationServices.getInstance();
    instance.onMessageOpen(json.encode(notification.data));
  });
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Localization.getInstance(),
      initialRoute: SplashScreen.route_name,
      supportedLocales: Localization.getInstance().supportedLocales,
      locale: Get.locale,
      localeResolutionCallback: (Locale? locale, Iterable<Locale> available) {
        if (Get.locale != null) {
          return Get.locale;
        }
        for (Locale temp in available) {
          if (temp.languageCode == locale?.languageCode) {
            Localization.getInstance().setLocale(temp);
            return temp;
          }
        }
        Localization.getInstance().setLocale(Localization.getInstance()
            .supportedLocales
            .firstWhere((Locale element) => element.languageCode == "ar"));
        return Localization.getInstance()
            .supportedLocales
            .firstWhere((Locale element) => element.languageCode == "ar");
      },
      fallbackLocale: Localization.getInstance()
          .supportedLocales
          .firstWhere((Locale element) => element.languageCode == "ar"),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routes: router,
      routingCallback: (_) {
        FocusScope.of(context).unfocus();
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      },
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: Get.locale?.languageCode == "ar" ? 16 : 18,
            height: 1.2,
          ),
          bodySmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: Get.locale?.languageCode == "ar" ? 12 : 14,
            height: 1.2,
          ),
          titleLarge: TextStyle(
            fontSize: Get.locale?.languageCode == "ar" ? 33 : 35,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.5,
            letterSpacing: -0.5,
          ),
          titleMedium: TextStyle(
            fontSize: Get.locale?.languageCode == "ar" ? 20 : 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.5,
            letterSpacing: -0.5,
          ),
          titleSmall: TextStyle(
            fontSize: Get.locale?.languageCode == "ar" ? 18 : 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.5,
            letterSpacing: -0.5,
          ),
          labelSmall: TextStyle(
            fontSize: Get.locale?.languageCode == "ar" ? 12 : 14,
            color: const Color.fromRGBO(151, 173, 182, 1),
          ),
        ),
        fontFamily: Get.locale?.languageCode == "ar" ? "Tajawal" : "Inter",
      ),
    );
  }
}
