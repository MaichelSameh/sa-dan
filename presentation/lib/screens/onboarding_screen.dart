import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import '../widgets/widgets.dart';
import 'auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "onboarding-screen";
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Map<String, dynamic>> data = <Map<String, dynamic>>[
    <String, dynamic>{
      "illustration": "onboarding-1",
      "title": "onboarding-1-title",
      "description": "onboarding-1-description",
    },
    <String, dynamic>{
      "illustration": "onboarding-2",
      "title": "onboarding-2-title",
      "description": "onboarding-2-description",
    },
    <String, dynamic>{
      "illustration": "onboarding-3",
      "title": "onboarding-3-title",
      "description": "onboarding-3-description",
    },
  ];

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    Size size = Size(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: size.height(mobile: 120)),
          Expanded(
            child: PageView(
              children: <Widget>[
                for (Map<String, dynamic> item in data)
                  Column(
                    children: <Widget>[
                      CustomImage(
                        imagePath:
                            Dir.getIllustrationPath(item["illustration"]),
                      ),
                      SizedBox(height: size.height(mobile: 40)),
                      Text(
                        item["title"].toString().tr,
                        style: Theme.of(context).textTheme.titleMedium,
                        textScaleFactor: 1,
                      ),
                      SizedBox(height: size.height(mobile: 30)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width(mobile: 44)),
                        child: Text(
                          item["description"].toString().tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(height: 2),
                          textScaleFactor: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
              ],
              onPageChanged: (int newPage) {
                setState(
                  () {
                    currentPage = newPage;
                  },
                );
              },
            ),
          ),
          if (currentPage != data.length - 1)
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Get.toNamed(LoginScreen.route_name);
                  },
                  child: Text(
                    "skip".tr,
                    style: Theme.of(context).textTheme.labelSmall,
                    textScaleFactor: 1,
                  ),
                ),
                SizedBox(height: size.height(mobile: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < data.length; i++)
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width(mobile: 4)),
                        width: size.width(mobile: i == currentPage ? 14 : 8),
                        height: size.width(mobile: i == currentPage ? 14 : 8),
                        decoration: BoxDecoration(
                          color:
                              i == currentPage ? null : Palette.primary_color,
                          border: Border.all(
                              color: Palette.primary_color, width: 2),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ],
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 35)),
              child: Button(
                onTap: () {
                  Get.toNamed(LoginScreen.route_name);
                },
                child: Text(
                  "get-started".tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                  textScaleFactor: 1,
                ),
              ),
            ),
          SizedBox(
              height: size.height(
                  mobile: currentPage == data.length - 1 ? 35 : 45)),
        ],
      ),
    );
  }
}
