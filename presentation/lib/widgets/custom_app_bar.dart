import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import '../screens/menu_screen.dart';
import '../screens/notifications_screen.dart';
import 'custom_image.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final bool showNotification;
  final bool showMenu;
  const CustomAppBar({
    Key? key,
    this.title,
    this.showNotification = true,
    this.showMenu = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: showMenu
              ? GestureDetector(
                  onTap: () {
                    Get.to(
                      const MenuScreen(),
                      transition:
                          Directionality.of(context) == TextDirection.ltr
                              ? Transition.leftToRight
                              : Transition.rightToLeft,
                      opaque: false,
                    );
                  },
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width(mobile: 30),
                        vertical: size.height(mobile: 15),
                      ),
                      child: CustomImage(imagePath: Dir.getIconPath("menu")),
                    ),
                  ),
                )
              : const SizedBox(),
        ),
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.titleSmall,
            textScaleFactor: 1,
          ),
        Expanded(
          child: showNotification
              ? GestureDetector(
                  onTap: () {
                    Get.toNamed(NotificationsScreen.route_name);
                  },
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width(mobile: 30),
                        vertical: size.height(mobile: 15),
                      ),
                      child: CustomImage(
                          imagePath: Dir.getIconPath("notification")),
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
