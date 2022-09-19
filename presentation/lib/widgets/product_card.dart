import 'package:data/models/product_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import '../screens/product_details/product_details_screen.dart';
import 'custom_image.dart';

class ProductCard extends StatelessWidget {
  final ProductInfo product;
  final void Function(ProductInfo) onProductChange;
  const ProductCard({
    Key? key,
    required this.product,
    required this.onProductChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size size = Size(
          context: context,
          constrain: constraints,
          customModelHeight: 211,
          customModelWidth: 375,
        );
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              ProductDetailsScreen.route_name,
              arguments: <String, dynamic>{
                "product": product,
                "on-product-change": onProductChange
              },
            );
          },
          child: Container(
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                CustomImage(
                  imagePath: product.mainMediaUrl,
                  height: size.height(mobile: 150),
                  width: constraints.maxWidth,
                ),
                SizedBox(height: size.height(mobile: 10)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: size.width(mobile: 27)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: size.width(mobile: 250),
                            child: Text(
                              product.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                              textScaleFactor: 1,
                              softWrap: true,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(height: size.height(mobile: 8)),
                          Row(
                            children: <Widget>[
                              CustomImage(
                                imagePath: Dir.getIconPath("star-full"),
                                height: size.height(mobile: 20),
                              ),
                              SizedBox(width: size.width(mobile: 5)),
                              Text(
                                product.averageRate.toInt().toString(),
                                style: Theme.of(context).textTheme.bodySmall,
                                textScaleFactor: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (product.classification.isNotEmpty)
                        Text(
                          product.classification.first.price.getPrice,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Palette.primary_color,
                                  ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
