import 'package:data/models/product_info.dart';
import 'package:data/models/store_info.dart';
import 'package:domain/services/store_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../config/config.dart';
import '../controllers/user_controller.dart';
import '../widgets/widgets.dart';
import 'menu_screen.dart';
import 'product_details_screen.dart';

class StoreDetailsScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "store-details-screen";
  const StoreDetailsScreen({super.key});

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  final StoreInfo store = Get.arguments;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  int currentPage = 1;

  List<ProductInfo> products = <ProductInfo>[];

  Future<void> refresh() async {
    if (refreshController.isLoading) {
      return;
    }
    currentPage = 1;
    products = await StoreServices()
        .getStoreProducts(
      id: store.id,
      lang: Get.locale?.languageCode,
      page: currentPage,
      token: Get.find<UserController>().token?.token.combinedToken,
    )
        .catchError((dynamic error) {
      refreshController.refreshFailed();
      errorHandler(error);
    });
    refreshController.refreshCompleted();
    setState(() {});
  }

  Future<void> load() async {
    if (refreshController.isRefresh) {
      return;
    }
    currentPage++;
    List<ProductInfo> temp = await StoreServices()
        .getStoreProducts(
            id: store.id,
            lang: Get.locale?.languageCode,
            token: Get.find<UserController>().token?.token.combinedToken,
            page: currentPage)
        .catchError((dynamic error) {
      refreshController.loadFailed();
      errorHandler(error);
    });
    if (temp.isEmpty) {
      refreshController.loadNoData();
      return;
    }
    products.addAll(temp);
    refreshController.loadComplete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: size.topPadding),
          Expanded(
            child: SmartRefresher(
              onRefresh: refresh,
              onLoading: load,
              header: const CustomRefreshHeader(),
              footer: const CustomRefreshFooter(),
              enablePullUp: true,
              controller: refreshController,
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              const MenuScreen(),
                              transition: Directionality.of(context) ==
                                      TextDirection.ltr
                                  ? Transition.leftToRight
                                  : Transition.rightToLeft,
                              opaque: false,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width(mobile: 25),
                              vertical: size.height(mobile: 15),
                            ),
                            color: Colors.transparent,
                            alignment: AlignmentDirectional.centerStart,
                            child:
                                CustomImage(imagePath: Dir.getIconPath("menu")),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width(mobile: 200),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  size.height(mobile: 40)),
                              child: CustomImage(
                                imagePath: store.logoUrl,
                                height: size.height(mobile: 40),
                                width: size.height(mobile: 40),
                              ),
                            ),
                            SizedBox(width: size.width(mobile: 5)),
                            Text(
                              store.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textScaleFactor: 1,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width(mobile: 25),
                            vertical: size.height(mobile: 15),
                          ),
                          color: Colors.transparent,
                          alignment: AlignmentDirectional.centerEnd,
                          child: CustomImage(
                              imagePath: Dir.getIconPath("notification")),
                        ),
                      ),
                    ],
                  ),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 375,
                      childAspectRatio: 375 / 211,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    children: <Widget>[
                      for (ProductInfo product in products)
                        LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
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
                                  arguments: product,
                                );
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  children: <Widget>[
                                    CustomImage(
                                      imagePath: product.mainMediaUrl,
                                      height: size.height(mobile: 163),
                                      width: constraints.maxWidth,
                                    ),
                                    SizedBox(height: size.height(mobile: 10)),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width(mobile: 27)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                width: size.width(mobile: 250),
                                                child: Text(
                                                  product.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  textScaleFactor: 1,
                                                  softWrap: true,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  CustomImage(
                                                    imagePath: Dir.getIconPath(
                                                        "star-full"),
                                                    height:
                                                        size.height(mobile: 9),
                                                  ),
                                                  SizedBox(
                                                      width: size.width(
                                                          mobile: 5)),
                                                  Text(
                                                    product.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                    textScaleFactor: 1,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          if (product.classification.isNotEmpty)
                                            Text(
                                              product.classification.first.price
                                                  .getPrice,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        Palette.primary_color,
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
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
