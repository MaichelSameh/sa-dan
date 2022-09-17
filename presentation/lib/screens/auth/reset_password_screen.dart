import 'package:data/utils/validators.dart';
import 'package:domain/services/reset_password_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../widgets/widgets.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "reset-password-screen";
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> formKey =
      GlobalKey(debugLabel: "reset-password-screen");

  final String email = Get.arguments;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  Future<void> reset() async {
    if (formKey.currentState?.validate() == true) {
      Get.dialog(const Preloader(), barrierDismissible: false);
      await ResetPasswordServices()
          .resetPasswordByEmail(
        email: email,
        confirmPassword: confirmPasswordController.text,
        password: passwordController.text,
        lang: Get.locale?.languageCode,
      )
          .catchError(
        (dynamic error) {
          Get.back();
          errorHandler(error);
        },
      );
      Get.back();
      Get.offAllNamed(LoginScreen.route_name);
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
            "reset-password".tr,
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
                    "password".tr.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ),
                SizedBox(height: size.height(mobile: 7)),
                CustomTextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  validate: Validators.validatePassword,
                  obscureText: hidePassword,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      hidePassword = !hidePassword;
                      setState(() {});
                    },
                    child: StatefulBuilder(builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return Padding(
                        padding: EdgeInsets.all(size.width(mobile: 15)),
                        child: CustomImage(
                          imagePath:
                              Dir.getIconPath(hidePassword ? "hide" : "show"),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: size.height(mobile: 14)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: size.width(mobile: 4)),
                  child: Text(
                    "confirm-password".tr.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ),
                SizedBox(height: size.height(mobile: 7)),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validate: (String? text) =>
                      Validators.validateConfirmPassword(
                          passwordController.text, text),
                  obscureText: hideConfirmPassword,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      hideConfirmPassword = !hideConfirmPassword;
                      setState(() {});
                    },
                    child: StatefulBuilder(builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return Padding(
                        padding: EdgeInsets.all(size.width(mobile: 15)),
                        child: CustomImage(
                          imagePath: Dir.getIconPath(
                              hideConfirmPassword ? "hide" : "show"),
                        ),
                      );
                    }),
                  ),
                  onSubmit: (_) => reset(),
                ),
                SizedBox(height: size.height(mobile: 50)),
                Button(
                  onTap: reset,
                  child: Text(
                    "reset".tr,
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
