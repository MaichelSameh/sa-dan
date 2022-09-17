import 'package:data/enums.dart';
import 'package:data/models/product_info.dart';
import 'package:domain/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../config/config.dart';
import '../controllers/user_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/widgets.dart';

class ProductsScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "products-screen";
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductSorting? productSorting = Get.arguments;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  int currentPage = 1;

  List<ProductInfo> products = <ProductInfo>[];

  Future<void> refresh() async {
    if (refreshController.isLoading) {
      return;
    }
    currentPage = 1;
    switch (productSorting) {
      case ProductSorting.mostPopular:
        products = await ProductServices()
            .getTopRated(
                lang: Get.locale?.languageCode,
                token: Get.find<UserController>().token?.token.combinedToken,
                page: currentPage)
            .catchError((dynamic error) {
          refreshController.loadFailed();
          errorHandler(error);
        });
        break;
      case ProductSorting.mostRecent:
        products = await ProductServices()
            .getTopSelling(
                lang: Get.locale?.languageCode,
                token: Get.find<UserController>().token?.token.combinedToken,
                page: currentPage)
            .catchError((dynamic error) {
          refreshController.loadFailed();
          errorHandler(error);
        });
        break;
      default:
        products = await ProductServices()
            .getAll(
                lang: Get.locale?.languageCode,
                token: Get.find<UserController>().token?.token.combinedToken,
                page: currentPage)
            .catchError((dynamic error) {
          refreshController.loadFailed();
          errorHandler(error);
        });
        break;
    }

    refreshController.refreshCompleted();
    setState(() {});
  }

  Future<void> load() async {
    if (refreshController.isRefresh) {
      return;
    }
    currentPage++;
    List<ProductInfo> temp = <ProductInfo>[];
    switch (productSorting) {
      case ProductSorting.mostPopular:
        temp = await ProductServices()
            .getTopRated(
                lang: Get.locale?.languageCode,
                token: Get.find<UserController>().token?.token.combinedToken,
                page: currentPage)
            .catchError((dynamic error) {
          refreshController.loadFailed();
          errorHandler(error);
        });
        break;
      case ProductSorting.mostRecent:
        temp = await ProductServices()
            .getTopSelling(
                lang: Get.locale?.languageCode,
                token: Get.find<UserController>().token?.token.combinedToken,
                page: currentPage)
            .catchError((dynamic error) {
          refreshController.loadFailed();
          errorHandler(error);
        });
        break;
      default:
        temp = await ProductServices()
            .getAll(
                lang: Get.locale?.languageCode,
                token: Get.find<UserController>().token?.token.combinedToken,
                page: currentPage)
            .catchError((dynamic error) {
          refreshController.loadFailed();
          errorHandler(error);
        });
        break;
    }

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
          const CustomAppBar(),
          Expanded(
            child: SmartRefresher(
              onRefresh: refresh,
              onLoading: load,
              header: const CustomRefreshHeader(),
              footer: const CustomRefreshFooter(),
              enablePullUp: true,
              controller: refreshController,
              child: GridView(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500,
                  childAspectRatio: 500 / 211,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: <Widget>[
                  for (ProductInfo product in products)
                    ProductCard(product: product),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
