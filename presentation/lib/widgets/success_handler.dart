import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets.dart';

Future<void> successHandler(dynamic message) async {
  await Get.dialog(
    Builder(builder: (BuildContext context) {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomPaint(
                size: Size(90, (90 * 1).toDouble()),
                painter: _RPSCustomPainter(),
              ),
              const SizedBox(height: 24),
              Text(
                "success".tr,
                style: Theme.of(context).textTheme.titleMedium,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "$message".tr,
                style: Theme.of(context).textTheme.titleSmall!,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Button(
                onTap: Get.back,
                child: Text(
                  "okay".tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                  textScaleFactor: 1,
                ),
              )
            ],
          ),
        ),
      );
    }),
  );
}

class _RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path0 = Path();
    path0.moveTo(size.width * 0.9166667, size.height * 0.5000000);
    path0.cubicTo(
        size.width * 0.9166667,
        size.height * 0.7301042,
        size.width * 0.7301042,
        size.height * 0.9166667,
        size.width * 0.5000000,
        size.height * 0.9166667);
    path0.cubicTo(
        size.width * 0.2698958,
        size.height * 0.9166667,
        size.width * 0.08333333,
        size.height * 0.7301042,
        size.width * 0.08333333,
        size.height * 0.5000000);
    path0.cubicTo(
        size.width * 0.08333333,
        size.height * 0.2698958,
        size.width * 0.2698958,
        size.height * 0.08333333,
        size.width * 0.5000000,
        size.height * 0.08333333);
    path0.cubicTo(
        size.width * 0.7301042,
        size.height * 0.08333333,
        size.width * 0.9166667,
        size.height * 0.2698958,
        size.width * 0.9166667,
        size.height * 0.5000000);
    path0.close();

    Paint paint0 = Paint()..style = PaintingStyle.fill;
    paint0.color = const Color(0xff4caf50).withOpacity(1.0);
    canvas.drawPath(path0, paint0);

    Path path1 = Path();
    path1.moveTo(size.width * 0.7208750, size.height * 0.3042083);
    path1.lineTo(size.width * 0.4375000, size.height * 0.5874792);
    path1.lineTo(size.width * 0.3207917, size.height * 0.4708542);
    path1.lineTo(size.width * 0.2625208, size.height * 0.5291250);
    path1.lineTo(size.width * 0.4375000, size.height * 0.7041875);
    path1.lineTo(size.width * 0.7791250, size.height * 0.3624792);
    path1.lineTo(size.width * 0.7208750, size.height * 0.3042083);
    path1.close();

    Paint paint1 = Paint()..style = PaintingStyle.fill;
    paint1.color = const Color(0xffccff90).withOpacity(1.0);
    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
