import 'dart:math';

import 'package:flutter/material.dart';

class ClockHandSecond2 extends StatelessWidget {
  final Size clockSize;
  final int second;

  ClockHandSecond2(this.clockSize, this.second);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: clockSize,
      painter: SecondHandPainter(),
    );
  }
}

class SecondHandPainter extends CustomPainter {
  static const HAND_WIDTH = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    var handPaint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = HAND_WIDTH;
    var handStart = Offset(size.width * 0.5, size.height * 0.65);
    var handEnd = Offset(size.width * 0.5, size.height * 0.1);
    canvas.drawLine(handStart, handEnd, handPaint);

    var circlePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    var center = Offset(size.width * 0.5, size.height * 0.65);
    canvas.drawCircle(center, 6.0, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
