import 'package:flutter/material.dart';

import '../config/config.dart';
import 'custom_image.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Size(context);
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: size.height(mobile: 35)),
          child: Container(
            height: size.height(mobile: 77),
            width: double.infinity,
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
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
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
      ],
    );
  }
}
