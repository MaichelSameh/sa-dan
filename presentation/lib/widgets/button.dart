import 'package:flutter/material.dart';

import '../config/config.dart';

class Button extends StatelessWidget {
  final Color? color;
  final void Function()? onTap;
  final double? width;
  final double? height;
  final Widget? child;
  final double? radius;
  final EdgeInsets? padding;
  const Button({
    Key? key,
    this.color,
    this.onTap,
    this.width,
    this.height,
    this.child,
    this.radius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        onTap?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              height:
                  height ?? (padding == null ? size.height(mobile: 55) : null),
              width: width ?? (padding == null ? double.infinity : null),
              padding: padding,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(radius ?? size.height(mobile: 50)),
                color: color ?? Palette.primary_color,
              ),
              alignment: Alignment.center,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
