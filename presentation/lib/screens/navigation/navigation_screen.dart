import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';
import 'categories_screen.dart';
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
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            onPageChanged: (int newPage) {
              currentPage = newPage;
              setState(() {});
            },
            controller: pageController,
            children: const <Widget>[
              HomePage(),
              CategoriesPage(),
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
    );
  }
}
