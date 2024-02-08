import 'package:flutter/material.dart';

import 'color_constants.dart';

const pointA = 0.3917;
const pointB = 0.35;
const pointC = 0.3917;
const pointD = 0.4334;
const pointE = 0.3917;

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = white;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height * pointA);
    path.quadraticBezierTo(size.width * 0.25, size.height * pointB,
        size.width * 0.5, size.height * pointC);
    path.quadraticBezierTo(size.width * 0.75, size.height * pointD,
        size.width * 1.0, size.height * pointE);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}