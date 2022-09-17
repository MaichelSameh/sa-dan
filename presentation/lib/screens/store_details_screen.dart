import 'package:data/models/product_info.dart';
import 'package:data/models/store_info.dart';
import 'package:domain/services/store_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../config/config.dart';
import '../controllers/user_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/widgets.dart';

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
          CustomAppBar(title: store.name),
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
