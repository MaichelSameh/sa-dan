import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ScreenSize { pc, tablet, mobile }

class Size {
  double? _screenHeight;
  double? _screenWidth;

  ScreenSize get screenSize {
    return MediaQuery.of(_context).size.width < 800
        ? ScreenSize.mobile
        : MediaQuery.of(_context).size.width < 1000
            ? ScreenSize.tablet
            : ScreenSize.pc;
  }

  static double? _customModelHeight;
  static double? _customModelWidth;

  double get modelHeight {
    if (_customModelHeight != null) {
      return _customModelHeight!;
    }
    switch (screenSize) {
      case ScreenSize.pc:
        return 1200;
      case ScreenSize.tablet:
        return 1000;
      case ScreenSize.mobile:
        return 812;
    }
  }

  double get modelWidth {
    if (_customModelWidth != null) {
      return _customModelWidth!;
    }
    switch (screenSize) {
      case ScreenSize.pc:
        return 1900;
      case ScreenSize.tablet:
        return 1000;
      case ScreenSize.mobile:
        return 375;
    }
  }

  late final BuildContext _context;
  late final BoxConstraints? _constrain;

  Size({
    required BuildContext context,
    BoxConstraints? constrain,
    double? customModelHeight,
    double? customModelWidth,
  }) {
    _constrain = constrain;
    _context = context;
    _customModelHeight = customModelHeight;
    _customModelWidth = customModelWidth;
  }

  double get screenHeight {
    _screenHeight ??= MediaQuery.of(_context).size.height;
    return _screenHeight ?? 1;
  }

  double get screenWidth {
    _screenWidth ??= MediaQuery.of(_context).size.width;
    return _screenWidth ?? 1;
  }

  double get topPadding => MediaQuery.of(_context).padding.top;
  double get bottomPadding => defaultTargetPlatform == TargetPlatform.iOS
      ? 0
      : MediaQuery.of(_context).padding.bottom;
  double get leftPadding => MediaQuery.of(_context).padding.left;
  double get rightPadding => MediaQuery.of(_context).padding.right;

  double height({
    double? mobile,
    double? tablet,
    double? pc,
  }) {
    if (mobile == null && tablet == null && pc == null) {
      throw "you must assign at least one of the screen sizes to use this function";
    }
    double number;
    switch (screenSize) {
      case ScreenSize.pc:
        number = pc ?? tablet ?? mobile ?? 0;
        break;
      case ScreenSize.tablet:
        number = tablet ?? pc ?? mobile ?? 0;
        break;
      case ScreenSize.mobile:
        number = mobile ?? tablet ?? pc ?? 0;
        break;
    }
    double height = _constrain?.maxHeight ?? screenHeight;
    double result = height * (number / modelHeight);
    return result;
  }

  double width({
    double? mobile,
    double? tablet,
    double? pc,
  }) {
    if (mobile == null && tablet == null && pc == null) {
      throw "you must assign at least one of the screen sizes to use this function";
    }
    double number;
    switch (screenSize) {
      case ScreenSize.pc:
        number = pc ?? tablet ?? mobile ?? 0;
        break;
      case ScreenSize.tablet:
        number = tablet ?? pc ?? mobile ?? 0;
        break;
      case ScreenSize.mobile:
        number = mobile ?? tablet ?? pc ?? 0;
        break;
    }
    double width = _constrain?.maxWidth ?? screenWidth;
    return (width * (number / modelWidth)).abs();
  }
}
