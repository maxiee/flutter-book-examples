import 'package:flutter/material.dart';

class ClockCenterCircle extends StatelessWidget {
  final Size size;

  ClockCenterCircle(this.size);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: ClockCenterPainter(),
    );
  }
}

class ClockCenterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.black;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), 7, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}