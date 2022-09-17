import 'dart:ui';

import 'package:domain/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import '../controllers/home_controller.dart';
import '../controllers/user_controller.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Stack(
      children: <Widget>[
        Row(
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                width: size.width(mobile: 292),
                height: double.infinity,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: size.height(mobile: 207),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width(mobile: 45)),
                      color: Palette.secondary_color,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: size.height(mobile: 55)),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(size.width(mobile: 75)),
                            child: CustomImage(
                              imagePath:
                                  Get.find<UserController>().token?.logoUrl ??
                                      Dir.getImagePath("person-placeholder"),
                              width: size.width(mobile: 75),
                              height: size.width(mobile: 75),
                            ),
                          ),
                          if (Get.find<UserController>().token !=
                              null) ...<Widget>[
                            SizedBox(height: size.height(mobile: 10)),
                            Text(
                              "${"hi-there".tr} ${Get.find<UserController>().token!.name}!",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textScaleFactor: 1,
                            ),
                            Text(
                              Get.find<UserController>().token!.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                              textScaleFactor: 1,
                            ),
                          ]
                        ],
                      ),
                    ),
                    SizedBox(height: size.height(mobile: 15)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width(mobile: 45)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildItem(
                            size: size,
                            context: context,
                            label: "home".tr,
                            onTap: () {
                              Get.toNamed(NavigationScreen.route_name);
                            },
                          ),
                          buildItem(
                            size: size,
                            context: context,
                            label: "language".tr,
                            onTap: () {
                              Get.toNamed(
                                LanguageScreen.route_name,
                                arguments: () => Get.back(),
                              );
                            },
                          ),
                          if (Get.find<UserController>().token != null)
                            buildItem(
                              size: size,
                              context: context,
                              label: "my-orders".tr,
                              onTap: () {
                                Get.toNamed(OrdersScreen.route_name);
                              },
                            ),
                          if (Get.find<UserController>().token != null)
                            buildItem(
                              size: size,
                              context: context,
                              label: "profile-setting".tr,
                              onTap: () {
                                Get.toNamed(
                                  NavigationScreen.route_name,
                                  arguments: 3,
                                );
                              },
                            ),
                          if (Get.find<UserController>().token != null)
                            buildItem(
                              size: size,
                              context: context,
                              label: "notifications".tr,
                              onTap: () {
                                Get.toNamed(NotificationsScreen.route_name);
                              },
                            ),
                          if (Get.find<UserController>().token != null)
                            buildItem(
                              size: size,
                              context: context,
                              label: "location".tr,
                              onTap: () {
                                Get.toNamed(AddressesScreen.route_name);
                              },
                            ),
                          buildItem(
                            size: size,
                            context: context,
                            label: "about".tr,
                            onTap: () {
                              Get.toNamed(AboutUsScreen.route_name);
                            },
                          ),
                          buildItem(
                            size: size,
                            context: context,
                            label: "contact-us".tr,
                            onTap: () {
                              Get.toNamed(ContactUsScreen.route_name);
                            },
                          ),
                          buildItem(
                            size: size,
                            context: context,
                            label: "terms-conditions".tr,
                            onTap: () {
                              Get.toNamed(TermsConditionsScreen.route_name);
                            },
                          ),
                          if (Get.find<UserController>().token != null)
                            GestureDetector(
                              onTap: () async {
                                Get.dialog(const Preloader(),
                                    barrierDismissible: false);
                                bool _ = await AuthServices()
                                    .logout(
                                        token: Get.find<UserController>()
                                            .token!
                                            .token
                                            .combinedToken)
                                    .catchError((dynamic error) {
                                  Get.back();
                                  errorHandler(error);
                                });
                                Get.back();
                                Get.find<UserController>().setToken(null);
                                await Get.delete<HomeController>();
                                Get.offAllNamed(SplashScreen.route_name);
                              },
                              child: Container(
                                width: double.infinity,
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height(mobile: 20)),
                                child: Text(
                                  "sign-out".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Palette.primary_color,
                                        decoration: TextDecoration.underline,
                                      ),
                                  textScaleFactor: 1,
                                ),
                              ),
                            )
                          else
                            buildItem(
                              size: size,
                              context: context,
                              label: "sign-in".tr,
                              onTap: () {
                                Get.toNamed(LoginScreen.route_name);
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: size.width(mobile: 83),
                height: double.infinity,
                color: const Color.fromRGBO(0, 0, 0, 0.65),
              ),
            )
          ],
        ),
        GestureDetector(
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            if (details.delta.dx.abs() < 20) {
              return;
            }
            if ((details.primaryDelta ?? 0) > 0 &&
                Directionality.of(context) == TextDirection.rtl) {
              Get.back();
            } else if ((details.primaryDelta ?? 0) < 0 &&
                Directionality.of(context) == TextDirection.ltr) {
              Get.back();
            }
          },
        )
      ],
    );
  }

  Widget buildItem({
    required Size size,
    required BuildContext context,
    required String label,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        Get.back();
        onTap?.call();
      },
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: size.height(mobile: 20)),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
          textScaleFactor: 1,
        ),
      ),
    );
  }
}
