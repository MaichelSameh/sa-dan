import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomRefreshHeader extends StatelessWidget {
  const CustomRefreshHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
      canTwoLevelText: "can-tow-level-text".tr,
      failedText: "load-failed-text".tr,
      idleText: "idle-loading-text".tr,
      refreshingText: "refreshing-text".tr,
      completeText: "refresh-complete-text".tr,
      releaseText: "can-refresh-text",
      textStyle: Theme.of(context).textTheme.bodySmall!,
    );
  }
}
