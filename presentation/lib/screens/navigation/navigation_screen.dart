import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';
import 'categories_screen.dart';
import 'edit_profile_page.dart';
import 'favorites_page.dart';
import 'home/home_screen.dart';

class NavigationScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "navigation-screen";
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final PageController pageController = PageController(
      initialPage: Get.arguments is num ? Get.arguments.toInt() : 0);

  int currentPage = Get.arguments is num ? Get.arguments.toInt() : 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentPage == 1) {
          return true;
        } else {
          pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeIn,
          );
          return false;
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PageView(
              onPageChanged: (int newPage) {
                FocusScope.of(context).unfocus();
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                currentPage = newPage;
                setState(() {});
              },
              controller: pageController,
              children: const <Widget>[
                HomePage(),
                CategoriesPage(),
                FavoritesPage(),
                EditProfilePage(),
              ],
            ),
            BottomNavBar(
              currentPage: currentPage,
              onPageChanged: (int newPage) {
                pageController.animateToPage(
                  newPage,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
