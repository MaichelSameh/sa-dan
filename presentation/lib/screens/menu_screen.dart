import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';
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
                          buildItem(
                            size: size,
                            context: context,
                            label: "my-orders".tr,
                          ),
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
                          buildItem(
                            size: size,
                            context: context,
                            label: "notifications".tr,
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
                          GestureDetector(
                            onTap: () {
                              //TODO add the logout function
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
