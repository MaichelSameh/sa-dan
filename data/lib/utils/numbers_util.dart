extension NumberUtil on String {
  double? toDouble() {
    return num.tryParse(this)?.toDouble();
  }

  int? toInt() {
    return num.tryParse(this)?.toInt();
  }
}
