import 'package:data/models/filter_info.dart';
import 'package:data/models/product_info.dart';
import 'package:domain/services/product_services.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../config/config.dart';
import '../controllers/user_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/widgets.dart';

class SearchProductsScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "search-products-screen";
  const SearchProductsScreen({Key? key}) : super(key: key);

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  FilterInfo filters =
      Get.arguments is FilterInfo ? Get.arguments : FilterInfo();

  int currentPage = 1;

  List<ProductInfo> products = <ProductInfo>[];

  RefreshController refreshController = RefreshController(initialRefresh: true);

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.text = filters.keyword ?? "";
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> refresh() async {
    if (refreshController.isLoading) {
      return;
    }
    currentPage = 1;
    products.clear();
    setState(() {});
    products = await ProductServices()
        .searchProducts(
      token: Get.find<UserController>().token?.token.combinedToken,
      lang: Get.locale?.languageCode,
      filters: filters,
      page: currentPage,
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
    List<ProductInfo> temp = await ProductServices()
        .searchProducts(
      token: Get.find<UserController>().token?.token.combinedToken,
      lang: Get.locale?.languageCode,
      filters: filters,
      page: currentPage,
    )
        .catchError((dynamic error) {
      refreshController.loadFailed();
      errorHandler(error);
    });
    if (temp.isEmpty) {
      refreshController.loadComplete();
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
          SizedBox(height: size.height(mobile: 10) + size.topPadding),
          const CustomAppBar(),
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
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Palette.primary_color),
              prefixWidget: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: size.height(mobile: 12)),
                child: CustomImage(imagePath: Dir.getIconPath("search")),
              ),
              onSubmit: (String text) {
                filters = filters.copyWith(keyword: text);
                refreshController.requestRefresh();
              },
            ),
          ),
          SizedBox(height: size.height(mobile: 13)),
          Expanded(
            child: SmartRefresher(
              onRefresh: refresh,
              onLoading: load,
              header: const CustomRefreshHeader(),
              footer: const CustomRefreshFooter(),
              enablePullUp: true,
              controller: refreshController,
              child: products.isNotEmpty
                  ? GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 500,
                        childAspectRatio: 375 / 211,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      children: <Widget>[
                        for (ProductInfo product in products)
                          ProductCard(
                            product: product,
                            onProductChange: (ProductInfo product) {
                              products[products.indexWhere(
                                  (ProductInfo element) =>
                                      element.id == product.id)] = product;
                            },
                          ),
                      ],
                    )
                  : !refreshController.isRefresh
                      ? SizedBox(
                          height: size.height(mobile: 300),
                          child: Center(
                            child: Text(
                              "no-products".tr,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textScaleFactor: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
