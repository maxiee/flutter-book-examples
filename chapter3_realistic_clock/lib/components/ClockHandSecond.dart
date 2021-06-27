import 'dart:math';

import 'package:flutter/material.dart';

class ClockHandSecond extends StatelessWidget {
  final Size clockSize;
  final int second;

  ClockHandSecond(this.clockSize, this.second);

  @override
  Widget build(BuildContext context) {
    debugPrint(second.toString());
    var beginAngle = 2 * pi / 60 * (second - 1);
    var endAngle = 2 * pi / 60 * second;
    debugPrint('beginAngle = ' + beginAngle.toString());
    debugPrint('endAngle = ' + endAngle.toString());

    if (second == 0) {
      return TweenAnimationBuilder<double>(
          key: ValueKey('prevent overlap'),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInQuint,
          tween: Tween<double>(begin: beginAngle, end: endAngle),
          builder: (context, anim, child) {
            return Transform.rotate(
              angle: anim,
              child: CustomPaint(
                size: clockSize,
                painter: SecondHandPainter(),
              ),
            );
          });
    }

    return TweenAnimationBuilder<double>(
        key: ValueKey('normal'),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInQuint,
        tween: Tween<double>(begin: beginAngle, end: endAngle),
        builder: (context, anim, child) {
          return Transform.rotate(
            angle: anim,
            child: CustomPaint(
              size: clockSize,
              painter: SecondHandPainter(),
            ),
          );
        });
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
