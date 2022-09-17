import 'package:data/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../widgets/widgets.dart';
import '../../navigation/navigation_screen.dart';
import '../login_screen.dart';
import 'components/customer_form.dart';
import 'components/driver_form.dart';

class SignUpScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "sign-up-screen";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  UserType selectedForm = UserType.customer;
  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: size.topPadding),
          GestureDetector(
            onTap: () {
              Get.offAllNamed(NavigationScreen.route_name);
            },
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  vertical: size.height(mobile: 10),
                  horizontal: size.width(mobile: 25),
                ),
                child: Text(
                  "skip".tr,
                  style: Theme.of(context).textTheme.bodySmall,
                  textScaleFactor: 1,
                ),
              ),
            ),
          ),
          CustomImage(
            imagePath: Dir.getLogoPath("logo"),
            width: size.width(mobile: 52),
          ),
          SizedBox(height: size.height(mobile: 15)),
          Text(
            "sign-up".tr,
            style: Theme.of(context).textTheme.titleSmall,
            textScaleFactor: 1,
          ),
          SizedBox(height: size.height(mobile: 30)),
          buildSwitcher(size),
          SizedBox(height: size.height(mobile: 10)),
          Expanded(
            child: selectedForm == UserType.customer
                ? const CustomerForm()
                : const DriverForm(),
          ),
          SizedBox(height: size.height(mobile: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "already-have-account".tr,
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
                  Get.toNamed(LoginScreen.route_name);
                },
                child: Text(
                  "sign-in".tr,
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

  TweenAnimationBuilder<double> buildSwitcher(Size size) {
    return TweenAnimationBuilder<double>(
        tween: Tween<double>(
            begin: selectedForm == UserType.customer ? 100 : 0,
            end: selectedForm != UserType.customer ? 100 : 0),
        duration: const Duration(milliseconds: 400),
        builder: (BuildContext context, double value, _) {
          return Center(
            child: Container(
              height: size.height(mobile: 40),
              width: size.width(mobile: 280),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.height(mobile: 30)),
                color: const Color.fromRGBO(247, 248, 249, 1),
                border:
                    Border.all(color: const Color.fromRGBO(100, 205, 234, 1)),
              ),
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth / 2,
                      margin: EdgeInsetsDirectional.only(
                        start: value / 100 * (constraints.maxWidth / 2),
                      ),
                      decoration: BoxDecoration(
                        color: Palette.secondary_color,
                        borderRadius:
                            BorderRadius.circular(constraints.maxHeight / 2),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        for (UserType form in <UserType>[
                          UserType.customer,
                          UserType.driver,
                        ])
                          Expanded(
                            child: GestureDetector(
                              onTap: selectedForm == form
                                  ? null
                                  : () async {
                                      selectedForm = form;
                                      setState(() {});
                                    },
                              child: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: Text(
                                    form.name.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: selectedForm == form
                                              ? Colors.white
                                              : Palette.primary_color,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                );
              }),
            ),
          );
        });
  }
}
