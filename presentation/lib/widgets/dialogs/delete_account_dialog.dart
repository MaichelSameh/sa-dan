import 'package:domain/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../controllers/user_controller.dart';
import '../../screens/screens.dart';
import '../widgets.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Center(
      child: Container(
        width: size.width(mobile: 398),
        padding: EdgeInsets.symmetric(
          horizontal: size.width(mobile: 24),
          vertical: size.height(mobile: 21),
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(19, 19, 19, 1),
          borderRadius: BorderRadius.circular(size.width(mobile: 16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "delete-account-confirmation-question".tr,
              style: Theme.of(context).textTheme.titleSmall,
              textScaleFactor: 1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height(mobile: 10)),
            Text(
              "delete-account-confirmation-description".tr,
              style: Theme.of(context).textTheme.titleSmall,
              textScaleFactor: 1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height(mobile: 20)),
            Button(
              onTap: () async {
                Get.dialog(const Preloader(), barrierDismissible: false);
                bool deleted = await ProfileServices()
                    .deleteAccount(
                        token: Get.find<UserController>()
                            .token!
                            .token
                            .combinedToken,
                        lang: Get.locale?.languageCode)
                    .catchError((dynamic error) {
                  Get.back();
                  errorHandler(error);
                });
                Get.back();
                if (deleted) {
                  Get.find<UserController>().setToken(null);
                  Get.offAllNamed(SplashScreen.route_name);
                }
              },
              child: Text(
                "delete".tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
                textScaleFactor: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
