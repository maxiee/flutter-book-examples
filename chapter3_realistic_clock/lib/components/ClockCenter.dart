import 'package:flutter/material.dart';

class ClockCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0, 0),
            blurRadius: 3.0
          ),
          BoxShadow(
              color: Colors.grey[400],
              offset: const Offset(1.5, 1.5),
              blurRadius: 3.0
          )
        ]
      ),
    );
  }
}