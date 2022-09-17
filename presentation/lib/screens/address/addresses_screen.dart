import 'package:data/models/address_info.dart';
import 'package:domain/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../config/config.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/widgets.dart';
import 'create_address_screen.dart';

class AddressesScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "addresses-screen";
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  bool selectable = Get.arguments.toString() == "true";
  RefreshController refreshController = RefreshController(initialRefresh: true);

  List<AddressInfo> addresses = <AddressInfo>[];

  int currentPage = 1;

  String? selectedAddress;

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
    addresses = await AddressServices()
        .getAll(
            lang: Get.locale?.languageCode,
            page: currentPage,
            token: Get.find<UserController>().token!.token.combinedToken)
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
    List<AddressInfo> res = await AddressServices()
        .getAll(
            lang: Get.locale?.languageCode,
            page: currentPage,
            token: Get.find<UserController>().token!.token.combinedToken)
        .catchError((dynamic error) {
      refreshController.loadComplete();
      errorHandler(error);
    });
    if (res.isEmpty) {
      refreshController.loadNoData();
      return;
    }
    addresses.addAll(res);
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
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.back(
                      result: selectable
                          ? addresses.firstWhereOrNull((AddressInfo element) =>
                              element.id == selectedAddress)
                          : null),
                  child: Container(
                    color: Colors.transparent,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(size.width(mobile: 14)),
                            child:
                                CustomImage(imagePath: Dir.getIconPath("back")),
                          ),
                          if (selectable)
                            Text(
                              "done".tr,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "shipping-locations".tr,
                style: Theme.of(context).textTheme.titleMedium,
                textScaleFactor: 1,
              ),
              const Spacer(),
            ],
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                Size size = Size(
                  context: context,
                  constrain: constraints,
                  customModelWidth: constraints.maxWidth,
                );
                return SmartRefresher(
                  controller: refreshController,
                  onLoading: load,
                  onRefresh: refresh,
                  header: const CustomRefreshHeader(),
                  footer: const CustomRefreshFooter(),
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width(mobile: 15)),
                    children: <Widget>[
                      SizedBox(height: size.height(mobile: 20)),
                      for (AddressInfo address in addresses)
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: size.height(mobile: 12)),
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width(mobile: 25),
                            vertical: size.height(mobile: 18),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(size.width(mobile: 8)),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.08),
                                blurRadius: 25,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: size.width(mobile: 260),
                                    child: Text(
                                      address.name,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        CreateAddressScreen.route_name,
                                        arguments: address,
                                      );
                                      refreshController.requestRefresh();
                                    },
                                    child: Text(
                                      "edit".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Palette.primary_color),
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height(mobile: 15)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    width: size.width(mobile: 220),
                                    child: Text(
                                      address.address,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      textScaleFactor: 1,
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Get.dialog(const Preloader());
                                      await AddressServices()
                                          .deleteItem(
                                        id: address.id,
                                        token: Get.find<UserController>()
                                            .token!
                                            .token
                                            .combinedToken,
                                        lang: Get.locale?.languageCode,
                                      )
                                          .catchError((dynamic error) {
                                        Get.back();
                                        errorHandler(error);
                                      });
                                      Get.back();
                                      refreshController.requestRefresh();
                                    },
                                    child: Text(
                                      "delete".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Palette.red_color),
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                ],
                              ),
                              if (selectable) ...<Widget>[
                                SizedBox(height: size.height(mobile: 14)),
                                buildCheckBox(
                                  size: size,
                                  label: "use-as-shipping".tr,
                                  checked: selectedAddress == address.id,
                                  onTap: () {
                                    if (selectedAddress == address.id) {
                                      selectedAddress = null;
                                    } else {
                                      selectedAddress = address.id;
                                    }
                                    setState(
                                      () {},
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                        )
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.toNamed(CreateAddressScreen.route_name);
          refreshController.requestRefresh();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: size.width(mobile: 52),
              height: size.width(mobile: 52),
              padding: EdgeInsets.all(size.width(mobile: 15)),
              decoration: const BoxDecoration(
                color: Palette.secondary_color,
                shape: BoxShape.circle,
              ),
              child: CustomImage(
                imagePath: Dir.getIconPath("add"),
                color: Colors.white,
              ),
            ),
            SizedBox(height: size.height(mobile: 15)),
            Text(
              "add-new-location".tr,
              style: Theme.of(context).textTheme.bodySmall,
              textScaleFactor: 1,
            ),
            SizedBox(height: size.height(mobile: 30) + size.bottomPadding),
          ],
        ),
      ),
    );
  }

  Widget buildCheckBox({
    required Size size,
    required String label,
    bool checked = false,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Container(
            width: size.width(mobile: 20),
            height: size.width(mobile: 20),
            padding: EdgeInsets.all(size.width(mobile: 2)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.width(mobile: 4)),
              border: checked
                  ? null
                  : Border.all(color: Palette.grey_color, width: 2),
              color: checked ? Palette.secondary_color : Colors.transparent,
            ),
            child: checked
                ? CustomImage(
                    imagePath: Dir.getIconPath("true"),
                    matchTextDirection: false,
                    color: Colors.white,
                  )
                : null,
          ),
          SizedBox(width: size.width(mobile: 15)),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
            textScaleFactor: 1,
          )
        ],
      ),
    );
  }
}
