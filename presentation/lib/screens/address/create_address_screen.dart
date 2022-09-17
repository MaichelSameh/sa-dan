import 'package:data/enums.dart';
import 'package:data/models/address_info.dart';
import 'package:data/utils/validators.dart';
import 'package:domain/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/widgets.dart';

class CreateAddressScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "create-address-scree";
  const CreateAddressScreen({Key? key}) : super(key: key);

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "create-location-form");

  final AddressInfo? oldAddress = Get.arguments;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  bool canUpdate = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    nameController.addListener(checkIfCanUpdate);
    phoneController.addListener(checkIfCanUpdate);
    countryController.addListener(checkIfCanUpdate);
    cityController.addListener(checkIfCanUpdate);
    streetNameController.addListener(checkIfCanUpdate);
    postalCodeController.addListener(checkIfCanUpdate);
  }

  void init() {
    nameController.text =
        (oldAddress?.name ?? Get.find<UserController>().token?.name ?? "");
    phoneController.text = (oldAddress?.phone ??
        Get.find<UserController>().token?.phoneNumber ??
        "");
    countryController.text = (oldAddress?.country ?? "");
    cityController.text = (oldAddress?.country ?? "");
    streetNameController.text = (oldAddress?.country ?? "");
    postalCodeController.text = (oldAddress?.country ?? "");
  }

  Future<void> addAddress() async {
    if (formKey.currentState?.validate() == true) {
      Get.dialog(const Preloader(), barrierDismissible: false);
      AddressInfo address = AddressInfo(
        name: nameController.text,
        ownerId: Get.find<UserController>().token!.token.combinedToken,
        city: cityController.text,
        country: countryController.text,
        createdAt: DateTime.now(),
        id: oldAddress?.id ?? "",
        phone: phoneController.text,
        postalCode: postalCodeController.text,
        streetName: streetNameController.text,
        type: AddressType.work,
      );
      if (oldAddress == null) {
        AddressInfo _ = await AddressServices()
            .addNew(
          item: address,
          token: Get.find<UserController>().token!.token.combinedToken,
        )
            .catchError((dynamic error) {
          Get.back();
          errorHandler(error);
        });
      } else {
        AddressInfo _ = await AddressServices()
            .updateItem(
          item: address,
          token: Get.find<UserController>().token!.token.combinedToken,
        )
            .catchError((dynamic error) {
          Get.back();
          errorHandler(error);
        });
      }
      Get.back();
      await successHandler("location-added".tr);
      Get.back();
    }
  }

  void checkIfCanUpdate() {
    bool temp = nameController.text !=
            (oldAddress?.name ??
                Get.find<UserController>().token?.name ??
                "") ||
        phoneController.text !=
            (oldAddress?.phone ??
                Get.find<UserController>().token?.phoneNumber ??
                "") ||
        countryController.text != (oldAddress?.country ?? "") ||
        cityController.text != (oldAddress?.country ?? "") ||
        streetNameController.text != (oldAddress?.country ?? "") ||
        postalCodeController.text != (oldAddress?.country ?? "");
    if (temp != canUpdate) {
      canUpdate = temp;
      setState(() {});
    }
  }

  @override
  void setState(VoidCallback fn) {
    checkIfCanUpdate();
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 15)),
          child: Column(
            children: <Widget>[
              SizedBox(height: size.topPadding),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: GestureDetector(
                        onTap: Get.back,
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(size.width(mobile: 22)),
                          child:
                              CustomImage(imagePath: Dir.getIconPath("back")),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "shipping-locations".tr,
                    style: Theme.of(context).textTheme.titleMedium,
                    textScaleFactor: 1,
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: size.height(mobile: 20)),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    Size size = Size(
                      context: context,
                      constrain: constraints,
                      customModelWidth: constraints.maxWidth,
                    );
                    return ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        CustomTextFormField(
                          label: "name".tr,
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          validate: (String? text) =>
                              Validators.validateName(text ?? ""),
                        ),
                        buildFieldDivider(size),
                        CustomTextFormField(
                          label: "phone".tr,
                          controller: phoneController,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          validate: (String? text) =>
                              Validators.validateName(text ?? ""),
                        ),
                        buildFieldDivider(size),
                        CustomTextFormField(
                          label: "country".tr,
                          controller: countryController,
                          textInputAction: TextInputAction.next,
                          validate: (String? text) =>
                              Validators.validateName(text ?? ""),
                        ),
                        buildFieldDivider(size),
                        CustomTextFormField(
                          label: "city".tr,
                          controller: cityController,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          validate: (String? text) =>
                              Validators.validateName(text ?? ""),
                        ),
                        buildFieldDivider(size),
                        CustomTextFormField(
                          label: "postal-code".tr,
                          controller: postalCodeController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validate: (String? text) =>
                              Validators.validateNumber(text ?? ""),
                        ),
                        buildFieldDivider(size),
                        CustomTextFormField(
                          label: "street-name".tr,
                          controller: streetNameController,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          validate: (String? text) =>
                              Validators.validateName(text ?? ""),
                        ),
                        buildFieldDivider(size),
                        Visibility(
                          visible: canUpdate,
                          child: Column(
                            children: <Widget>[
                              Button(
                                onTap: addAddress,
                                child: Text(
                                  "save-location".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                  textScaleFactor: 1,
                                ),
                              ),
                              SizedBox(
                                  height: size.height(mobile: 30) +
                                      size.bottomPadding),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildFieldDivider(Size size) =>
      SizedBox(height: size.height(mobile: 15));
}
