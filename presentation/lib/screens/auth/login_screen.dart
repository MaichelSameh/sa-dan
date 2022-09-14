import 'package:data/models/local_token_info.dart';
import 'package:data/utils/validators.dart';
import 'package:domain/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/widgets.dart';
import '../navigation/navigation_screen.dart';
import 'sign_up/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "login-screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "login-form");

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;

  Future<void> login() async {
    if (formKey.currentState?.validate() == true) {
      Get.dialog(const Preloader(), barrierDismissible: false);
      LocalTokenInfo res = await AuthServices()
          .login(
        email: emailController.text,
        password: passwordController.text,
        lang: Get.locale?.languageCode,
      )
          .catchError((dynamic error) {
        Get.back();
        errorHandler(error);
      });
      Get.find<UserController>().setToken(res);
      Get.offAllNamed(NavigationScreen.route_name);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context);
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
            "sign-in".tr,
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
                  textInputAction: TextInputAction.next,
                  validate: Validators.validateEmail,
                ),
                SizedBox(height: size.height(mobile: 14)),
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
                  textInputAction: TextInputAction.done,
                  validate: Validators.validateName,
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
                  onSubmit: (_) => login(),
                ),
                SizedBox(height: size.height(mobile: 50)),
                Button(
                  onTap: login,
                  child: Text(
                    "sign-in".tr,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "do-not-have-account".tr,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: const Color.fromRGBO(69, 123, 157, 1)),
                textScaleFactor: 1,
              ),
              SizedBox(width: size.width(mobile: 5)),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Get.toNamed(SignUpScreen.route_name);
                },
                child: Text(
                  "sign-up".tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Palette.primary_color),
                  textScaleFactor: 1,
                ),
              )
            ],
          ),
          SizedBox(height: size.height(mobile: 40) + size.bottomPadding),
        ],
      ),
    );
  }
}
