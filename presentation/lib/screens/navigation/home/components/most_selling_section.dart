import 'package:data/enums.dart';
import 'package:data/models/product_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/config.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../widgets/widgets.dart';
import '../../../product_details/product_details_screen.dart';
import '../../../products_screen.dart';

class MostSellingSection extends StatefulWidget {
  const MostSellingSection({super.key});

  @override
  State<MostSellingSection> createState() => _MostSellingSectionState();
}

class _MostSellingSectionState extends State<MostSellingSection> {
  bool isLoaded = Get.find<HomeController>().isMostSellingProductsLoaded;

  @override
  void initState() {
    super.initState();
    Get.find<HomeController>().addListener(() {
      if (Get.find<HomeController>().isMostSellingProductsLoaded != isLoaded) {
        setState(() {
          isLoaded = Get.find<HomeController>().isMostSellingProductsLoaded;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return !isLoaded
        ? const Preloader()
        : Get.find<HomeController>().mostSellingProducts.isEmpty
            ? const SizedBox()
            : Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: size.width(mobile: 30)),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "most-popular".tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                          textScaleFactor: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              ProductsScreen.route_name,
                              arguments: ProductSorting.mostPopular,
                            );
                          },
                          child: Text(
                            "view-all".tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Palette.primary_color,
                                  fontWeight: FontWeight.normal,
                                ),
                            textScaleFactor: 1,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height(mobile: 13)),
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 160,
                        childAspectRatio: 160 / 133,
                        mainAxisSpacing: 13,
                        crossAxisSpacing: 13,
                      ),
                      children: <Widget>[
                        for (ProductInfo product
                            in Get.find<HomeController>().mostSellingProducts)
                          LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            Size size = Size(
                              context: context,
                              constrain: constraints,
                              customModelHeight: 133,
                              customModelWidth: 160,
                            );
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  ProductDetailsScreen.route_name,
                                  arguments: <String, dynamic>{
                                    "product": product,
                                    "on-product-change": (ProductInfo product) {
                                      Get.find<HomeController>()
                                              .mostSellingProducts[
                                          Get.find<HomeController>()
                                              .mostSellingProducts
                                              .indexWhere(
                                                  (ProductInfo element) =>
                                                      element.id ==
                                                      product.id)] = product;
                                    }
                                  },
                                );
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          size.width(mobile: 20)),
                                      child: CustomImage(
                                        imagePath: product.mainMediaUrl,
                                        width: constraints.maxWidth,
                                        height: size.height(mobile: 100),
                                      ),
                                    ),
                                    SizedBox(height: size.height(mobile: 3)),
                                    Text(
                                      product.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize:
                                                Get.locale?.languageCode == "ar"
                                                    ? 10
                                                    : 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      textScaleFactor: 1,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CustomImage(
                                          imagePath:
                                              Dir.getIconPath("star-full"),
                                          height: size.height(mobile: 9),
                                        ),
                                        SizedBox(width: size.width(mobile: 3)),
                                        Text(
                                          product.averageRate
                                              .toInt()
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontSize: Get.locale
                                                              ?.languageCode ==
                                                          "ar"
                                                      ? 6
                                                      : 8),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                      ],
                    ),
                  ],
                ),
              );
  }
}
