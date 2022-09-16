import 'package:data/models/general/general_info.dart';
import 'package:domain/services/general_services.dart';
import 'package:domain/services/url_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_image.dart';
import '../widgets/error_handler.dart';
import '../widgets/preloader.dart';
import 'navigation/navigation_screen.dart';

class ContactUsScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "contact-us-screen";
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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
    Size size = Size(context);
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
                  "contact-us".tr,
                  style: Theme.of(context).textTheme.titleSmall,
                  textScaleFactor: 1,
                ),
              ),
              SizedBox(height: size.height(mobile: 50)),
              Expanded(
                child: isLoading
                    ? const Preloader()
                    : info?.social == null
                        ? const SizedBox()
                        : GridView(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: size.width(mobile: 160),
                              childAspectRatio: 160 / 145,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 14,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width(mobile: 20)),
                            children: <Widget>[
                              for (Map<String, String> link
                                  in <Map<String, String>>[
                                if (info!.social.facebook != null)
                                  <String, String>{
                                    "link": info!.social.facebook!,
                                    "icon": "facebook",
                                    "title": "facebook".tr,
                                  },
                                if (info!.social.twitter != null)
                                  <String, String>{
                                    "link": info!.social.twitter!,
                                    "icon": "twitter",
                                    "title": "twitter".tr,
                                  },
                                if (info!.social.instagram != null)
                                  <String, String>{
                                    "link": info!.social.instagram!,
                                    "icon": "instagram",
                                    "title": "instagram".tr,
                                  },
                                if (info!.social.youtube != null)
                                  <String, String>{
                                    "link": info!.social.youtube!,
                                    "icon": "youtube",
                                    "title": "youtube".tr,
                                  },
                              ])
                                LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return GestureDetector(
                                      onTap: () {
                                        UrlServices().launchUrl(link["link"]!);
                                      },
                                      child: Container(
                                        width: constraints.maxWidth,
                                        height: constraints.maxHeight,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          boxShadow: const <BoxShadow>[
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.08),
                                              blurRadius: 15,
                                              offset: Offset(4, 4),
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              constraints.maxHeight *
                                                  (15 / 145)),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            const Spacer(flex: 2),
                                            CustomImage(
                                                imagePath: Dir.getIconPath(
                                                    link["icon"]!)),
                                            const Spacer(),
                                            SizedBox(
                                              width: constraints.maxWidth -
                                                  constraints.maxWidth / 5,
                                              child: Text(
                                                link["title"]!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                textScaleFactor: 1,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const Spacer(flex: 2),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
