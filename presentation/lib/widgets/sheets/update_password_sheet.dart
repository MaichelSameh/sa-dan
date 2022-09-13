import 'package:data/utils/validators.dart';
import 'package:domain/services/reset_password_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../controllers/controllers.dart';
// import '../../screens/auth/send_verification_code_screen.dart';
import '../widgets.dart';
import 'sheet_layout.dart';

void showUpdatePasswordSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    builder: (_) => const UpdatePasswordSheet(),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
  );
}

class UpdatePasswordSheet extends StatefulWidget {
  const UpdatePasswordSheet({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordSheet> createState() => _UpdatePasswordSheetState();
}

class _UpdatePasswordSheetState extends State<UpdatePasswordSheet> {
  GlobalKey<FormState> formKey = GlobalKey(debugLabel: "update-password-form");
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SheetLayout(
          body: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 15)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomTextFormField(
                    controller: oldPasswordController,
                    label: "old-password".tr,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    validate: (String? text) =>
                        Validators.validateName(text ?? ""),
                  ),
                  SizedBox(height: size.height(mobile: 16)),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      // Get.toNamed(SendVerificationCodeScreen.route_name);
                    },
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        "forgot-password?".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height(mobile: 34)),
                  CustomTextFormField(
                    controller: newPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    label: "new-password".tr,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    validate: (String? text) =>
                        Validators.validatePassword(text ?? ""),
                  ),
                  SizedBox(height: size.height(mobile: 21)),
                  CustomTextFormField(
                    controller: confirmNewPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    label: "repeat-new-password".tr,
                    validate: (String? text) =>
                        Validators.validateName(text ?? ""),
                  ),
                  SizedBox(height: size.height(mobile: 43)),
                  Button(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState?.validate() == true) {
                        Get.dialog(const Preloader(),
                            barrierDismissible: false);
                        // ignore: no_leading_underscores_for_local_identifiers
                        bool _ = await ResetPasswordServices()
                            .updatePassword(
                          oldPassword: oldPasswordController.text,
                          newPassword: newPasswordController.text,
                          confirmPassword: confirmNewPasswordController.text,
                          token: Get.find<UserController>()
                              .token!
                              .token
                              .combinedToken,
                        )
                            .catchError((dynamic error) {
                          Get.back();
                          errorHandler(error);
                        });
                        Get.back();
                        Get.back();
                      }
                    },
                    child: Text(
                      "save-password".tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: size.bottomPadding + size.height(mobile: 30),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
