import 'dart:math';

import 'package:flutter/material.dart';

enum ClockHandType {
  hour,
  minute
}

const clockHandParams = {
  ClockHandType.hour: {
    "lengthFactor": 0.32,
    "width": 5.0,
  },
  ClockHandType.minute: {
    "lengthFactor": 0.2,
    "width": 3.0,
  }
};

class ClockHand extends StatelessWidget {
  final Size clockSize;
  final ClockHandType handType;
  final int minute;
  final int hour;
  final int second;

  ClockHand(this.clockSize, this.handType,
            this.hour, this.minute, this.second);

  @override
  Widget build(BuildContext context) {
    double endAngle;

    if (handType == ClockHandType.minute) {
      endAngle = 2 * pi / 60 * minute + 2 * pi / 360 * 6 * (second / 60);
    } else if (handType == ClockHandType.hour) {
      endAngle = 2 * pi / 12 * hour + 2 * pi / 360 * 30 * (minute / 60);
    }

    return Transform.rotate(
      angle: endAngle,
      child: CustomPaint(
        size: clockSize,
        painter: ClockHandPainter(handType),
      ),
    );
  }
}

class ClockHandPainter extends CustomPainter {
  final ClockHandType handType;

  ClockHandPainter(this.handType);

  @override
  void paint(Canvas canvas, Size size) {
    final lengthFactor = clockHandParams[handType]['lengthFactor'];
    final width = clockHandParams[handType]['width'];

    // 表针绘制
    var handPaint = Paint()
      ..color = Colors.black54
      ..strokeCap = StrokeCap.round
      ..strokeWidth = width;

    var handStart = Offset(size.width * 0.5, size.height * 0.5);
    var handEnd = Offset(size.width * 0.5, size.height * lengthFactor);

    canvas.drawLine(handStart, handEnd, handPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}