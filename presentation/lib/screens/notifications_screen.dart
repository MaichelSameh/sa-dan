import 'package:data/date_formatter.dart';
import 'package:data/models/notification_info.dart';
import 'package:domain/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import '../controllers/user_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/error_handler.dart';
import '../widgets/preloader.dart';

class NotificationsScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "notifications-screen";
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationInfo> notifications = <NotificationInfo>[];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    if (Get.find<UserController>().token == null) {
      isLoading = false;
      return;
    }
    notifications = await NotificationServices()
        .getAllNotification(
      token: Get.find<UserController>().token!.token.combinedToken,
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
      body: Column(
        children: <Widget>[
          SizedBox(height: size.topPadding),
          CustomAppBar(
            title: "notifications".tr,
            showNotification: false,
          ),
          SizedBox(height: size.height(mobile: 15)),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  Size size = Size(
                    context: context,
                    constrain: constraints,
                    customModelWidth: constraints.maxWidth,
                  );
                  return isLoading
                      ? const Preloader()
                      : Get.find<UserController>().token == null
                          ? Center(
                              child: Text(
                                "need-login".tr,
                                style: Theme.of(context).textTheme.bodyMedium,
                                textScaleFactor: 1,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView(
                              padding: EdgeInsets.zero,
                              children: <Widget>[
                                for (NotificationInfo notification
                                    in notifications)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width(mobile: 25)),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                            height: size.height(mobile: 15)),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: size.width(mobile: 8),
                                              height: size.width(mobile: 8),
                                              decoration: const BoxDecoration(
                                                color: Palette.secondary_color,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(
                                                width: size.width(mobile: 10)),
                                            SizedBox(
                                              width: size.width(mobile: 290),
                                              child: Text(
                                                notification.message,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                textScaleFactor: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: size.height(mobile: 10)),
                                        Text(
                                          dateFormatter(
                                            notification.createdAt,
                                            pattern: "y MMMM, EE HH:mm",
                                            useLocalizedDate: true,
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                          textScaleFactor: 1,
                                        ),
                                        SizedBox(
                                            height: size.height(mobile: 15)),
                                        Center(
                                          child: Container(
                                            width: size.width(mobile: 272),
                                            height: 1,
                                            color: Palette.grey_color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
