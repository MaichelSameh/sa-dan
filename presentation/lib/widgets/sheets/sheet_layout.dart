import 'package:flutter/material.dart';

import '../../config/config.dart';

class SheetLayout extends StatelessWidget {
  final Widget body;
  final String? title;
  const SheetLayout({
    Key? key,
    required this.body,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Size(context);
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: size.height(mobile: 17)),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.width(mobile: 35)),
            topRight: Radius.circular(size.width(mobile: 35)),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: size.height(mobile: 6),
              width: size.width(mobile: 60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.height(mobile: 6)),
                color: Palette.grey_color,
              ),
            ),
            SizedBox(height: size.height(mobile: 15)),
            if (title != null)
              Text(
                title!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            body,
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
