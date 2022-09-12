import 'package:get/get.dart';

import 'controllers.dart';

void inject() {
  Get.put<UserController>(UserController());
  // Get.put<HomeController>(HomeController());
}
