import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../widgets/widgets.dart';
import '../../menu_screen.dart';
import 'components/banners_section.dart';
import 'components/categories_section.dart';
import 'components/most_selling_section.dart';
import 'components/top_rated_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
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
          SizedBox(height: size.height(mobile: 13)),
          const CategoriesSection(),
          SizedBox(height: size.height(mobile: 13)),
          const TopRatedSection(),
          SizedBox(height: size.height(mobile: 13)),
          const MostSellingSection(),
          SizedBox(height: size.height(mobile: 120) + size.bottomPadding),
        ],
      ),
    );
  }
}
