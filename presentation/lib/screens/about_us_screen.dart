import 'package:data/models/general/general_info.dart';
import 'package:domain/services/general_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_image.dart';
import '../widgets/error_handler.dart';
import '../widgets/preloader.dart';
import 'navigation/navigation_screen.dart';

class AboutUsScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "about-us-screen";
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  GeneralInfo? info;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    info = await GeneralServices()
        .getGeneralData(
      lang: Get.locale?.languageCode,
    )
        .catchError((dynamic error) {
      isLoading = false;
      setState(() {});
      errorHandler(error);
    });
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: size.topPadding),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width(mobile: 30),
                    vertical: size.height(mobile: 30),
                  ),
                  color: Colors.transparent,
                  child: CustomImage(imagePath: Dir.getIconPath("back")),
                ),
              ),
              Center(
                child: Text(
                  "about-us".tr,
                  style: Theme.of(context).textTheme.titleSmall,
                  textScaleFactor: 1,
                ),
              ),
              SizedBox(height: size.height(mobile: 50)),
              Expanded(
                child: isLoading
                    ? const Preloader()
                    : info?.about.aboutUs == null
                        ? const SizedBox()
                        : ListView(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width(mobile: 50)),
                            children: <Widget>[
                              HtmlWidget(
                                info!.about.aboutUs!.replaceAll("\n", "<br>"),
                                textStyle:
                                    Theme.of(context).textTheme.bodySmall,
                              ),
                              SizedBox(height: size.height(mobile: 120)),
                            ],
                          ),
              ),
            ],
          ),
          BottomNavBar(onPageChanged: (int page) {
            Get.offNamed(NavigationScreen.route_name, arguments: page);
          })
        ],
      ),
    );
  }
}
