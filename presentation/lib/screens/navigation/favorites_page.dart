import 'package:data/models/product_info.dart';
import 'package:domain/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/widgets.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<ProductInfo> products = <ProductInfo>[];

  bool isLoading = true;
  List<String> currentlyChangingStateIds = <String>[];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    if (Get.find<UserController>().token == null) {
      isLoading = false;
      return;
    }

    products = await ProductServices()
        .listAllFavorites(
      token: Get.find<UserController>().token!.token.combinedToken,
      lang: Get.locale?.languageCode,
    )
        .catchError((dynamic error) {
      isLoading = false;
      setState(() {});
      errorHandler(error);
    });
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Column(
      children: <Widget>[
        SizedBox(height: size.topPadding),
        CustomAppBar(title: "favorites".tr),
        Container(
          height: size.height(mobile: 1),
          width: double.infinity,
          color: Palette.primary_color,
        ),
        SizedBox(height: size.height(mobile: 13)),
        Expanded(
          child: isLoading
              ? const Preloader()
              : Get.find<UserController>().token == null
                  ? Center(
                      child: Text(
                        "need-login".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : products.isEmpty
                      ? const SizedBox()
                      : StatefulBuilder(builder: (BuildContext context,
                          void Function(void Function()) setState) {
                          return GridView(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width(mobile: 30)),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 375,
                              childAspectRatio: 107 / 375,
                              mainAxisExtent: 107,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 20,
                            ),
                            children: <Widget>[
                              for (ProductInfo product in products)
                                LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    Size size = Size(
                                      context: context,
                                      constrain: constraints,
                                      customModelHeight: 107,
                                      customModelWidth: 375,
                                    );
                                    return Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width(mobile: 10),
                                        vertical: size.height(mobile: 11),
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            247, 248, 249, 1),
                                        borderRadius: BorderRadius.circular(
                                            size.width(mobile: 20)),
                                        border: Border.all(
                                            color: Palette.secondary_color),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                size.width(mobile: 15)),
                                            child: CustomImage(
                                              imagePath: product.mainMediaUrl,
                                              width: size.width(mobile: 88),
                                              height: size.height(mobile: 85),
                                            ),
                                          ),
                                          SizedBox(
                                              width: size.width(mobile: 13)),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width:
                                                        size.width(mobile: 200),
                                                    child: Text(
                                                      product.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      textScaleFactor: 1,
                                                      softWrap: true,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                  currentlyChangingStateIds
                                                          .contains(product.id)
                                                      ? SizedBox(
                                                          width: size.width(
                                                              mobile: 20),
                                                          height: size.width(
                                                              mobile: 20),
                                                          child: const Center(
                                                            child: Preloader(),
                                                          ),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () async {
                                                            currentlyChangingStateIds
                                                                .add(
                                                                    product.id);
                                                            setState(() {});
                                                            bool _ =
                                                                await ProductServices()
                                                                    .unfavorite(
                                                              id: product.id,
                                                              token: Get.find<
                                                                      UserController>()
                                                                  .token!
                                                                  .token
                                                                  .combinedToken,
                                                              lang: Get.locale
                                                                  ?.languageCode,
                                                            )
                                                                    .catchError(
                                                                        (dynamic
                                                                            error) {
                                                              currentlyChangingStateIds
                                                                  .remove(
                                                                      product
                                                                          .id);
                                                              errorHandler(
                                                                  error);
                                                            });
                                                            products.remove(
                                                                product);

                                                            currentlyChangingStateIds
                                                                .remove(
                                                                    product.id);
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    size.width(
                                                                        mobile:
                                                                            5)),
                                                            color: Colors
                                                                .transparent,
                                                            child: CustomImage(
                                                                imagePath: Dir
                                                                    .getIconPath(
                                                                        "trash")),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              if (product
                                                  .classification.isNotEmpty)
                                                Text(
                                                  product.classification.first
                                                      .price.getPrice,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Palette
                                                            .secondary_color,
                                                      ),
                                                  textScaleFactor: 1,
                                                  softWrap: true,
                                                  maxLines: 2,
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                            ],
                          );
                        }),
        ),
      ],
    );
  }
}
