import 'package:data/models/filter_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../controllers/controllers.dart';
import '../../../widgets/widgets.dart';
import '../../search_products_screen.dart';
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
  void initState() {
    super.initState();
    Get.find<HomeController>().init();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: size.height(mobile: 15) + size.topPadding),
          const CustomAppBar(),
          SizedBox(height: size.height(mobile: 13)),
          const BannersSection(),
          SizedBox(height: size.height(mobile: 13)),
          Center(
            child: CustomTextFormField(
              width: size.width(mobile: 300),
              height: 40,
              padding: EdgeInsets.symmetric(
                horizontal: size.width(mobile: 12),
              ),
              controller: searchController,
              textInputAction: TextInputAction.search,
              hint: "search-hint".tr,
              style: Theme.of(context).textTheme.bodySmall,
              hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Palette.primary_color,
                  ),
              prefixWidget: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: size.height(mobile: 12)),
                child: CustomImage(imagePath: Dir.getIconPath("search")),
              ),
              onSubmit: (String text) {
                Get.toNamed(
                  SearchProductsScreen.route_name,
                  arguments: FilterInfo(keyword: text),
                );
                searchController.clear();
              },
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
