import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomRefreshFooter extends StatelessWidget {
  const CustomRefreshFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      canLoadingText: "can-loading-text".tr,
      failedText: "load-failed-text".tr,
      idleText: "idle-loading-text".tr,
      loadingText: "loading-text".tr,
      noDataText: "no-more-text".tr,
      textStyle: Theme.of(context).textTheme.bodySmall!,
    );
  }
}
