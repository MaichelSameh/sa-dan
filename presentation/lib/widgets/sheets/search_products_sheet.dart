import 'package:data/enums.dart';
import 'package:data/models/category_info.dart';
import 'package:data/models/filter_info.dart';
import 'package:data/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../controllers/home_controller.dart';
import '../widgets.dart';
import 'sheet_layout.dart';

Future<FilterInfo?> showSearchProductsSheet({
  required BuildContext context,
  FilterInfo? filter,
}) async {
  return await showModalBottomSheet(
    context: context,
    builder: (_) => SearchProductsSheet(
      filter: filter,
    ),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
  );
}

class SearchProductsSheet extends StatefulWidget {
  final FilterInfo? filter;
  const SearchProductsSheet({Key? key, this.filter}) : super(key: key);

  @override
  State<SearchProductsSheet> createState() => _SearchProductsSheetState();
}

class _SearchProductsSheetState extends State<SearchProductsSheet> {
  late FilterInfo filter;

  @override
  void initState() {
    filter = FilterInfo().copyFrom(filter: widget.filter);
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SheetLayout(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: size.height(mobile: 35)),
                Text(
                  "show-product-according-to".tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                  textScaleFactor: 1,
                ),
                SizedBox(height: size.height(mobile: 20)),
                SizedBox(height: size.height(mobile: 12)),
                Row(
                  children: <Widget>[
                    for (ProductSorting sorting in ProductSorting.values)
                      GestureDetector(
                        onTap: () {
                          if (filter.sorting == sorting) {
                            return;
                          }
                          filter = filter.copyWith(sorting: sorting);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height(mobile: 8),
                            horizontal: size.width(mobile: 15),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width(mobile: 10)),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.width(mobile: 5)),
                            border: Border.all(color: Palette.secondary_color),
                            color: filter.sorting == sorting
                                ? Palette.secondary_color
                                : null,
                          ),
                          child: Text(
                            sorting.name
                                .convertCamelCaseToUnderscore()
                                .replaceAll("_", "-")
                                .tr,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: filter.sorting == sorting
                                          ? Colors.white
                                          : null,
                                    ),
                            textScaleFactor: 1,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: size.height(mobile: 20)),
                Text(
                  "categories".tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textScaleFactor: 1,
                ),
                for (CategoryInfo category
                    in Get.find<HomeController>().categories)
                  GestureDetector(
                    onTap: () {
                      if (filter.categorizationId == category.id) {
                        filter = filter.copyWith(categorizationId: null);
                        setState(() {});
                      } else {
                        filter = filter.copyWith(categorizationId: category.id);
                        setState(() {});
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: size.height(mobile: 10)),
                      color: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: size.width(mobile: 17),
                            height: size.height(mobile: 17),
                            padding: EdgeInsets.all(size.width(mobile: 2)),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Palette.secondary_color),
                            ),
                            child: filter.categorizationId == category.id
                                ? Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Palette.secondary_color,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : null,
                          ),
                          SizedBox(width: size.width(mobile: 10)),
                          Text(
                            category.name
                                .convertCamelCaseToUnderscore()
                                .replaceAll("_", "-")
                                .tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: filter.categorizationId == category.id
                                      ? Colors.white
                                      : null,
                                ),
                            textScaleFactor: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: size.height(mobile: 20)),
                Button(
                  onTap: () {
                    Get.back(result: filter);
                  },
                  height: size.height(mobile: 40),
                  radius: size.width(mobile: 7),
                  child: Text(
                    "apply".tr,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                    textScaleFactor: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
