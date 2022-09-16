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
    Size size = Size(context);
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
