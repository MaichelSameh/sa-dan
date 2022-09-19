import 'package:data/date_formatter.dart';
import 'package:data/enums.dart';
import 'package:data/models/order_info.dart';
import 'package:data/utils/string_util.dart';
import 'package:domain/services/customer_order_services.dart';
import 'package:domain/services/driver_order_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../config/config.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/widgets.dart';

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
    if (status == OrderStatus.incomingOrders) {
      orders = await DriverOrderServices()
          .getAll(
        lang: Get.locale?.languageCode,
        page: currentPage,
        token: Get.find<UserController>().token?.token.combinedToken,
      )
          .catchError((dynamic error) {
        refreshController.refreshFailed();
        errorHandler(error);
      });
    } else {
      orders = await CustomerOrderServices()
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
    }
    refreshController.refreshCompleted();
    setState(() {});
  }

  Future<void> load() async {
    if (refreshController.isRefresh) {
      return;
    }
    currentPage++;
    List<OrderInfo> temp = <OrderInfo>[];
    if (status == OrderStatus.incomingOrders) {
      temp = await DriverOrderServices()
          .getAll(
        lang: Get.locale?.languageCode,
        page: currentPage,
        token: Get.find<UserController>().token?.token.combinedToken,
      )
          .catchError((dynamic error) {
        refreshController.loadFailed();
        errorHandler(error);
      });
    } else {
      temp = await CustomerOrderServices()
          .getAll(
        status: status,
        lang: Get.locale?.languageCode,
        page: currentPage,
        token: Get.find<UserController>().token?.token.combinedToken,
      )
          .catchError((dynamic error) {
        refreshController.loadFailed();
        errorHandler(error);
      });
    }
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
          Container(
            height: size.height(mobile: 1),
            width: double.infinity,
            color: Palette.primary_color,
          ),
          SizedBox(height: size.height(mobile: 13)),
          Row(
            children: <Widget>[
              SizedBox(width: size.width(mobile: 4)),
              for (OrderStatus status in <OrderStatus>[
                OrderStatus.orderIsDelivered,
                OrderStatus.orderNotApprovedYet,
                if (Get.find<UserController>().token!.type == UserType.driver)
                  OrderStatus.incomingOrders,
              ])
                GestureDetector(
                  onTap: () {
                    if (status != this.status) {
                      this.status = status;
                      setState(() {});
                      refreshController.requestRefresh();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width(mobile: 15),
                      vertical: size.height(mobile: 5),
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: size.width(mobile: 4)),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: status == this.status
                              ? Palette.secondary_color
                              : Palette.primary_color),
                      color: status == this.status
                          ? Palette.secondary_color
                          : Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(size.width(mobile: 30)),
                    ),
                    child: Text(
                      status.name
                          .convertCamelCaseToUnderscore()
                          .replaceAll("_", "-")
                          .tr,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: status == this.status
                                ? Colors.white
                                : Palette.primary_color,
                          ),
                      textScaleFactor: 1,
                    ),
                  ),
                )
            ],
          ),
          SizedBox(height: size.height(mobile: 13)),
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
                : SmartRefresher(
                    onRefresh: refresh,
                    onLoading: load,
                    header: const CustomRefreshHeader(),
                    footer: const CustomRefreshFooter(),
                    enablePullUp: true,
                    controller: refreshController,
                    child: orders.isEmpty
                        ? const SizedBox()
                        : GridView(
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
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.14),
                                            blurRadius: 15,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                              height: size.height(mobile: 7)),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    size.width(mobile: 20)),
                                            child: Row(
                                              children: <Widget>[
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(size
                                                          .width(mobile: 45)),
                                                  child: CustomImage(
                                                    imagePath: order.product
                                                        .product.mainMediaUrl,
                                                    width:
                                                        size.width(mobile: 45),
                                                    height:
                                                        size.width(mobile: 45),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width:
                                                        size.width(mobile: 7)),
                                                SizedBox(
                                                  width:
                                                      size.width(mobile: 200),
                                                  child: Text(
                                                    order.product.product.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                    textScaleFactor: 1,
                                                    softWrap: true,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                Text(
                                                  dateFormatter(
                                                    order.createdAt,
                                                    pattern: "yyyy-MM-dd",
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  textScaleFactor: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                              height: size.height(mobile: 7)),
                                          Container(
                                            height: size.height(mobile: 1),
                                            width: double.infinity,
                                            color: Palette.grey_color,
                                          ),
                                          SizedBox(
                                              height: size.height(mobile: 10)),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    size.width(mobile: 20)),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  "quantity:".tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                  textScaleFactor: 1,
                                                ),
                                                Text(
                                                  order.product.quantity
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                  textScaleFactor: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                              height: size.height(mobile: 15)),
                                          Text(
                                            "total-price".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: Palette.grey_color),
                                            textScaleFactor: 1,
                                          ),
                                          SizedBox(
                                              height: size.height(mobile: 7)),
                                          Text(
                                            order.total.getPrice,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color:
                                                        Palette.primary_color),
                                            textScaleFactor: 1,
                                          ),
                                          SizedBox(
                                              height: size.height(mobile: 7)),
                                          Container(
                                            height: size.height(mobile: 1),
                                            width: double.infinity,
                                            color: Palette.grey_color,
                                          ),
                                          SizedBox(
                                              height: size.height(mobile: 15)),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Button(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width(mobile: 37),
                                                  vertical:
                                                      size.height(mobile: 4),
                                                ),
                                                color: Palette.secondary_color,
                                                child: Text(
                                                  order.status.name
                                                      .convertCamelCaseToUnderscore()
                                                      .replaceAll("_", "-")
                                                      .tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: Colors.white),
                                                  textScaleFactor: 1,
                                                ),
                                              ),
                                            ],
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
