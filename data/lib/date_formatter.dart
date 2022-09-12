import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String dateFormatter(
  DateTime date, {
  String? pattern,
  bool useLocalizedDate = false,
}) {
  initializeDateFormatting(Get.locale.toString());
  return DateFormat(pattern ?? "yyyy-MM-dd hh:mm:ss",
          useLocalizedDate ? Get.locale?.languageCode ?? "en" : "en")
      .format(date);
}

bool isRTL(String text) {
  return Bidi.detectRtlDirectionality(text);
}

String getReadableDurationFormat(Duration duration) {
  return (duration.inSeconds % 60 > 0
          ? (duration.inSeconds % 60).toString() + "sec".tr
          : "") +
      (duration.inMinutes % 60 > 0
          ? (duration.inMinutes % 60).toString() + "min".tr
          : "") +
      (duration.inHours % 24 > 0
          ? (duration.inHours % 24).toString() + "hour".tr
          : "");
}
