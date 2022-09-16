import 'package:data/models/category_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../controllers/home_controller.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_text_field.dart';
import '../menu_screen.dart';
import 'home/components/banners_section.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = Size(context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: size.height(mobile: 15) + size.topPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Get.to(
                    const MenuScreen(),
                    transition: Directionality.of(context) == TextDirection.ltr
                        ? Transition.leftToRight
                        : Transition.rightToLeft,
                    opaque: false,
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width(mobile: 30),
                    vertical: size.height(mobile: 15),
                  ),
                  child: CustomImage(imagePath: Dir.getIconPath("menu")),
                ),
              ),
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width(mobile: 30),
                  vertical: size.height(mobile: 15),
                ),
                child: CustomImage(imagePath: Dir.getIconPath("notification")),
              ),
            ],
          ),
          SizedBox(height: size.height(mobile: 13)),
          const BannersSection(),
          SizedBox(height: size.height(mobile: 13)),
          Center(
            child: CustomTextFormField(
              width: size.width(mobile: 260),
              height: 30,
              padding: EdgeInsets.symmetric(
                horizontal: size.width(mobile: 12),
              ),
              controller: searchController,
              textInputAction: TextInputAction.search,
              hint: "search-hint".tr,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: Get.locale?.languageCode == "ar" ? 6 : 8),
              hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: Get.locale?.languageCode == "ar" ? 6 : 8,
                    color: Palette.primary_color,
                  ),
              prefixWidget: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height(mobile: 6)),
                child: CustomImage(imagePath: Dir.getIconPath("search")),
              ),
            ),
          ),
          SizedBox(height: size.height(mobile: 9)),
          for (CategoryInfo category in Get.find<HomeController>().categories)
            Container(
              width: double.infinity,
              height: size.width(mobile: 75),
              margin: EdgeInsets.symmetric(
                  horizontal: size.width(mobile: 22),
                  vertical: size.height(mobile: 9)),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsetsDirectional.only(
                      start: size.width(mobile: 40),
                      end: size.width(mobile: 14),
                    ),
                    padding: EdgeInsetsDirectional.only(
                      start: size.width(mobile: 40),
                      end: size.width(mobile: 20),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(size.width(mobile: 20)),
                        bottomStart: Radius.circular(size.width(mobile: 20)),
                        topEnd: Radius.circular(size.width(mobile: 10)),
                        bottomEnd: Radius.circular(size.width(mobile: 10)),
                      ),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      category.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textScaleFactor: 1,
                      softWrap: true,
                      maxLines: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: size.width(mobile: 70),
                        height: size.width(mobile: 70),
                        padding: EdgeInsets.all(size.width(mobile: 4)),
                        decoration: BoxDecoration(
                          border: Border.all(color: Palette.primary_color),
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(size.width(mobile: 70)),
                          child: CustomImage(
                            imagePath: category.icon,
                            width: size.width(mobile: 60),
                            height: size.width(mobile: 60),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width(mobile: 27),
                        height: size.width(mobile: 27),
                        padding: EdgeInsets.all(size.width(mobile: 6)),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: CustomImage(imagePath: Dir.getIconPath("next")),
                      ),
                    ],
                  )
                ],
              ),
            ),
          SizedBox(height: size.height(mobile: 130) + size.bottomPadding),
        ],
      ),
    );
  }
}
