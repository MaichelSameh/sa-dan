import 'dart:io';

import 'package:data/models/local_token_info.dart';
import 'package:data/models/profile_info.dart';
import 'package:data/utils/validators.dart';
import 'package:domain/services/profile_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/sheets/select_image_sheet.dart';
import '../../widgets/widgets.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> formKey =
      GlobalKey(debugLabel: "edit-profile-form");

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  ProfileInfo? profile;

  String? profileLogo;

  bool isLoading = true;
  bool canUpdate = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(checkIfCanUpdate);
    emailController.addListener(checkIfCanUpdate);
    phoneController.addListener(checkIfCanUpdate);
    init();
  }

  Future<void> init() async {
    if (Get.find<UserController>().token == null) {
      isLoading = false;
      return;
    }

    profile = await ProfileServices()
        .getProfile(
      token: Get.find<UserController>().token!.token.combinedToken,
      lang: Get.locale?.languageCode,
    )
        .catchError((dynamic error) {
      isLoading = false;
      setState(() {});
      errorHandler(error);
    });
    nameController.text = profile!.name;
    emailController.text = profile!.email;
    phoneController.text = profile!.phoneNumber;
    profileLogo = profile!.logoUrl;
    isLoading = false;
    checkIfCanUpdate();
    setState(() {});
  }

  void checkIfCanUpdate() {
    bool temp = nameController.text != profile?.name ||
        emailController.text != profile?.email ||
        phoneController.text != profile?.phoneNumber ||
        profileLogo != profile?.logoUrl;
    if (temp != canUpdate) {
      canUpdate = temp;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: size.height(mobile: 15) + size.topPadding),
          CustomAppBar(title: "profile".tr),
          Container(
            height: size.height(mobile: 1),
            width: double.infinity,
            color: Palette.primary_color,
          ),
          Expanded(
            child: isLoading
                ? const Preloader()
                : Get.find<UserController>().token == null
                    ? Center(
                        child: Text(
                          "need-login".tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textScaleFactor: 1,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          SizedBox(height: size.height(mobile: 50)),
                          GestureDetector(
                            onTap: () async {
                              File? image = await showImagePicker(context);
                              profileLogo = image?.path;
                              checkIfCanUpdate();
                              setState(() {});
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: <Widget>[
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          size.width(mobile: 105)),
                                      child: CustomImage(
                                        imagePath: profileLogo ??
                                            Dir.getImagePath(
                                                "person-placeholder"),
                                        height: size.width(mobile: 105),
                                        width: size.width(mobile: 105),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height(mobile: 10)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CustomImage(
                                          imagePath:
                                              Dir.getIconPath("add-image")),
                                      SizedBox(width: size.width(mobile: 9)),
                                      Text(
                                        "edit-photo".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontSize:
                                                    Get.locale?.languageCode ==
                                                            "ar"
                                                        ? 8
                                                        : 10,
                                                color: Palette.secondary_color),
                                        textScaleFactor: 1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: size.height(mobile: 12)),
                          Center(
                            child: Text(
                              "${"hi-there".tr} ${Get.find<UserController>().token!.name}!",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                              textScaleFactor: 1,
                            ),
                          ),
                          SizedBox(height: size.height(mobile: 12)),
                          Form(
                            key: formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width(mobile: 35)),
                              child: Column(
                                children: <Widget>[
                                  CustomTextFormField(
                                    label: "name".tr,
                                    color: Colors.transparent,
                                    controller: nameController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validate: Validators.validateName,
                                  ),
                                  SizedBox(height: size.height(mobile: 26)),
                                  CustomTextFormField(
                                    label: "email".tr,
                                    color: Colors.transparent,
                                    controller: emailController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    validate: Validators.validateEmail,
                                  ),
                                  SizedBox(height: size.height(mobile: 26)),
                                  CustomTextFormField(
                                    label: "phone".tr,
                                    color: Colors.transparent,
                                    controller: phoneController,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.phone,
                                    validate: Validators.validatePhoneNumber,
                                  ),
                                  SizedBox(height: size.height(mobile: 26)),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      showUpdatePasswordSheet(context);
                                    },
                                    child: CustomTextFormField(
                                      label: "password".tr,
                                      controller: TextEditingController(
                                          text: "1234567890"),
                                      obscureText: true,
                                      enabled: false,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(height: size.height(mobile: 30)),
                                  Visibility(
                                    visible: canUpdate,
                                    child: Button(
                                      onTap: () async {
                                        if (formKey.currentState?.validate() ==
                                            true) {
                                          Get.dialog(
                                            const Preloader(),
                                            barrierDismissible: false,
                                          );
                                          if (profileLogo != profile?.logoUrl) {
                                            await ProfileServices()
                                                .updateProfileLogo(
                                              token: Get.find<UserController>()
                                                  .token!
                                                  .token
                                                  .combinedToken,
                                              filePath: profileLogo ?? "",
                                              lang: Get.locale?.languageCode,
                                            )
                                                .catchError((dynamic error) {
                                              errorHandler(error);
                                            });
                                          }
                                          profile = await ProfileServices()
                                              .updateProfileData(
                                            token: Get.find<UserController>()
                                                .token!
                                                .token
                                                .combinedToken,
                                            email: emailController.text,
                                            fullName: nameController.text,
                                            phone: phoneController.text,
                                            lang: Get.locale?.languageCode,
                                          )
                                              .catchError((dynamic error) {
                                            Get.back();
                                            errorHandler(error);
                                          });
                                          Get.find<UserController>().setToken(
                                            LocalTokenInfo(
                                              token: Get.find<UserController>()
                                                  .token!
                                                  .token,
                                              type: profile!.type,
                                              name: nameController.text,
                                              phoneNumber: phoneController.text,
                                              email: emailController.text,
                                              userId: profile!.id,
                                              logoUrl: profile!.logoUrl,
                                            ),
                                          );
                                          Get.back();
                                          successHandler("profile-updated");
                                        }
                                      },
                                      child: Text(
                                        "save".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
