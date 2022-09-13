import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets.dart';

void errorHandler(dynamic message) {
  Get.dialog(
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
                "error".tr,
                style: Theme.of(context).textTheme.titleMedium,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "$message".tr,
                style: Theme.of(context).textTheme.titleSmall,
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
    Path path = Path();
    path.moveTo(size.width * 0.6198333, size.height * 0.1113333);
    path.arcToPoint(Offset(size.width * 0.3801667, size.height * 0.1113333),
        radius:
            Radius.elliptical(size.width * 0.1378750, size.height * 0.1378750),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path.lineTo(size.width * 0.01725000, size.height * 0.7579167);
    path.arcToPoint(Offset(size.width * 0.01845833, size.height * 0.8907917),
        radius:
            Radius.elliptical(size.width * 0.1324167, size.height * 0.1324167),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path.arcToPoint(Offset(size.width * 0.1370833, size.height * 0.9583333),
        radius:
            Radius.elliptical(size.width * 0.1360000, size.height * 0.1360000),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path.lineTo(size.width * 0.8629167, size.height * 0.9583333);
    path.arcToPoint(Offset(size.width * 0.9815417, size.height * 0.8907917),
        radius:
            Radius.elliptical(size.width * 0.1360000, size.height * 0.1360000),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path.arcToPoint(Offset(size.width * 0.9827500, size.height * 0.7579167),
        radius:
            Radius.elliptical(size.width * 0.1324167, size.height * 0.1324167),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path.close();
    path.moveTo(size.width * 0.5000000, size.height * 0.7916667);
    path.arcToPoint(Offset(size.width * 0.5416667, size.height * 0.7500000),
        radius: Radius.elliptical(
            size.width * 0.04166667, size.height * 0.04166667),
        rotation: 0,
        largeArc: true,
        clockwise: true);
    path.arcToPoint(Offset(size.width * 0.5000000, size.height * 0.7916667),
        radius: Radius.elliptical(
            size.width * 0.04166667, size.height * 0.04166667),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path.close();
    path.moveTo(size.width * 0.5416667, size.height * 0.5833333);
    path.arcToPoint(Offset(size.width * 0.4583333, size.height * 0.5833333),
        radius: Radius.elliptical(
            size.width * 0.04166667, size.height * 0.04166667),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path.lineTo(size.width * 0.4583333, size.height * 0.3333333);
    path.arcToPoint(Offset(size.width * 0.5416667, size.height * 0.3333333),
        radius: Radius.elliptical(
            size.width * 0.04166667, size.height * 0.04166667),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path.close();

    Paint paint = Paint()..style = PaintingStyle.fill;
    paint.color = const Color.fromRGBO(140, 31, 14, 1);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
