import 'package:flutter/material.dart';

class ClockPanel2 extends StatelessWidget {
  final Size size;

  ClockPanel2(this.size);

  Widget getOuterPanel() {
    return Container(
        height: size.width,
        width: size.height,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset: const Offset(-5.0, -5.0),
                blurRadius: 15.0,
              ),
              BoxShadow(
                color: Colors.grey[400],
                offset: const Offset(5.0, 5.0),
                blurRadius: 15.0,
              ),
            ]
        )
    );
  }

  Widget getInnerPanel() {
    return Stack(
      children: <Widget>[
        Container(
          height: size.width * 0.9,
          width: size.height * 0.9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
            gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.grey[400]
                ],
                center: AlignmentDirectional(0.1, 0.1),
                focal: AlignmentDirectional(0.0, 0.0),
                radius: 0.65,
                focalRadius: 0.001,
                stops: [0.3, 1.0]
            ),
          ),
        ),
        Container(
          height: size.width * 0.9,
          width: size.height * 0.9,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
              gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white
                  ],
                  center: AlignmentDirectional(-0.1, -0.1),
                  focal: AlignmentDirectional(0.0, 0.0),
                  radius: 0.67,
                  focalRadius: 0.001,
                  stops: [0.75, 1.0]
              )
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        getOuterPanel(),
        getInnerPanel()
      ],
    );
  }
}

class ClockScalePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint scalePaint = Paint()
        ..color = Colors.black54
        ..strokeWidth = 3;

    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.12),
      Offset(size.width * 0.5, size.height * 0.06),
      scalePaint);

    canvas.drawLine(
        Offset(size.width * 0.5, size.height * 0.94),
        Offset(size.width * 0.5, size.height * 0.88),
        scalePaint);

    canvas.drawLine(
        Offset(size.width * 0.06, size.height * 0.5),
        Offset(size.width * 0.12, size.height * 0.5),
        scalePaint);

    canvas.drawLine(
        Offset(size.width * 0.88, size.height * 0.5),
        Offset(size.width * 0.94, size.height * 0.5),
        scalePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}