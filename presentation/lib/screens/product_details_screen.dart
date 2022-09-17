import 'package:data/enums.dart';
import 'package:data/models/address_info.dart';
import 'package:data/models/classification_info.dart';
import 'package:data/models/order_info.dart';
import 'package:data/models/price_info.dart';
import 'package:data/models/product_info.dart';
import 'package:domain/services/order_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import '../controllers/controllers.dart';
import '../widgets/widgets.dart';
import 'address/addresses_screen.dart';
import 'navigation/navigation_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "product-details-screen";
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductInfo product = Get.arguments;

  String? selectedClassificationId;

  AddressInfo? selectedAddress;

  int quantity = 1;

  @override
  void initState() {
    super.initState();
    if (product.classification.isNotEmpty) {
      selectedClassificationId = product.classification.first.classificationId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Palette.grey_color.withOpacity(0.5),
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500, minHeight: 0),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            Size size = Size(
              context: context,
              constrain: constraints,
              customModelWidth: constraints.maxWidth,
            );
            return Stack(
              children: <Widget>[
                product.mainMedia.isEmpty
                    ? CustomImage(
                        imagePath: Dir.getImagePath("image-placeholder"),
                        height: size.height(mobile: 346),
                        width: double.infinity,
                      )
                    : SizedBox(
                        height: size.height(mobile: 346),
                        child: PageView(
                          children: <Widget>[
                            for (String image in product.mainMedia)
                              CustomImage(
                                imagePath: image,
                                height: size.height(mobile: 346),
                              ),
                          ],
                        ),
                      ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: size.topPadding),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(size.width(mobile: 30)),
                        child: CustomImage(
                          imagePath: Dir.getIconPath("back"),
                          width: size.width(mobile: 10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height(mobile: 346) -
                          size.width(mobile: 88) -
                          size.height(mobile: 70) -
                          size.topPadding,
                    ),
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.only(top: size.width(mobile: 18)),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(size.width(mobile: 30)),
                                topRight:
                                    Radius.circular(size.width(mobile: 30)),
                              ),
                            ),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width(mobile: 27)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: size.height(mobile: 18)),
                                      Text(
                                        product.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                        textScaleFactor: 1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                  height:
                                                      size.height(mobile: 8)),
                                              RatingBar(
                                                ratingWidget: RatingWidget(
                                                  empty: CustomImage(
                                                      imagePath:
                                                          Dir.getIconPath(
                                                              "star-outline")),
                                                  full: CustomImage(
                                                      imagePath:
                                                          Dir.getIconPath(
                                                              "star-full")),
                                                  half: CustomImage(
                                                      imagePath:
                                                          Dir.getIconPath(
                                                              "star-half")),
                                                ),
                                                onRatingUpdate: (_) {},
                                                initialRating:
                                                    product.averageRate,
                                                ignoreGestures: true,
                                                itemSize:
                                                    size.width(mobile: 17),
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: size.width(
                                                            mobile: 3)),
                                              ),
                                              SizedBox(
                                                  height:
                                                      size.height(mobile: 8)),
                                              Text(
                                                "star-rating-count".trParams(
                                                  <String, String>{
                                                    "count": product.averageRate
                                                        .toInt()
                                                        .toString(),
                                                  },
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                product.classification
                                                        .firstWhereOrNull(
                                                            (ClassificationInfo
                                                                    element) =>
                                                                element
                                                                    .classificationId ==
                                                                selectedClassificationId)
                                                        ?.price
                                                        .getPrice ??
                                                    PriceInfo(price: 0)
                                                        .getPrice,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                        color: Palette
                                                            .secondary_color),
                                                textScaleFactor: 1,
                                              ),
                                              Text(
                                                "per-portion".tr,
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
                                        ],
                                      ),
                                      SizedBox(height: size.height(mobile: 20)),
                                      Text(
                                        "description".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        textScaleFactor: 1,
                                      ),
                                      SizedBox(height: size.height(mobile: 8)),
                                      HtmlWidget(
                                        product.description
                                            .replaceAll("\n", "<br>"),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      SizedBox(height: size.height(mobile: 20)),
                                      Text(
                                        "customize-order".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        textScaleFactor: 1,
                                      ),
                                      SizedBox(height: size.height(mobile: 8)),
                                      CustomDropdownButton<String>(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.width(mobile: 10),
                                          vertical: size.height(mobile: 10),
                                        ),
                                        borderRadius: 0,
                                        hide: true,
                                        value: selectedClassificationId,
                                        items: <
                                            CustomDropdownButtonItem<String>>[
                                          for (ClassificationInfo classification
                                              in product.classification)
                                            CustomDropdownButtonItem<String>(
                                              value: classification
                                                  .classificationId,
                                              child: Text(
                                                classification.size.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                                textScaleFactor: 1,
                                              ),
                                            ),
                                        ],
                                        onChange: (String newClassificationId) {
                                          setState(() {
                                            selectedClassificationId =
                                                newClassificationId;
                                          });
                                        },
                                      ),
                                      SizedBox(height: size.height(mobile: 8)),
                                      StatefulBuilder(builder:
                                          (BuildContext context,
                                              void Function(void Function())
                                                  setState) {
                                        return GestureDetector(
                                          onTap: () async {
                                            dynamic res = await Get.toNamed(
                                              AddressesScreen.route_name,
                                              arguments: true,
                                            );
                                            if (res is AddressInfo?) {
                                              selectedAddress = res;
                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  size.width(mobile: 10),
                                              vertical: size.height(mobile: 10),
                                            ),
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  247, 248, 249, 1),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                SizedBox(
                                                  width:
                                                      size.width(mobile: 280),
                                                  child: Text(
                                                    selectedAddress?.address ??
                                                        "select-shipping-location"
                                                            .tr,
                                                    style:
                                                        selectedAddress == null
                                                            ? Theme.of(context)
                                                                .textTheme
                                                                .labelSmall
                                                            : Theme.of(context)
                                                                .textTheme
                                                                .bodySmall,
                                                    textScaleFactor: 1,
                                                    softWrap: true,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                CustomImage(
                                                  imagePath:
                                                      Dir.getIconPath("next"),
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .color,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                      SizedBox(height: size.height(mobile: 20)),
                                      StatefulBuilder(
                                        builder: (BuildContext context,
                                            void Function(void Function())
                                                setState) {
                                          return Row(
                                            children: <Widget>[
                                              Text(
                                                "number-of-portion".tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                textScaleFactor: 1,
                                              ),
                                              const Spacer(),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      size.height(mobile: 5),
                                                  horizontal:
                                                      size.width(mobile: 12),
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Palette
                                                          .primary_color),
                                                  borderRadius:
                                                      BorderRadius.circular(size
                                                          .height(mobile: 20)),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (quantity <= 1) {
                                                          return;
                                                        }
                                                        quantity--;
                                                        setState(() {});
                                                      },
                                                      child: Opacity(
                                                        opacity: quantity <= 1
                                                            ? 0.7
                                                            : 1,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical:
                                                                size.height(
                                                                    mobile: 10),
                                                            horizontal:
                                                                size.width(
                                                                    mobile: 12),
                                                          ),
                                                          color: Colors
                                                              .transparent,
                                                          child: CustomImage(
                                                            imagePath:
                                                                Dir.getIconPath(
                                                                    "minus"),
                                                            color: Palette
                                                                .secondary_color,
                                                            width: size.width(
                                                                mobile: 10),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: size.width(
                                                            mobile: 5)),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: size.width(
                                                            mobile: 12),
                                                      ),
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Text(
                                                        quantity.toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                color: Palette
                                                                    .secondary_color),
                                                        textScaleFactor: 1,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: size.width(
                                                            mobile: 5)),
                                                    GestureDetector(
                                                      onTap: () {
                                                        quantity++;
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          vertical: size.height(
                                                              mobile: 5),
                                                          horizontal:
                                                              size.width(
                                                                  mobile: 12),
                                                        ),
                                                        color:
                                                            Colors.transparent,
                                                        child: CustomImage(
                                                          imagePath:
                                                              Dir.getIconPath(
                                                                  "add"),
                                                          color: Palette
                                                              .secondary_color,
                                                          width: size.width(
                                                              mobile: 10),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: size.height(mobile: 30)),
                                SizedBox(
                                  height: size.height(mobile: 175),
                                  child: Stack(
                                    alignment: AlignmentDirectional.centerStart,
                                    children: <Widget>[
                                      Container(
                                        width: size.width(mobile: 92),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Palette.secondary_color,
                                          borderRadius:
                                              BorderRadiusDirectional.only(
                                            topEnd: Radius.circular(
                                                size.width(mobile: 20)),
                                            bottomEnd: Radius.circular(
                                                size.width(mobile: 20)),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: size.width(mobile: 300),
                                        height: size.height(mobile: 125),
                                        margin: EdgeInsetsDirectional.only(
                                            start: size.width(mobile: 45)),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(
                                              size.width(mobile: 30)),
                                          boxShadow: const <BoxShadow>[
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.25),
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Button(
                                              onTap: () async {
                                                if (Get.find<UserController>()
                                                        .token ==
                                                    null) {
                                                  Get.dialog(
                                                      const LoginDialog());
                                                  return;
                                                }
                                                if (selectedClassificationId ==
                                                        null ||
                                                    selectedAddress == null) {
                                                  return;
                                                }
                                                Get.dialog(const Preloader());
                                                OrderInfo _ =
                                                    await OrderServices()
                                                        .makeOrder(
                                                  token:
                                                      Get.find<UserController>()
                                                          .token!
                                                          .token
                                                          .combinedToken,
                                                  addressId:
                                                      selectedAddress!.id,
                                                  classificationId:
                                                      selectedClassificationId!,
                                                  productId: product.id,
                                                  quantity: quantity,
                                                  paymentMethod:
                                                      PaymentMethod.cash,
                                                )
                                                        .catchError(
                                                            (dynamic error) {
                                                  Get.back();
                                                  errorHandler(error);
                                                });
                                                quantity = 1;
                                                setState(() {});
                                                Get.back();
                                                successHandler(
                                                    "ordered-successfully".tr);
                                              },
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    size.width(mobile: 35),
                                                vertical:
                                                    size.height(mobile: 8),
                                              ),
                                              radius: size.height(mobile: 10),
                                              child: Text(
                                                "order-now".tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor),
                                                textScaleFactor: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Opacity(
                                  opacity: 0,
                                  child: BottomNavBar(
                                    onPageChanged: (_) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //TODO add the favorite function
                            },
                            child: Container(
                              width: size.width(mobile: 36),
                              height: size.width(mobile: 36),
                              margin: EdgeInsetsDirectional.only(
                                  end: size.width(mobile: 22)),
                              padding: EdgeInsets.all(size.width(mobile: 12)),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                shape: BoxShape.circle,
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.08),
                                    blurRadius: 25,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: CustomImage(
                                  imagePath: Dir.getIconPath("love")),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                BottomNavBar(
                  onPageChanged: (int page) {
                    Get.toNamed(NavigationScreen.route_name, arguments: page);
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
