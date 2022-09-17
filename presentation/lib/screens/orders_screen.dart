import 'package:data/enums.dart';
import 'package:data/models/order_info.dart';
import 'package:domain/services/order_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../config/config.dart';
import '../controllers/user_controller.dart';
import '../widgets/widgets.dart';

class OrdersScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "orders-screen";
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  OrderStatus status = OrderStatus.orderNotApprovedYet;

  int currentPage = 1;

  List<OrderInfo> orders = <OrderInfo>[];

  Future<void> refresh() async {
    if (refreshController.isLoading) {
      return;
    }
    currentPage = 1;
    orders = await OrderServices()
        .getAll(
      status: status,
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
    List<OrderInfo> temp = await OrderServices()
        .getAll(
            status: status,
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
    orders.addAll(temp);
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
          CustomAppBar(title: "my-orders".tr),
          SizedBox(height: size.height(mobile: 15)),
          Expanded(
            child: Get.find<UserController>().token == null
                ? Center(
                    child: Text(
                      "need-login".tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textScaleFactor: 1,
                      textAlign: TextAlign.center,
                    ),
                  )
                : orders.isEmpty
                    ? const SizedBox()
                    : SmartRefresher(
                        onRefresh: refresh,
                        onLoading: load,
                        header: const CustomRefreshHeader(),
                        footer: const CustomRefreshFooter(),
                        enablePullUp: true,
                        controller: refreshController,
                        child: GridView(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width(mobile: 20)),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 375,
                            childAspectRatio: 375 / 222,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          children: <Widget>[
                            for (OrderInfo order in orders)
                              LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  Size size = Size(
                                    context: context,
                                    constrain: constraints,
                                    customModelWidth: 375,
                                    customModelHeight: 222,
                                  );
                                  return Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(
                                          size.width(mobile: 15)),
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              151, 173, 182, 0.2)),
                                      boxShadow: const <BoxShadow>[
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.14),
                                          blurRadius: 15,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  size.width(mobile: 20)),
                                          child: Row(
                                            children: <Widget>[],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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
