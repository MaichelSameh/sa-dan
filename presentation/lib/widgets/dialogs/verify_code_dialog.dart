import 'dart:async';

import 'package:domain/services/reset_password_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../config/config.dart';
import '../../screens/auth/reset_password_screen.dart';
import '../button.dart';
import '../error_handler.dart';
import '../preloader.dart';

class VerifyCodeDialog extends StatefulWidget {
  final String email;
  final String code;
  const VerifyCodeDialog({
    Key? key,
    required this.email,
    required this.code,
  }) : super(key: key);

  @override
  State<VerifyCodeDialog> createState() => _VerifyCodeDialogState();
}

class _VerifyCodeDialogState extends State<VerifyCodeDialog> {
  late String code;

  final TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    code = widget.code;
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void verifyCode(String enteredCode) {
    if (code.length != enteredCode.length) {
      return;
    }
    if (enteredCode == code) {
      Get.back();
      Get.offNamed(ResetPasswordScreen.route_name, arguments: widget.email);
    } else {
      errorHandler("code-error".tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Center(
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          height: size.height(mobile: 320),
          margin: EdgeInsets.symmetric(horizontal: size.width(mobile: 25)),
          padding: EdgeInsets.symmetric(
            horizontal: size.width(mobile: 30),
            vertical: size.height(mobile: 30),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.width(mobile: 20)),
          ),
          child: Column(
            children: <Widget>[
              Text(
                "enter-code".tr,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.black),
              ),
              SizedBox(height: size.height(mobile: 5)),
              Text(
                "we-sent-code".trParams(
                  <String, String>{
                    "phone":
                        "${widget.email.split("@").first.replaceRange(3, widget.email.split("@").first.length, "*****")}@${widget.email.split("@").last}",
                  },
                ),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: Get.locale?.languageCode == "ar" ? 12 : 14,
                      color: const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: size.width(mobile: 25)),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: size.height(mobile: 5)),
                    SizedBox(
                      height: size.height(mobile: 60),
                      child: MaterialApp(
                        theme: Theme.of(context),
                        debugShowCheckedModeBanner: false,
                        home: PinCodeTextField(
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                          keyboardType: TextInputType.phone,
                          appContext: context,
                          length: 4,
                          controller: codeController,
                          pinTheme: PinTheme(
                            activeColor: Palette.secondary_color,
                            inactiveColor: Palette.primary_color,
                            selectedColor: Palette.secondary_color,
                          ),
                          onChanged: verifyCode,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height(mobile: 25)),
                    Button(
                      onTap: () {
                        verifyCode(codeController.text);
                      },
                      child: Text(
                        "verify".tr.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: size.height(mobile: 20)),
                    ResendCode(
                      email: widget.email,
                      onCodeChanges: (String code) {
                        setState(() {
                          this.code = code;
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResendCode extends StatefulWidget {
  final String email;
  final Function(String) onCodeChanges;
  const ResendCode({
    Key? key,
    required this.email,
    required this.onCodeChanges,
  }) : super(key: key);

  @override
  State<ResendCode> createState() => ResendCodeState();
}

class ResendCodeState extends State<ResendCode> {
  int turnNumber = 1;
  int waitingSeconds = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        waitingSeconds--;
      });
      if (waitingSeconds == 0) {
        timer!.cancel();
      }
    });
  }

  Future<void> resendCode() async {
    Get.dialog(const Preloader(), barrierDismissible: false);
    ResetPasswordServices service = ResetPasswordServices();
    String code = service.generateRandomNumbersString();
    await service
        .sendEmailVerificationCode(
      email: widget.email,
      verificationCode: code,
      lang: Get.locale?.languageCode ?? "en",
    )
        .catchError((dynamic error, StackTrace trace) {
      Get.back();
      errorHandler(error);
    });
    widget.onCodeChanges(code);
    turnNumber = turnNumber * 2;
    waitingSeconds = 30 * turnNumber;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        waitingSeconds--;
      });
      if (waitingSeconds == 0) {
        timer!.cancel();
      }
    });
    setState(() {});
    // ignore: avoid_print
    print("The verification code is: $code");
    Get.back();
    setState(() {});
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return GestureDetector(
      onTap: waitingSeconds > 0 ? null : resendCode,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 20)),
        child: Text(
          "resend-code".tr + (waitingSeconds > 0 ? " ($waitingSeconds)" : ""),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: waitingSeconds == 0
                    ? const Color.fromRGBO(238, 28, 37, 1)
                    : Colors.black.withOpacity(0.2),
              ),
        ),
      ),
    );
  }
}
