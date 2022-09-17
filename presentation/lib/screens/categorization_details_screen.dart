import 'package:data/models/models.dart';
import 'package:domain/services/category_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../config/config.dart';
import '../controllers/user_controller.dart';
import '../widgets/widgets.dart';
import 'menu_screen.dart';
import 'screens.dart';

class CategorizationDetailsScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "categorization-details-screen";
  const CategorizationDetailsScreen({super.key});

  @override
  State<CategorizationDetailsScreen> createState() =>
      _CategorizationDetailsScreenState();
}

class _CategorizationDetailsScreenState
    extends State<CategorizationDetailsScreen> {
  final CategoryInfo category = Get.arguments;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  final TextEditingController searchController = TextEditingController();

  int currentPage = 1;

  List<StoreInfo> stores = <StoreInfo>[];

  Future<void> refresh() async {
    if (refreshController.isLoading) {
      return;
    }
    currentPage = 1;
    stores = await CategoryServices()
        .getCategoryStores(
            id: category.id,
            lang: Get.locale?.languageCode,
            token: Get.find<UserController>().token?.token.combinedToken,
            page: currentPage)
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
    List<StoreInfo> temp = await CategoryServices()
        .getCategoryStores(
            id: category.id,
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
    stores.addAll(temp);
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
                padding: EdgeInsets.zero,
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
                        child: Text(
                          category.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textScaleFactor: 1,
                          textAlign: TextAlign.center,
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
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Palette.secondary_color,
                  ),
                  SizedBox(height: size.height(mobile: 17)),
                  Center(
                    child: CustomTextFormField(
                      width: size.width(mobile: 260),
                      height: 30,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width(mobile: 12),
                      ),
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      hint: "search-for".trParams(
                        <String, String>{
                          "for": category.name,
                        },
                      ),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: Get.locale?.languageCode == "ar" ? 6 : 8),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(
                            fontSize: Get.locale?.languageCode == "ar" ? 6 : 8,
                            color: Palette.primary_color,
                          ),
                      prefixWidget: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height(mobile: 6)),
                        child:
                            CustomImage(imagePath: Dir.getIconPath("search")),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height(mobile: 20)),
                  GridView(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width(mobile: 10)),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 170,
                      childAspectRatio: 170 / 180,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    children: <Widget>[
                      for (StoreInfo store in stores)
                        LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            Size size = Size(
                              context: context,
                              constrain: constraints,
                              customModelHeight: 180,
                              customModelWidth: 170,
                            );
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  StoreDetailsScreen.route_name,
                                  arguments: store,
                                );
                              },
                              child: Container(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(247, 248, 249, 0),
                                    borderRadius: BorderRadius.circular(
                                        size.width(mobile: 30)),
                                    border: Border.all(
                                        color: Palette.primary_color)),
                                child: Column(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            size.width(mobile: 30)),
                                        topRight: Radius.circular(
                                            size.width(mobile: 30)),
                                      ),
                                      child: CustomImage(
                                        imagePath: store.logoUrl,
                                        width: double.infinity,
                                        height: size.height(mobile: 110),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height(mobile: 60),
                                      width: constraints.maxWidth,
                                      child: Center(
                                        child: Text(
                                          store.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: Palette.primary_color,
                                                fontWeight: FontWeight.w600,
                                              ),
                                          textScaleFactor: 1,
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                          maxLines: 2,
                                        ),
                                      ),
                                    )
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
