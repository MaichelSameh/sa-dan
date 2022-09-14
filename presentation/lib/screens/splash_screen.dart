import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import '../controllers/inject.dart';
import '../controllers/user_controller.dart';
import '../widgets/custom_image.dart';

import 'language_screen.dart';
import 'navigation/navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "splash-screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    inject();
    Get.find<UserController>().init().then((_) {
      if (Get.find<UserController>().logged) {
        Get.toNamed(NavigationScreen.route_name);
      } else {
        Get.toNamed(LanguageScreen.route_name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 249, 255, 1),
      body: Center(
        child: CustomImage(
          imagePath: Dir.getLogoPath("logo-with-slogan"),
          width: size.width(mobile: 238),
        ),
      ),
    );
  }
}
