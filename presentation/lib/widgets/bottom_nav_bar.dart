import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import 'custom_image.dart';

class BottomNavBar extends StatelessWidget {
  final int? currentPage;
  final void Function(int) onPageChanged;
  const BottomNavBar({
    Key? key,
    this.currentPage,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: size.width(mobile: 35),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: size.height(mobile: 16),
                  bottom: size.height(mobile: 16) + size.bottomPadding,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width(mobile: 40)),
                    topRight: Radius.circular(size.width(mobile: 40)),
                  ),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 5,
                      offset: Offset(0, -1),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    buildNavItem(
                      size: size,
                      context: context,
                      iconName: "cart",
                      labelName: "home".tr,
                      index: 0,
                    ),
                    buildNavItem(
                      size: size,
                      context: context,
                      iconName: "category",
                      labelName: "categories".tr,
                      index: 1,
                    ),
                    const Spacer(),
                    buildNavItem(
                      size: size,
                      context: context,
                      iconName: "love",
                      labelName: "favorites".tr,
                      index: 2,
                    ),
                    buildNavItem(
                      size: size,
                      context: context,
                      iconName: "profile",
                      labelName: "profile".tr,
                      index: 3,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  onPageChanged(0);
                },
                child: Container(
                  width: size.width(mobile: 70),
                  height: size.width(mobile: 70),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(
                      width: 4,
                      color: const Color.fromRGBO(28, 31, 51, 1),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: CustomImage(
                      imagePath: Dir.getLogoPath("logo"),
                      height: size.height(mobile: 46),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Expanded buildNavItem({
    required Size size,
    required BuildContext context,
    required String iconName,
    required String labelName,
    required int index,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index != currentPage) {
            onPageChanged(index);
          }
        },
        child: Container(
          width: double.infinity,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomImage(
                imagePath: Dir.getIconPath(
                    iconName + (index == currentPage ? "-solid" : "")),
                color: Palette.primary_color,
              ),
              SizedBox(height: size.height(mobile: 5)),
              Text(
                labelName,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Palette.primary_color,
                      fontSize: Get.locale?.languageCode == "ar" ? 8 : 10,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
