import 'package:data/models/order_info.dart';
import 'package:domain/services/driver_order_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../config/config.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/widgets.dart';

class IncomingOrdersScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "incoming-orders-screen";
  const IncomingOrdersScreen({super.key});

  @override
  State<IncomingOrdersScreen> createState() => _IncomingOrdersScreenState();
}

class _IncomingOrdersScreenState extends State<IncomingOrdersScreen> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  int currentPage = 1;

  List<OrderInfo> orders = <OrderInfo>[];

  Future<void> refresh() async {
    if (refreshController.isLoading) {
      return;
    }
    // currentPage = 1;
    // orders = await CustomerOrderServices()
    //     .getAll(
    //   status: OrderStatus.orderNotApprovedYet,
    //   lang: Get.locale?.languageCode,
    //   page: currentPage,
    //   token: Get.find<UserController>().token?.token.combinedToken,
    // )
    //     .catchError((dynamic error) {
    //   refreshController.refreshFailed();
    //   errorHandler(error);
    // });
    refreshController.refreshCompleted();
    // setState(() {});
  }

  Future<void> load() async {
    if (refreshController.isRefresh) {
      return;
    }
    currentPage++;
    // List<OrderInfo> temp = await CustomerOrderServices()
    //     .getAll(
    //         status: OrderStatus.orderNotApprovedYet,
    //         lang: Get.locale?.languageCode,
    //         token: Get.find<UserController>().token?.token.combinedToken,
    //         page: currentPage)
    //     .catchError((dynamic error) {
    //   refreshController.loadFailed();
    //   errorHandler(error);
    // });
    // if (temp.isEmpty) {
    //   refreshController.loadNoData();
    //   return;
    // }
    // orders.addAll(temp);
    refreshController.loadComplete();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: size.topPadding),
          CustomAppBar(title: "incoming-orders".tr),
          Container(
            height: size.height(mobile: 1),
            width: double.infinity,
            color: Palette.primary_color,
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
                                horizontal: size.width(mobile: 30)),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 375,
                              childAspectRatio: 315 / 45,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 18,
                            ),
                            children: <Widget>[
                              for (OrderInfo order in orders)
                                LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    Size size = Size(
                                      context: context,
                                      constrain: constraints,
                                      customModelWidth: 315,
                                      customModelHeight: 45,
                                    );
                                    return Row(
                                      children: <Widget>[
                                        Container(
                                          width: size.width(mobile: 45),
                                          height: size.width(mobile: 45),
                                          padding: EdgeInsets.all(
                                              size.width(mobile: 9)),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Palette.primary_color),
                                            shape: BoxShape.circle,
                                          ),
                                          child: CustomImage(
                                              imagePath:
                                                  Dir.getIconPath("box")),
                                        ),
                                        SizedBox(width: size.width(mobile: 8)),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: size.width(mobile: 200),
                                              child: Text(
                                                order.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                textScaleFactor: 1,
                                              ),
                                            ),
                                            Text(
                                              order.total.getPrice,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color:
                                                          Palette.grey_color),
                                              textScaleFactor: 1,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            if (true) {
                                              return;
                                            }
                                            Get.dialog(const Preloader(),
                                                barrierDismissible: false);
                                            bool _ = await DriverOrderServices()
                                                .acceptOrder(
                                              token: Get.find<UserController>()
                                                  .token!
                                                  .token
                                                  .combinedToken,
                                              orderId: order.id,
                                              lang: Get.locale?.languageCode,
                                            )
                                                .catchError((dynamic error) {
                                              Get.back();
                                              errorHandler(error);
                                            });
                                            orders.remove(order);
                                            setState(() {});
                                          },
                                          child: Container(
                                            width: size.width(mobile: 35),
                                            height: size.width(mobile: 35),
                                            padding: EdgeInsets.all(
                                                size.width(mobile: 5)),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green,
                                            ),
                                            child: CustomImage(
                                              imagePath:
                                                  Dir.getIconPath("true"),
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
                                          ),
                                        ),
                                      ],
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
