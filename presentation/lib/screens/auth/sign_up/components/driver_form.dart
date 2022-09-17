import 'package:data/models/local_token_info.dart';
import 'package:data/utils/validators.dart';
import 'package:domain/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/config.dart';
import '../../../../controllers/user_controller.dart';
import '../../../../widgets/widgets.dart';
import '../../../navigation/navigation_screen.dart';

class DriverForm extends StatefulWidget {
  const DriverForm({super.key});

  @override
  State<DriverForm> createState() => _DriverFormState();
}

class _DriverFormState extends State<DriverForm> {
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "driver-registration-form");

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  bool hidePassword = true;

  Future<void> signUp() async {
    if (formKey.currentState?.validate() == true) {
      Get.dialog(const Preloader(), barrierDismissible: false);
      LocalTokenInfo res = await AuthServices()
          .driverSignUp(
        email: emailController.text,
        password: passwordController.text,
        fullName: nameController.text,
        phone: phoneController.text,
        city: cityController.text,
        country: countryController.text,
        nationalId: nationalIdController.text,
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
    Size size = Size(context: context);
    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 35)),
        children: <Widget>[
          SizedBox(height: size.height(mobile: 20)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 4)),
            child: Text(
              "name".tr.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
              textScaleFactor: 1,
            ),
          ),
          SizedBox(height: size.height(mobile: 7)),
          CustomTextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validate: Validators.validateEmail,
          ),
          SizedBox(height: size.height(mobile: 14)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 4)),
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
            padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 4)),
            child: Text(
              "phone".tr.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
              textScaleFactor: 1,
            ),
          ),
          SizedBox(height: size.height(mobile: 7)),
          CustomTextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validate: Validators.validateEmail,
          ),
          SizedBox(height: size.height(mobile: 14)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 4)),
            child: Text(
              "national-id".tr.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
              textScaleFactor: 1,
            ),
          ),
          SizedBox(height: size.height(mobile: 7)),
          CustomTextFormField(
            controller: nationalIdController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            validate: Validators.validateNumber,
          ),
          SizedBox(height: size.height(mobile: 14)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width(mobile: 4)),
                    child: Text(
                      "country".tr.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                      textScaleFactor: 1,
                    ),
                  ),
                  SizedBox(height: size.height(mobile: 7)),
                  CustomTextFormField(
                    controller: countryController,
                    width: size.width(mobile: 145),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validate: Validators.validateName,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width(mobile: 4)),
                    child: Text(
                      "city".tr.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                      textScaleFactor: 1,
                    ),
                  ),
                  SizedBox(height: size.height(mobile: 7)),
                  CustomTextFormField(
                    controller: cityController,
                    width: size.width(mobile: 145),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validate: Validators.validateName,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: size.height(mobile: 14)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 4)),
            child: Text(
              "postal-code".tr.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
              textScaleFactor: 1,
            ),
          ),
          SizedBox(height: size.height(mobile: 7)),
          CustomTextFormField(
            controller: postalCodeController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            validate: Validators.validateEmail,
          ),
          SizedBox(height: size.height(mobile: 14)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 4)),
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
                    imagePath: Dir.getIconPath(hidePassword ? "hide" : "show"),
                  ),
                );
              }),
            ),
            onSubmit: (_) => signUp(),
          ),
          SizedBox(height: size.height(mobile: 50)),
          Button(
            onTap: signUp,
            child: Text(
              "sign-up".tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
              textScaleFactor: 1,
            ),
          ),
          SizedBox(height: size.height(mobile: 10)),
        ],
      ),
    );
  }
}
