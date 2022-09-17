import 'package:data/utils/validators.dart';
import 'package:domain/services/availability_services.dart';
import 'package:domain/services/reset_password_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "forgot-password-screen";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey =
      GlobalKey(debugLabel: "forgot-password-screen");

  final TextEditingController emailController = TextEditingController();
  Future<void> sendEmail() async {
    if (formKey.currentState?.validate() == true) {
      Get.dialog(const Preloader(), barrierDismissible: false);
      bool available = await AvailabilityServices()
          .checkEmailAvailability(
        email: emailController.text,
        lang: Get.locale?.languageCode,
      )
          .catchError((dynamic error) {
        Get.back();
        errorHandler(error);
      });
      if (available) {
        String code = ResetPasswordServices().generateRandomNumbersString();
        // ignore: avoid_print
        print("The verification code is: $code");
        bool sent = await ResetPasswordServices()
            .sendEmailVerificationCode(
          email: emailController.text,
          verificationCode: code,
          lang: Get.locale?.languageCode,
        )
            .catchError((dynamic error) {
          Get.back();
          errorHandler(error);
        });
        if (sent) {
          Get.back();
          Get.dialog(
            VerifyCodeDialog(
              email: emailController.text,
              code: code,
            ),
            barrierDismissible: false,
          );
        }
      } else {
        Get.back();
        errorHandler("email-not-found".tr);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: size.height(mobile: 10) + size.topPadding),
          CustomImage(
            imagePath: Dir.getLogoPath("logo"),
            width: size.width(mobile: 52),
          ),
          SizedBox(height: size.height(mobile: 15)),
          Text(
            "forgot-password".tr,
            style: Theme.of(context).textTheme.titleSmall,
            textScaleFactor: 1,
          ),
          SizedBox(height: size.height(mobile: 40)),
          Form(
            key: formKey,
            child: Expanded(
                child: ListView(
              padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 35)),
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: size.width(mobile: 4)),
                  child: Text(
                    "email".tr.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ),
                SizedBox(height: size.height(mobile: 7)),
                CustomTextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validate: Validators.validateEmail,
                  onSubmit: (_) => sendEmail(),
                ),
                SizedBox(height: size.height(mobile: 50)),
                Button(
                  onTap: sendEmail,
                  child: Text(
                    "send".tr,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                    textScaleFactor: 1,
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
