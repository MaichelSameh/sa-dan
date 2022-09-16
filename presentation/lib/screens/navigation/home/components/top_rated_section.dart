import 'package:data/models/product_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/config.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../widgets/widgets.dart';

class TopRatedSection extends StatefulWidget {
  const TopRatedSection({super.key});

  @override
  State<TopRatedSection> createState() => _TopRatedSectionState();
}

class _TopRatedSectionState extends State<TopRatedSection> {
  bool isLoaded = Get.find<HomeController>().isTopRatedProductsLoaded;

  @override
  void initState() {
    super.initState();
    Get.find<HomeController>().addListener(() {
      if (Get.find<HomeController>().isTopRatedProductsLoaded != isLoaded) {
        setState(() {
          isLoaded = Get.find<HomeController>().isTopRatedProductsLoaded;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context);
    return !isLoaded
        ? const Preloader()
        : Get.find<HomeController>().topRatedProducts.isEmpty
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
                          "top-rated".tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                          textScaleFactor: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            //TODO navigate to view all screen
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
                    Column(
                      children: <Widget>[
                        for (ProductInfo product
                            in Get.find<HomeController>().topRatedProducts)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    size.width(mobile: 20)),
                                child: CustomImage(
                                  imagePath: product.mainMediaUrl,
                                  width: double.infinity,
                                  height: size.height(mobile: 165),
                                ),
                              ),
                              SizedBox(height: size.height(mobile: 3)),
                              Text(
                                product.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: Get.locale?.languageCode == "ar"
                                          ? 10
                                          : 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                textScaleFactor: 1,
                              ),
                              Row(
                                children: <Widget>[
                                  CustomImage(
                                    imagePath: Dir.getIconPath("star-full"),
                                    height: size.height(mobile: 9),
                                  ),
                                  SizedBox(width: size.width(mobile: 3)),
                                  Text(
                                    product.averageRate.toInt().toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize:
                                                Get.locale?.languageCode == "ar"
                                                    ? 6
                                                    : 8),
                                  )
                                ],
                              )
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              );
  }
}
