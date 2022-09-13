import 'package:data/models/language_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import '../config/localization.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class LanguageScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "language-screen";
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Size(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: size.height(mobile: 10) + size.topPadding),
          CustomImage(imagePath: Dir.getLogoPath("logo")),
          SizedBox(height: size.height(mobile: 55)),
          Text(
            "select-language".tr,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.bold),
            textScaleFactor: 1,
          ),
          SizedBox(height: size.height(mobile: 55)),
          Expanded(
            child: GridView(
              padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 40)),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 134,
                childAspectRatio: 142 / 134,
                crossAxisSpacing: 30,
                mainAxisSpacing: 40,
              ),
              children: <Widget>[
                for (LanguageInfo language
                    in Localization.getInstance().supportedLanguages)
                  GestureDetector(
                    onTap: () {
                      Localization.getInstance()
                          .setLocale(language.getLocale());
                      setState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              language.languageCode == Get.locale?.languageCode
                                  ? Palette.primary_color
                                  : const Color.fromRGBO(151, 173, 182, 1),
                        ),
                        borderRadius:
                            BorderRadius.circular(size.width(mobile: 25)),
                        color: const Color.fromRGBO(247, 248, 249, 1),
                        boxShadow:
                            language.languageCode == Get.locale?.languageCode
                                ? const <BoxShadow>[
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ]
                                : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        language.languageTitle.tr,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: language.languageCode ==
                                      Get.locale?.languageCode
                                  ? Palette.primary_color
                                  : const Color.fromRGBO(151, 173, 182, 1),
                              fontWeight: FontWeight.bold,
                            ),
                        textScaleFactor: 1,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 30)),
            child: Button(
              onTap: () {
                Get.toNamed(OnboardingScreen.route_name);
              },
              child: Text(
                "next".tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
                textScaleFactor: 1,
              ),
            ),
          ),
          SizedBox(height: size.bottomPadding + size.height(mobile: 30)),
        ],
      ),
    );
  }
}
