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

  double get modelHeight {
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
    switch (screenSize) {
      case ScreenSize.pc:
        return 1900;
      case ScreenSize.tablet:
        return 1000;
      case ScreenSize.mobile:
        return 375;
    }
  }

  final BuildContext _context;
  final BoxConstraints _constrain;
  Size(
    this._context, [
    this._constrain = const BoxConstraints(maxHeight: 1, maxWidth: 1),
  ]);

  double get constrainMaxHeight {
    return _constrain.maxHeight == 1 ? screenHeight() : _constrain.maxHeight;
  }

  double get constrainMaxWidth {
    return _constrain.maxWidth == 1 ? screenWidth() : _constrain.maxWidth;
  }

  double screenHeight() {
    _screenHeight ??= MediaQuery.of(_context).size.height;
    return _screenHeight ?? 1;
  }

  double screenWidth() {
    _screenWidth ??= MediaQuery.of(_context).size.width;
    return _screenWidth ?? 1;
  }

  double get topPadding => MediaQuery.of(_context).padding.top;
  double get bottomPadding => MediaQuery.of(_context).padding.bottom;
  double get leftPadding => MediaQuery.of(_context).padding.left;
  double get rightPadding => MediaQuery.of(_context).padding.right;

  double height({
    double? mobile,
    double? tablet,
    double? pc,
    bool getFromScreenHeight = true,
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
    double height = getFromScreenHeight ? screenHeight() : constrainMaxHeight;
    double result = height * (number / modelHeight);
    return result;
  }

  double width({
    double? mobile,
    double? tablet,
    double? pc,
    bool getFromScreenHeight = true,
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
    double width = getFromScreenHeight ? screenWidth() : constrainMaxWidth;
    return width * (number / modelWidth);
  }
}
