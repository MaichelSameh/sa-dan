import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
// import '../../screens/auth/login_screen.dart';
import '../widgets.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Size(context);
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width(mobile: 24)),
        padding: EdgeInsets.symmetric(
            horizontal: size.width(mobile: 24),
            vertical: size.height(mobile: 25)),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomImage(imagePath: Dir.getIllustrationPath("login")),
            SizedBox(height: size.height(mobile: 24)),
            Text(
              "error".tr,
              style: Theme.of(context).textTheme.titleMedium,
              textScaleFactor: 1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height(mobile: 8)),
            Text(
              "need-login".tr,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: const Color.fromRGBO(155, 155, 155, 1)),
              textScaleFactor: 1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height(mobile: 24)),
            Button(
              onTap: () {
                // Get.toNamed(LoginScreen.route_name);
              },
              child: Text(
                "login".tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
                textScaleFactor: 1,
              ),
            ),
            SizedBox(height: size.height(mobile: 12)),
            Button(
              onTap: Get.back,
              color: Colors.transparent,
              child: Text(
                "okay".tr,
                style: Theme.of(context).textTheme.bodyMedium,
                textScaleFactor: 1,
              ),
            ),
            SizedBox(height: size.height(mobile: 12)),
          ],
        ),
      ),
    );
  }
}
