import 'package:data/models/category_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/config.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../widgets/custom_image.dart';
import '../../../../widgets/preloader.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  bool isLoaded = Get.find<HomeController>().isCategoriesLoaded;

  @override
  void initState() {
    super.initState();
    Get.find<HomeController>().addListener(() {
      if (Get.find<HomeController>().isCategoriesLoaded != isLoaded) {
        setState(() {
          isLoaded = Get.find<HomeController>().isCategoriesLoaded;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context);
    return !isLoaded
        ? const Preloader()
        : SizedBox(
            height: size.height(mobile: 105),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 20)),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                for (CategoryInfo category
                    in Get.find<HomeController>().categories)
                  Container(
                    color: Colors.transparent,
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width(mobile: 5)),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(size.width(mobile: 15)),
                          child: CustomImage(
                            imagePath: Dir.getImagePath(category.icon),
                            width: size.width(mobile: 77),
                            height: size.width(mobile: 79),
                          ),
                        ),
                        SizedBox(height: size.height(mobile: 5)),
                        Text(
                          category.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: Get.locale?.languageCode == "ar"
                                      ? 10
                                      : 12),
                          textScaleFactor: 1,
                        ),
                      ],
                    ),
                  )
              ],
            ),
          );
  }
}
