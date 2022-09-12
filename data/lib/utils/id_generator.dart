import 'dart:math';

import 'package:intl/intl.dart';

String idGenerator() {
  Random r = Random();
  String randomString = String.fromCharCodes(
      List<int>.generate(12, (int index) => r.nextInt(33) + 89));
  return DateFormat("yyyy-MM-dd HH:mm:ss.ssss").format(DateTime.now()) +
      randomString;
}
